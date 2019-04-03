//
//  YPFaceDataManager.h
//  FMDBDemo
//
//  Created by 姚敦鹏 on 2019/4/4.
//  Copyright © 2019 EMoisiony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPFacePerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPFaceDataManager : NSObject


#pragma mark -- 增加
/**
 增加数据

 @param face YPFacePerson model
 @param complete 结果
 */
-(void)insertFace:(YPFacePerson *)face complete:(void(^)(BOOL))complete;


#pragma mark -- 删除
/**
 查询 -- 根据 faceImageUrl
 
 @param faceImageUrl 图片url
 @param complete 结果
 */
-(void)deleteFaceWithFaceImageUrl:(NSString *)faceImageUrl complete:(void(^)(BOOL))complete;

/**
 删除 -- 根据 id
 
 @param faceID id
 @param complete 结果
 */
-(void)deleteFaceWithFaceID:(NSString *)faceID complete:(void(^)(BOOL))complete;


#pragma mark -- 查询
/**
 查询 -- 根据 id
 
 @param faceID id
 @param complete 结果
 */
-(void)findFaceWithFaceID:(NSString *)faceID complete:(void(^)(NSMutableArray *))complete;

/**
 查询 -- 根据 faceImageUrl
 
 @param faceImageUrl 图片url
 @param complete 结果
 */
-(void)findFaceWithFaceImageUrl:(NSString *)faceImageUrl complete:(void(^)(BOOL))complete;


/**
 查询 -- 根据 faceImageUrl and courseID

 @param faceImageUrl 图片url
 @param courseID 课程id
 @param complete 结果
 */
-(void)findFaceWithFaceImageUrl:(NSString *)faceImageUrl
                   withCourseID:(NSNumber *)courseID
                       complete:(void(^)(BOOL))complete;

+(instancetype)shareManager;

@end

NS_ASSUME_NONNULL_END
