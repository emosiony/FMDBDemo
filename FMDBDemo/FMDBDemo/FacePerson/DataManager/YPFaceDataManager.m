//
//  YPFaceDataManager.m
//  FMDBDemo
//
//  Created by 姚敦鹏 on 2019/4/4.
//  Copyright © 2019 EMoisiony. All rights reserved.
//

#import "YPFaceDataManager.h"
#import <FMDB.h>

static YPFaceDataManager *_instance;
#define DB_NAME @"yp_face"

@interface YPFaceDataManager ()

@property (nonatomic,strong) FMDatabaseQueue *fmdQueue;
@property (nonatomic,strong) FMDatabase *fmdDB;

@end

@implementation YPFaceDataManager

+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        NSString *dbPath = [self getDBPath];
        _fmdQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        
        if (_fmdQueue) {
            NSLog(@"创建成功");
            
        } else {
            NSLog(@"数据库创建失败");
        }
    }
    return self;
}

#pragma mark -- public
-(void)insertFace:(YPFacePerson *)face complete:(void(^)(BOOL))complete {
    
    [self.fmdQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            
            NSString *sql = [NSString stringWithFormat:@"insert into %@ (userId, courseId, imageWidth, imageHeight, name, faceImageData, faceImageUrl) values (%@, %@, %@, %@, %@, %@, %@)", DB_NAME, face.userId,  face.courseId, face.imageWidth, face.imageHeight, face.name, face.faceImageData, face.faceImageUrl];
            BOOL isOk = [db executeUpdate:sql];
            complete ? complete(isOk) : nil;
        }
        [db close];
    }];
}


#pragma mark -- 删除
-(void)deleteFaceWithFaceImageUrl:(NSString *)faceImageUrl complete:(void(^)(BOOL))complete {
    
    [self.fmdQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where faceImageUrl = %@", DB_NAME, faceImageUrl];
            BOOL isOk = [db executeUpdate:sql];
            complete ? complete(isOk) : nil;
        }
        [db close];
    }];
}

-(void)deleteFaceWithFaceID:(NSString *)faceID complete:(void(^)(BOOL))complete {
    
    [self.fmdQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where id = %@", DB_NAME, faceID];
            BOOL isOk = [db executeUpdate:sql];
            complete ? complete(isOk) : nil;
        }
        [db close];
    }];
}

#pragma mark -- 查询
-(void)findFaceWithFaceID:(NSString *)faceID complete:(void(^)(NSMutableArray *))complete {
    
    [self.fmdQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            
            NSString *sql = [NSString stringWithFormat:@"select from %@ where id = %@", DB_NAME, faceID];
            FMResultSet *resultSet = [db executeQuery:sql];
            
            NSMutableArray *persons = [NSMutableArray array];
            while ([resultSet next]) {
                YPFacePerson *person = [self fmResultSet2FacePerson:resultSet];
                [persons addObject:person];
            }
            
            complete ? complete(persons) : nil;
        }
        [db close];
    }];
}

-(void)findFaceWithFaceImageUrl:(NSString *)faceImageUrl complete:(void(^)(BOOL))complete {
    
    [self.fmdQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            
            NSString *sql = [NSString stringWithFormat:@"select from %@ where faceImageUrl = %@", DB_NAME, faceImageUrl];
            FMResultSet *resultSet = [db executeQuery:sql];
            
            NSMutableArray *persons = [NSMutableArray array];
            while ([resultSet next]) {
                YPFacePerson *person = [self fmResultSet2FacePerson:resultSet];
                [persons addObject:person];
            }
            
            complete ? complete(persons) : nil;
        }
        [db close];
    }];
}

-(void)findFaceWithFaceImageUrl:(NSString *)faceImageUrl withCourseID:(NSNumber *)courseID complete:(void(^)(BOOL))complete {
    
    [self.fmdQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            
            NSString *sql = [NSString stringWithFormat:@"select from %@ where faceImageUrl = %@ and courseId = %@", DB_NAME, faceImageUrl, courseID];
            FMResultSet *resultSet = [db executeQuery:sql];
            
            NSMutableArray *persons = [NSMutableArray array];
            while ([resultSet next]) {
                YPFacePerson *person = [self fmResultSet2FacePerson:resultSet];
                [persons addObject:person];
            }
            
            complete ? complete(persons) : nil;
        }
        [db close];
    }];
}

-(YPFacePerson *)fmResultSet2FacePerson:(FMResultSet *)resultSet {
    
    NSInteger faceId        = [resultSet longLongIntForColumn:@"id"];
    NSInteger personId      = [resultSet longLongIntForColumn:@"personId"];
    NSString  *name         = [resultSet stringForColumn:@"name"];
    NSData *faceImageData   = [resultSet dataForColumn:@"name"];
    NSString *faceImageUrl  = [resultSet stringForColumn:@"faceImageUrl"];
    NSInteger imageWidth    = [resultSet doubleForColumn:@"imageWidth"];
    NSInteger imageHeight   = [resultSet doubleForColumn:@"imageHeight"];
    NSInteger userId        = [resultSet longLongIntForColumn:@"userId"];
    NSInteger courseId      = [resultSet longLongIntForColumn:@"courseId"];

    YPFacePerson *person = [YPFacePerson modelWithID:@(faceId)
                                            personID:@(personId)
                                                name:name
                                       faceImageData:faceImageData
                                        faceImageUrl:faceImageUrl
                                          imageWidth:@(imageWidth)
                                         imageHeight:@(imageHeight)
                                              userId:@(userId)
                                            courseId:@(courseId)];
    return person;
}


#pragma mark -- private
-(void)createFaceTable {
    
    __weak typeof(self) weakSelf = self;
    [self.fmdQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        weakSelf.fmdDB = db;
        
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, userId integer not null, courseId integer, imageWidth integer, imageHeight integer, name text, faceImageData blob, faceImageUrl text);", DB_NAME];
        BOOL isSuc = [db executeStatements:sql];
        
        NSLog(@"人脸数据库初始化 --> %@", isSuc ? @"成功" : @"失败");
    }];
}

-(NSString *)getDBPath {
    
    return [[self docmentPath] stringByAppendingFormat:@"YPFace/%@.db",DB_NAME];
}

-(NSString *)docmentPath {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

@end
