//
//  ZCSRequestModel.h
//  ZhiChengSchoolProject
//
//  Created by mac on 2020/10/22.
//  Copyright © 2020 com.chindle.talk915. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMPRequestModel : NSObject

@property(nonatomic,assign) NSInteger resultCode;

@property (nonatomic, strong) id responseObject;

@property(nonatomic,strong) id resultData;

@property(nonatomic,copy) NSString *resultMessage;

@property(nonatomic,assign) NSInteger totalCount;

+(instancetype)initRequestModelWithResponseObject:(id)responseObject;

-(void)handleResponseObjectWithResultCode:(void(^)(id resultData))complete;

@end

NS_ASSUME_NONNULL_END
