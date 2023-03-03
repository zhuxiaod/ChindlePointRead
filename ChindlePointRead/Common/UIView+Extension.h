//
//  UIView+Extention.h
//  EnglishTeacherPlatform
//
//  Created by MissSunRise on 2020/9/5.
//  Copyright © 2020 com.chindle.talk915. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

//获取控制器
- (UIViewController*)viewController;

//获取根控制器
+ (UIViewController *)tes_getRootViewController;

//获取最上层VC
+ (UIViewController *)tes_findVisibleViewController;

/*----------------------------- layer ------------------------------*/
@property (assign,nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign,nonatomic) IBInspectable BOOL      masksToBounds;
@property (assign,nonatomic) IBInspectable NSInteger borderWidth;
@property (strong,nonatomic) IBInspectable UIColor   *borderColor;

//添加 shadowColor
-(void)tes_addShadowColor:(CGRect)rect;

//添加 shadowColor 控制阴影程度
-(void)tes_addShadowColor:(CGRect)rect shadowOpacity:(CGFloat)shadowOpacity;

//设置虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end

NS_ASSUME_NONNULL_END
