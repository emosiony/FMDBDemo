//
//  YPFacePerson.m
//  FMDBDemo
//
//  Created by 姚敦鹏 on 2019/4/4.
//  Copyright © 2019 EMoisiony. All rights reserved.
//

#import "YPFacePerson.h"

@implementation YPFacePerson

+ (instancetype)modelWithID:(NSNumber *)faceId
                   personID:(NSNumber *)personID
                       name:(NSString *)name
              faceImageData:(NSData *)faceImageData
               faceImageUrl:(NSString *)faceImageUrl
                 imageWidth:(NSNumber *)imageWidth
                imageHeight:(NSNumber *)imageHeight
                     userId:(NSNumber *)userId
                   courseId:(NSNumber *)courseId
{
    return [[self alloc] initWithID:faceId
                           personID:personID
                               name:name
                      faceImageData:faceImageData
                       faceImageUrl:faceImageUrl
                         imageWidth:imageWidth
                        imageHeight:imageHeight
                             userId:userId
                           courseId:courseId];
}

- (instancetype)initWithID:(NSNumber *)faceId
                  personID:(NSNumber *)personID
                      name:(NSString *)name
             faceImageData:(NSData *)faceImageData
              faceImageUrl:(NSString *)faceImageUrl
                imageWidth:(NSNumber *)imageWidth
               imageHeight:(NSNumber *)imageHeight
                    userId:(NSNumber *)userId
                  courseId:(NSNumber *)courseId
{
    if (self = [super init]) {
        
        _ID             = faceId;
        _personId       = personID;
        _name 	        = name;
        _faceImageData  = faceImageData;
        _faceImageUrl   = faceImageUrl;
        _imageWidth 	= imageWidth;
        _imageHeight 	= imageHeight;
        _userId         = userId;
        _courseId       = courseId;
    }
    return self;
}

@end
