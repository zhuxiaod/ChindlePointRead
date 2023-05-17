//
//  TESRequestManager.h
//  NewTalkEnglishStudentProject
//
//  Created by mac on 2020/12/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError *error);
@class QMPRequestManager;
/// 请求数据类
@interface QMPRequestManager : NSObject

/************************** Common ****************************/

//Post
+(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(SuccessBlock)success
    failure:(FailureBlock)failure;

//GET
+(void)GET:(NSString *)URLString
parameters:(id)parameters
   success:(SuccessBlock)success
   failure:(FailureBlock)failure;

//PUT
+(void)PUT:(NSString *)URLString
parameters:(id)parameters
   success:(SuccessBlock)success
   failure:(FailureBlock)failure;


/************************** Zxd *******************************/

+ (AFHTTPSessionManager *)manager;

/// 获取书列表
+(void)getBookListRequest:(void(^)(NSArray *bookList))success;

/// 获取单元数据
/// @param bookId 书ID
+(void)getUnitListRequest:(NSString *)bookId success:(void(^)(NSArray *unitList))success;

/// 获取课程
/// @param unitId unitId
+(void)getLessonListRequest:(NSString *)unitId success:(void(^)(NSArray *lessonList))success;
/************************** HHM *******************************/

/// 打开图文学习
/// @param lessonId unitId
+(void)getImageLearnRequest:(NSDictionary *)dict success:(void(^)(QMPImageLearnModel *imageLearnModel))success;

//点读开始学习一个lesson
+(void)loadImageLearnStartRequest:(NSString *)lessonId;

//点读学完一个lesson
+(void)postImageLearnDoneRequest:(NSString *)lessonId;

//记录学习时长
+(void)postImageLearnTimeRequest:(NSString *)lessonId second:(NSInteger)second;

//用户计划详情(首页)
+(void)loadUserPlanDetailDataRequestSuccess:(void(^)(NSArray *bookArray))success;
//词汇书列表
+(void)loadAddWordBookRequestSuccess:(void(^)(NSArray *bookArray))success;
//添加单词学习计划
+(void)addNewLearnPlanRequest:(NSInteger)learningAmount wordbookId:(NSString *)wordbookId success:(void(^)(void))success;
//修改单词学习计划
+(void)editLearnPlanRequest:(NSInteger)learningAmount planId:(NSString *)planId success:(void(^)(void))success;
//删除学习计划
+(void)deleteEditLearnPlanRequest:(NSInteger)planId success:(void(^)(void))success;
/// 查看单词列表
/// @param wordbookId 词汇本ID
/// @param planId 学习计划ID
/// @param learned 学习状态 未学:0; 已学:1; 为空则为所有单词
+(void)loadWordListRequest:(NSString *)wordbookId planId:(NSString *)planId learned:(NSString *)learned currPage:(NSInteger)currPage success:(void(^)(NSArray *bookArray,NSInteger totalCount))success;
//用户计划详情(首页)
+(void)loadUserPlanDetailDataRequestSuccess:(void(^)(NSArray *bookArray))success failure:(void(^)(void))failure;

//单词学习
+(void)loadWordLearnRequestWithPlanId:(NSString *)planId suceess:(void(^)(NSArray *learnArray))suceess;

@end

NS_ASSUME_NONNULL_END
