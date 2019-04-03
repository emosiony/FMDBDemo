//
//  YPFacePerson.h
//  FMDBDemo
//
//  Created by 姚敦鹏 on 2019/4/4.
//  Copyright © 2019 EMoisiony. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPFacePerson : NSObject

/** 数据库唯一 ID */
@property (nonatomic,copy) NSNumber *ID;

/** 人脸 ID */
@property (nonatomic,copy) NSNumber *personId;

/** 人名称 */
@property (nonatomic,copy) NSString *name;

/** 人脸图片 Data */
@property (nonatomic,copy) NSData   *faceImageData;

/** 人脸图片 url */
@property (nonatomic,copy) NSString *faceImageUrl;

/** 人脸图片 宽 */
@property (nonatomic,copy) NSNumber *imageWidth;

/** 人脸图片 高 */
@property (nonatomic,copy) NSNumber *imageHeight;

/** 用户 ID */
@property (nonatomic,copy) NSNumber *userId;

/** 课程 ID */
@property (nonatomic,copy) NSNumber *courseId;



#pragma mark -- methed

+(instancetype)modelWithID:(NSNumber *)faceId
                  personID:(NSNumber *)personID
                      name:(NSString *)name
             faceImageData:(NSData *)faceImageData
              faceImageUrl:(NSString *)faceImageUrl
                imageWidth:(NSNumber *)imageWidth
               imageHeight:(NSNumber *)imageHeight
                    userId:(NSNumber *)userId
                  courseId:(NSNumber *)courseId;


@end

NS_ASSUME_NONNULL_END
