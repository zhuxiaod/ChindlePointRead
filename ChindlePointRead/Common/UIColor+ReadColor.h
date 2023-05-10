//
//  UIColor+DymaicColor.h
//  ShanYanSDK_Demo
//
//  Created by wanglijun on 2020/7/30.
//  Copyright © 2020 wanglijun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
渐变方式

- XDGradientChangeDirectionLevel:              水平渐变
- XDGradientChangeDirectionVertical:           竖直渐变
- XDGradientChangeDirectionUpwardDiagonalLine: 向下对角线渐变
- XDGradientChangeDirectionDownDiagonalLine:   向上对角线渐变
*/
typedef NS_ENUM(NSInteger, XDGradientChangeDirection) {
    XDGradientChangeDirectionLevel,
    XDGradientChangeDirectionVertical,
    XDGradientChangeDirectionUpwardDiagonalLine,
    XDGradientChangeDirectionDownDiagonalLine,
};

@interface UIColor (ReadColor)

+(UIColor*)generateDynamicColor:(UIColor*)lightColor darkColor:(UIColor *)darkColor;

+(UIColor *)AppMainColor;

+(UIColor *)AppWhiteColor;

+(UIColor *)AppBlueColor;

//+(UIColor *)AppTextGrayColor;

+(UIColor *)AppVcBackgroudColor;

+(UIColor *)AppPageTitleColor;

+(UIColor *)AppGrayTitleColor;
/// #999999
+(UIColor *)AppDarkGreyColor;
/// #33333
+(UIColor *)AppLabBlackColor;

+(UIColor *)AppPinkColor;

+(UIColor *)AppLineColor;

+(UIColor *)AppOrangeColor;

+(UIColor *)AppCcccccColor;

+(UIColor *)AppNewLineColor;

//浅灰全局背景
+(UIColor *)AppLightGrayBgColor;

//浅白全局背景
+(UIColor *)AppLightWhiteBgColor;

//浅红全局背景
+(UIColor *)AppLightRedBgColor;

//浅红全局背景
+(UIColor *)AppLightRedLineColor;

//黄色
+(UIColor *)AppYellowColor;


#pragma mark - 文字颜色
+(UIColor *)AppDarkGrayColor;

+(UIColor *)AppTextGrayColor;

+(UIColor *)AppTextRedColor;

+(UIColor *)AppTextBrownColor;

/// 渐变颜色
/// @param direction 方向
/// @param startcolor 开始颜色
/// @param endColor 结束颜色
+ (instancetype)xd_colorGradientChangeWithSize:(CGSize)size
                                     direction:(XDGradientChangeDirection)direction
                                    startColor:(UIColor *)startcolor
                                      endColor:(UIColor *)endColor;

/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 *  @param color      颜色
 */
- (void)P_getRGBComponents:(CGFloat [_Nullable 3])components forColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
