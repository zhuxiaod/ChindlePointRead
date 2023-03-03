//
//  UIButton+Extention.h
//  EnglishTeacherPlatform
//
//  Created by ZXD on 2020/9/4.
//  Copyright © 2020 com.chindle.talk915. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extension)

-(void)buttonAddGradientColorWithColors:(NSArray *)colors;

+(instancetype)creatCustomButtonWithTitle:(NSString *)title;

+(instancetype)creatCustomButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

+(instancetype)creatCustomButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize;

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName;

+(instancetype)creatButtonWithBGImg:(UIImage *)image;

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName title:(NSString *)title;

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName title:(NSString *)title titleColor:(UIColor *)titleColor;

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName title:(NSString *)title fontSize:(CGFloat)fontSize;

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName title:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize;


//上图下文
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space;

- (void)setupLeftImageAndRightLableWithSpace:(CGFloat)space;

- (void)setupRightImageAndLeftLableWithSpace:(CGFloat)space;




-(void)tes_setImageWithName:(NSString *)imgName placeholderImageString:(NSString *)placeholderImageName;

-(void)tes_setImageWithName:(NSString *)imgName;



@end

NS_ASSUME_NONNULL_END
