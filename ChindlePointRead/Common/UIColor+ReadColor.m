//
//  UIColor+DymaicColor.m
//  ShanYanSDK_Demo
//
//  Created by wanglijun on 2020/7/30.
//  Copyright © 2020 wanglijun. All rights reserved.
//

#import "UIColor+ReadColor.h"

@implementation UIColor (ReadColor)

+(UIColor*)generateDynamicColor:(UIColor*)lightColor darkColor:(UIColor *)darkColor{
    
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc]initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            }else {
                return lightColor;
            }
        }];
    } else {
        return lightColor;
    }
}

+(UIColor *)AppMainColor{
    return [UIColor colorWithHexString:@"#1190FF"];
}

+(UIColor *)AppWhiteColor{
    return [UIColor colorWithHexString:@"#FFFFFF"];
}

+(UIColor *)AppBlueColor{
    return [UIColor colorWithHexString:@"#1EA2FF"];
}

//+(UIColor *)AppTextGrayColor{
//    return [UIColor colorWithHexString:@"#999999"];
//}

+(UIColor *)AppVcBackgroudColor{
    return [UIColor colorWithHexString:@"#F7F7F7"];
}

+(UIColor *)AppPageTitleColor{
    return [UIColor colorWithHexString:@"#FF281E"];
}

+(UIColor *)AppGrayTitleColor{
    return [UIColor colorWithHexString:@"#666666"];
}

//#999999
+(UIColor *)AppLoginTextColor{
    return [UIColor colorWithHexString:@"#999999"];
}

+(UIColor *)AppCcccccColor{
    return [UIColor colorWithHexString:@"#CCCCCC"];
}

//
+(UIColor *)AppLabBlackColor{
    return [UIColor colorWithHexString:@"#333333"];
}


+(UIColor *)AppPinkColor{
    return [UIColor colorWithHexString:@"#FF281E"];
}




+(UIColor *)AppNewLineColor{
    return [UIColor colorWithHexString:@"#EEEEEF"];
}

//主题色
+(UIColor *)AppOrangeColor{
    return [UIColor colorWithHexString:@"#ff6951"];
}

//分割线
+(UIColor *)AppLineColor{
    return [UIColor colorWithHexString:@"#eeeeef"];
}

//浅灰全局背景
+(UIColor *)AppLightGrayBgColor{
    return [UIColor colorWithHexString:@"#f4f6f8ff"];
}

//浅白全局背景
+(UIColor *)AppLightWhiteBgColor{
    return [UIColor colorWithHexString:@"#fcfcfdff"];
}

//浅红全局背景
+(UIColor *)AppLightRedBgColor{
    return [UIColor colorWithHexString:@"#fff6f5ff"];
}

//浅红全局背景
+(UIColor *)AppLightRedLineColor{
    return [UIColor colorWithHexString:@"#fffaf9ff"];
}

//黄色
+(UIColor *)AppYellowColor{
    return [UIColor colorWithHexString:@"#ffd957ff"];
}

#pragma mark - 文字颜色
+(UIColor *)AppDarkGrayColor{
    return [UIColor colorWithHexString:@"#222325"];
}

+(UIColor *)AppTextGrayColor{
    return [UIColor colorWithHexString:@"#8d949b"];
}

+(UIColor *)AppTextRedColor{
    return [UIColor colorWithHexString:@"#ff4242"];
}

+(UIColor *)AppTextBrownColor{
    return [UIColor colorWithHexString:@"#a64d2f"];
}


+ (instancetype)xd_colorGradientChangeWithSize:(CGSize)size
                                     direction:(XDGradientChangeDirection)direction
                                    startColor:(UIColor *)startcolor
                                      endColor:(UIColor *)endColor {
    
    if (CGSizeEqualToSize(size, CGSizeZero) || !startcolor || !endColor) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;
    if (direction == XDGradientChangeDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case XDGradientChangeDirectionLevel:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case XDGradientChangeDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case XDGradientChangeDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case XDGradientChangeDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    
    gradientLayer.colors = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}



/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 *  @param color      颜色
 */
- (void)P_getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel, 1, 1, 8, 4, rgbColorSpace, 1);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}

@end
