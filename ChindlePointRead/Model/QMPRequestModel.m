//
//  ZCSRequestModel.m
//  ZhiChengSchoolProject
//
//  Created by mac on 2020/10/22.
//  Copyright © 2020 com.chindle.talk915. All rights reserved.
//

#import "QMPRequestModel.h"

@interface QMPRequestModel ()
@end

@implementation QMPRequestModel

+(instancetype)initRequestModelWithResponseObject:(id)responseObject{
    QMPRequestModel *model = [[QMPRequestModel alloc] init];
    model.responseObject = responseObject;
    return model;
}

- (NSInteger)resultCode{
    return [self.responseObject[@"code"] integerValue];
}

- (NSInteger)totalCount{
    return [self.responseObject[@"totalCount"] integerValue];
}

-(NSString *)resultMessage{
    NSString *resultMsg = self.responseObject[@"msg"];
    return resultMsg;
}

- (id)resultData{
    return self.responseObject[@"data"];;
}

-(void)handleResponseObjectWithResultCode:(void(^)(id resultData))complete{
    if(self.resultCode == 200){
        complete(self.resultData);
    }else{
        if(self.resultCode == -1){//跳转到注册
//            [TRequestManager exitAccountAndReminderWithError:[[NSError alloc] init]];
        }else{
            //提示语
            NSString *toast = [NSString stringWithFormat:@"%@",self.resultMessage];
//            [[UIView tes_getRootViewController].view makeToast:toast duration:2.0 position:CSToastPositionCenter];
        }
    }
}
@end
