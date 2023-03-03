//
//  TESCommonTools.h
//  NewTalkEnglishStudentProject
//
//  Created by mac on 2020/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BRBaseView;

@interface QMPCommonTools : NSObject

/// 显示加载
+(void)hudShow;

/// 取消加载
+(void)hudDismissInMain;

//判断账号
+(BOOL)isCorrectAccount:(NSString *)account;

//判断密码
+(BOOL)isCorrectPassword:(NSString *)password;

//判断姓名
+(BOOL)isCorrectUserName:(NSString *)userName;

//判断验证码
+(BOOL)isCorrectVercode:(NSString *)vercode;

//是否同意协议
+(BOOL)isAgreePrivacy:(BOOL)isSelected;

//课程Week转星期几
+(NSString *)courseWeekToWeekDay:(NSInteger)week;

//计算文字高度
+ (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width;

//获取每周几天
+(NSString *)getCourseScheduleCount:(NSArray *)timeArray;

//添加提示


//获取App版本号
+(NSString *)getAppVersion;

//获取去除小数点的版本号
+(NSInteger)getIntegerAppVersion;

//判断是否为数字
+ (BOOL)isNumber:(NSString *)source;

//+(void)appConfigDisplayOperation:(nullable void(^)(void))displayOperation hiddenOperation:(nullable void(^)(void))hiddenOperation;

//快速创建导航栏item
+(UIBarButtonItem *)createUIBarButtonItemWithBtn:(UIButton *)btn;

//窗口添加视图
+(void)windowAddSubview:(UIView *)view;

//未读小红点
+(NSMutableAttributedString *)setupLittleRedViewWithContent:(NSString *)content;

// 隐藏手机号码6-10位显示*
+(NSString *)hidePartOfPhoneNumber:(NSString *)str;

#pragma mark - 修改图片大小
+ (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height image:(NSString *)imageName;

+(UIImage *)reSizeImageWithName:(NSString *)imageName scaleToSize:(CGSize)size;


#pragma mark - 获取lab单行高度
+(CGFloat)getLabRowHeight:(CGFloat)fontSize;

#pragma mark - 获取lab Size
+(CGSize)getLabContentSize:(NSString *)contentString width:(CGFloat)width fontSize:(CGFloat)fontSize;

#pragma mark - 获取不需要换行的Lab Size
+(CGSize)getLabContentSize:(NSString *)contentString fontSize:(CGFloat)fontSize;

#pragma mark - 获取文字高度
+(CGFloat)getTextHeightWithFontSize:(CGFloat)fontSize;

#pragma mark - 获取阴影
+(UIBezierPath *)getShadowPath:(CGRect)bounds;

@end

NS_ASSUME_NONNULL_END
