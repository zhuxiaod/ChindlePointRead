//
//  TESRequestManager.m
//  NewTalkEnglishStudentProject
//
//  Created by mac on 2020/12/4.
//

#import "QMPRequestManager.h"
#import "QMPRequestModel.h"
#import "QMPNetworkConstant.h"

@interface QMPRequestManager ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation QMPRequestManager

/************************** Common ****************************/
+ (AFHTTPSessionManager *)manager{
    
    static AFHTTPSessionManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiLmsLjov5zmmbTlpKkiLCJhdmF0YXJVcmwiOiJodHRwczovL3RoaXJkd3gucWxvZ28uY24vbW1vcGVuL3ZpXzMyL2trZzRXVkZwbGdPb3J5TlNNaWJWa3IwaksybXJPQ3lVU0pYWFVRdjRMeko2eFRXTVhoWFdzc2huYzBLR1RUVGdrRzZCa1lPMWRCaWNpY2FaR0JVbHBLYXNnLzEzMiIsIm9wZW5pZCI6Im9zWDNjNHVIaXRYSDNMZDJfRG96X2xPZm9qbzAiLCJpc3MiOiJERVNLVE9QLUc4TTQyNTIiLCJzZXNzaW9uX2tleSI6ImhzR2d2UHVwY3pJRmg3QjExSHFUZ2c9PSIsImV4cCI6MTYxMDY5NzM5NzUxNCwiaWF0IjoxNjEwNjkwMTk3NTE0LCJqdGkiOjEzNDk5NTg1ODE3MTg3MjA1MTR9.rX1hxdNlubpHlNwQW5gzu56VSlsap6yldmkfhamC72-ZTptPwhL3BRxRnX02sIltJdAy31swHLhLJFSH7BYjRg" forHTTPHeaderField:@"Authorization"];
        //Authentication Authorization
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/x-www-form-urlencoded",@"text/html",@"text/plain", nil];
        manager.requestSerializer.timeoutInterval = 8;
    });
    
    return manager;
}

//Post
+(void)POST:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSString *requestString = [NSString stringWithFormat:@"%@/%@",qmp_host,URLString];
    
    [[self manager] POST:requestString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [QMPRequestManager exitAccountAndReminderWithError:error];
        

        failure(error);
    }];
}

//GET
+(void)GET:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSString *requestString = [NSString stringWithFormat:@"%@/%@",qmp_host,URLString];
    
    [[self manager] GET:requestString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [QMPRequestManager exitAccountAndReminderWithError:error];
        failure(error);
    }];
}

//PUT
+(void)PUT:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSString *requestString = [NSString stringWithFormat:@"%@/%@",qmp_host,URLString];
    
    [[self manager] PUT:requestString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [QMPRequestManager exitAccountAndReminderWithError:error];
        failure(error);
    }];
}

//处理Error
+(void)exitAccountAndReminderWithError:(NSError * _Nullable)error{
    
    //用户账号过期
    if([error.localizedDescription localizedStandardContainsString:@"401"] || [error.localizedDescription localizedStandardContainsString:@"403"]){
        
//        [[UIView tes_getRootViewController].view makeToast:qmp_requestNetTokenOverdueMessage duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
            //清空用户信息
            //            [[ZCSUserInfoManager sharedManager] exitAccount];
//        }];
        
        //网络失败
    }else if([error.localizedDescription localizedStandardContainsString:@"请求超时" ] || [error.localizedDescription localizedStandardContainsString:@"似乎已断开与互联网的连接" ]){
        
//        [[UIView tes_getRootViewController].view makeToast:qmp_requestNetErrorMessage duration:2.0 position:CSToastPositionCenter];
        
    }
}

/************************** Zxd *******************************/
/// 获取书列表
+(void)getBookListRequest:(void(^)(NSArray *bookList))success{

    [QMPRequestManager GET:qmp_bookListRequest parameters:@{} success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
        __block NSArray *bookArray;
        [requestModel handleResponseObjectWithResultCode:^(id  _Nonnull resultData) {
            bookArray = [QMPBookModel mj_objectArrayWithKeyValuesArray:resultData];
        }];
        success(bookArray);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/// 获取单元数据
/// @param bookId 书ID
+(void)getUnitListRequest:(NSString *)bookId success:(void(^)(NSArray *unitList))success{
    
    [QMPRequestManager POST:qmp_unitListRequest parameters:@{@"bookId":bookId} success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
        __block NSArray *unitList;
        [requestModel handleResponseObjectWithResultCode:^(id  _Nonnull resultData) {
            unitList = [QMPUnitModel mj_objectArrayWithKeyValuesArray:resultData];
        }];
        success(unitList);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/// 获取课程
/// @param unitId unitId
+(void)getLessonListRequest:(NSString *)unitId success:(void(^)(NSArray *lessonList))success{
    [QMPRequestManager POST:qmp_lessonListRequest parameters:@{@"unitId":unitId} success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
        __block NSArray *lessonList;
        [requestModel handleResponseObjectWithResultCode:^(id  _Nonnull resultData) {
            lessonList = [QMPLessonModel mj_objectArrayWithKeyValuesArray:resultData];
        }];
        success(lessonList);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/// 打开图文学习
/// @param lessonId unitId
+(void)getImageLearnRequest:(NSDictionary *)dict success:(void(^)(QMPImageLearnModel *imageLearnModel))success{
    [QMPImageLearnModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"dataList" : @"QMPImageLearnPageModel"};
    }];
    
    [QMPImageLearnPageModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"contentList" : @"QMPImageLearnItemModel"};
    }];
    
    [QMPRequestManager POST:qmp_imageLearnListRequest parameters:dict success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
        __block QMPImageLearnModel *imageLearnModel;
        [requestModel handleResponseObjectWithResultCode:^(id  _Nonnull resultData) {
            imageLearnModel = [QMPImageLearnModel mj_objectWithKeyValues:resultData];
        }];
        success(imageLearnModel);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//点读开始学习一个lesson
+(void)loadImageLearnStartRequest:(NSString *)lessonId{
    [QMPRequestManager POST:qmp_imageLearnStartRequest parameters:@{@"lessonId":lessonId} success:^(id  _Nonnull responseObject) {
//        NSLog(@"responseObject");
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//点读学完一个lesson
+(void)postImageLearnDoneRequest:(NSString *)lessonId{
    
    [QMPRequestManager POST:qmp_imageLearnDoneRequest parameters:@{@"lessonId":lessonId} success:^(id  _Nonnull responseObject) {
//        NSLog(@"responseObject");
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//记录学习时长
+(void)postImageLearnTimeRequest:(NSString *)lessonId second:(NSInteger)second{
    [QMPRequestManager POST:qmp_recodeImageLearnTimeRequest parameters:@{@"lessonId":lessonId,@"totalTime":@(second)} success:^(id  _Nonnull responseObject) {
//        NSLog(@"responseObject");

    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 背单词
//用户计划详情(首页)
+(void)loadUserPlanDetailDataRequestSuccess:(void(^)(NSArray *bookArray))success failure:(void(^)(void))failure{
    [QMPRequestManager POST:qmp_loadUserPlanDetailDataRequest parameters:@{} success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
        __block NSArray *bookArray;
        [requestModel handleResponseObjectWithResultCode:^(id  _Nonnull resultData) {
//            bookArray = [QMPWordLearnBookModel mj_objectArrayWithKeyValuesArray:resultData];
        }];
        success(bookArray);
        
    } failure:^(NSError * _Nonnull error) {
        failure();
    }];
}

//词汇书列表
+(void)loadAddWordBookRequestSuccess:(void(^)(NSArray *bookArray))success{
    [QMPRequestManager POST:qmp_addWordBookRequest parameters:@{} success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
        __block NSArray *bookArray;
        [requestModel handleResponseObjectWithResultCode:^(id  _Nonnull resultData) {
//            bookArray = [QMPAddWordBookModel mj_objectArrayWithKeyValuesArray:resultData];
        }];
        success(bookArray);
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


//添加单词学习计划
+(void)addNewLearnPlanRequest:(NSInteger)learningAmount wordbookId:(NSString *)wordbookId success:(void(^)(void))success{
    NSDictionary *dict = @{
        @"learningAmount":@(learningAmount),
        @"wordbookId":wordbookId
    };
    
    [QMPRequestManager POST:qmp_addNewLearnPlanRequest parameters:dict success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
        if(requestModel.resultCode == 200){
//            [[UIView tes_getRootViewController].view makeToast:requestModel.resultMessage duration:2.0 position:CSToastPositionCenter];
        }
        success();
    } failure:^(NSError * _Nonnull error) {
        if([error.localizedDescription localizedStandardContainsString:@"403"]){
            NSData *errorData = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingAllowFragments error:nil];
//            [[UIView tes_getRootViewController].view makeToast:dic[@"data"] duration:2.0 position:CSToastPositionCenter];
        }
    }];
}

//修改单词学习计划
+(void)editLearnPlanRequest:(NSInteger)learningAmount planId:(NSString *)planId success:(void(^)(void))success{
    NSDictionary *dict = @{
        @"learningAmount": @(learningAmount),
        @"planId":planId
    };
    [QMPRequestManager POST:qmp_editLearnPlanRequest parameters:dict success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
//        [[UIView tes_getRootViewController].view makeToast:requestModel.resultMessage duration:2.0 position:CSToastPositionCenter];
        success();
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//删除学习计划
+(void)deleteEditLearnPlanRequest:(NSInteger)planId success:(void(^)(void))success{
    NSDictionary *dict = @{
        @"planId": @(planId),
    };
    [QMPRequestManager POST:qmp_deleteEditLearnPlanRequest parameters:dict success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
//        [[UIView tes_getRootViewController].view makeToast:requestModel.resultMessage duration:2.0 position:CSToastPositionCenter];
        success();
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/// 查看单词列表
/// @param wordbookId 词汇本ID
/// @param planId 学习计划ID
/// @param learned 学习状态 未学:0; 已学:1; 为空则为所有单词
+(void)loadWordListRequest:(NSString *)wordbookId planId:(NSString *)planId learned:(NSString *)learned currPage:(NSInteger)currPage success:(void(^)(NSArray *bookArray,NSInteger totalCount))success{
    NSDictionary *dict = @{
        @"currPage": @(currPage),
        @"learned": learned,
        @"pageSize": @(20),
        @"wordbookId": wordbookId,
        @"planId": planId
    };
    
    [QMPRequestManager POST:qmp_loadWordListRequest parameters:dict success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
        __block NSArray *bookArray;
        __block NSInteger totalCount;
        [requestModel handleResponseObjectWithResultCode:^(id  _Nonnull resultData) {
//            bookArray = [QMPWordModel mj_objectArrayWithKeyValuesArray:resultData[@"dataList"]];
//            totalCount = [resultData[@"totalCount"] integerValue];
        }];
        success(bookArray,totalCount);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//单词学习
+(void)loadWordLearnRequestWithPlanId:(NSString *)planId suceess:(void(^)(NSArray *learnArray))suceess{
    NSDictionary *dict = @{
        @"planId": planId
    };
    
    [QMPRequestManager POST:qmp_loadWordLearnRequest parameters:dict success:^(id  _Nonnull responseObject) {
        QMPRequestModel *requestModel = [QMPRequestModel initRequestModelWithResponseObject:responseObject];
        __block NSArray *learnArray;
        [requestModel handleResponseObjectWithResultCode:^(id  _Nonnull resultData) {
//            learnArray = [QMPWordLearnModel mj_objectArrayWithKeyValuesArray:resultData];
        }];
        suceess(learnArray);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/************************** HHM *******************************/


@end
