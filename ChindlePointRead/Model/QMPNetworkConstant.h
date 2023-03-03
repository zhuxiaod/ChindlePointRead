//
//  TESNetworkConstant.h
//  NewTalkEnglishStudentProject
//
//  Created by mac on 2020/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMPNetworkConstant : NSObject

//点对点聊天
extern NSString *const qmp_pointToPointUrl;

/******************** 接口 ******************************/

extern NSString *const qmp_host;

extern NSString *const qmp_bookListRequest;
extern NSString *const qmp_unitListRequest;
extern NSString *const qmp_lessonListRequest;
extern NSString *const qmp_imageLearnListRequest;
//点读开始学习一个lesson
extern NSString *const qmp_imageLearnStartRequest;
//点读学完一个lesson
extern NSString *const qmp_imageLearnDoneRequest;
//记录学习时长
extern NSString *const qmp_recodeImageLearnTimeRequest;

//用户计划详情(首页)
extern NSString *const qmp_loadUserPlanDetailDataRequest;
//词汇书列表
extern NSString *const qmp_addWordBookRequest;
//添加单词学习计划
extern NSString *const qmp_addNewLearnPlanRequest;
//修改单词学习计划
extern NSString *const qmp_editLearnPlanRequest;
//删除单词学习计划
extern NSString *const qmp_deleteEditLearnPlanRequest;
//查看单词列表
extern NSString *const qmp_loadWordListRequest;
//单词学习
extern NSString *const qmp_loadWordLearnRequest;
/******************** 接口 ******************************/

@end

NS_ASSUME_NONNULL_END
