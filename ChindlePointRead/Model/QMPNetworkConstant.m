//
//  TESNetworkConstant.m
//  NewTalkEnglishStudentProject
//
//  Created by mac on 2020/12/2.
//

#import "QMPNetworkConstant.h"

@implementation QMPNetworkConstant

//#ifdef DEBUG
//
////测试
////NSString *const qmp_host = @"https://www.talk915.com/";
//
////点对点聊天
//NSString *const qmp_pointToPointUrl = @"https://test.usongshu.com";
//
////CS
//NSString *const qmp_CSUrl = @"https://test.usongshu.com";
//
////本地
////NSString *const zcs_courseWebUrl = @"http://10.204.42.63:8085/mobile/app/index";
////本地服务器
////NSString *const zcs_host = @"http://10.204.42.143:";//罗
////NSString *const zcs_host = @"http://10.204.42.244:9099";//测试网
////NSString *const zcs_host = @"http://10.204.42.227:9099";//谢
//
//#else
//
////正式
////NSString *const qmp_host = @"https://www.talk915.com/";
//
////点对点聊天
//NSString *const qmp_pointToPointUrl = @"https://point.usongshu.com";
//
////CS
//NSString *const qmp_CSUrl = @"https://platform.usongshu.com";
//
//#endif


/******************** 接口 ******************************/


#ifdef DEBUG

NSString *const qmp_host = @"http://10.204.42.139:9080/appletServer";

#elif DEBUGTEST

NSString *const qmp_host = @"https://starter.usongshu.com/appletServer";

#elif DEBUGFORMAL

NSString *const qmp_host = @"https://starter.usongshu.com/appletServer";

#else

NSString *const qmp_host = @"https://starter.usongshu.com/appletServer";

#endif

NSString *const qmp_bookListRequest = @"book/list";
NSString *const qmp_unitListRequest = @"unit/list";
NSString *const qmp_lessonListRequest = @"lesson/list";
NSString *const qmp_imageLearnListRequest = @"image/learn";
//点读开始学习一个lesson
NSString *const qmp_imageLearnStartRequest = @"lesson/learning";
//点读学完一个lesson
NSString *const qmp_imageLearnDoneRequest = @"lesson/learned";
//记录学习时长
NSString *const qmp_recodeImageLearnTimeRequest = @"lesson/learned/time";
//用户计划详情(首页)
NSString *const qmp_loadUserPlanDetailDataRequest = @"plan/list";
//词汇书列表
NSString *const qmp_addWordBookRequest = @"wordbook/list";
//添加单词学习计划
NSString *const qmp_addNewLearnPlanRequest = @"plan/add";
//修改单词学习计划
NSString *const qmp_editLearnPlanRequest = @"plan/update/amount";
//删除单词学习计划
NSString *const qmp_deleteEditLearnPlanRequest = @"plan/delete";
//查看单词列表
NSString *const qmp_loadWordListRequest = @"word/list";
//单词学习
NSString *const qmp_loadWordLearnRequest = @"word/learning";




/******************** 接口 ******************************/

@end
