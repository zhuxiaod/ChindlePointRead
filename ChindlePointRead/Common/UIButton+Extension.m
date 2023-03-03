//
//  UIButton+Extention.m
//  EnglishTeacherPlatform
//
//  Created by ZXD on 2020/9/4.
//  Copyright © 2020 com.chindle.talk915. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

-(void)buttonAddGradientColorWithColors:(NSArray *)colors{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    gl.startPoint = CGPointMake(0, 0.5);
    gl.endPoint = CGPointMake(1, 0.5);
    gl.colors = colors;
    gl.locations = @[@(0), @(1.0f)];
    [self.layer insertSublayer:gl atIndex:0];
}

+(instancetype)creatCustomButtonWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

+(instancetype)creatCustomButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

+(instancetype)creatCustomButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    return btn;
}

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    return btn;
}

+(instancetype)creatButtonWithBGImg:(UIImage *)image{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    return btn;
}

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName title:(NSString *)title titleColor:(UIColor *)titleColor{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
}

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName title:(NSString *)title fontSize:(CGFloat)fontSize{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    return btn;
}

+(instancetype)creatCustomButtonWithImg:(NSString *)imgName title:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    return btn;
}

//上图下文
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    if (titleSize.width < labelWidth) {
        titleSize.width = labelWidth;
    }
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height+space, -imageSize.width, -space, 0.0)];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(-space, 0.0,0.0,-titleSize.width)];
}
//imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
//labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);

//左图右文
- (void)setupLeftImageAndRightLableWithSpace:(CGFloat)space{
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0,space, 0, 0)];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,space)];
}

//右图左文
- (void)setupRightImageAndLeftLableWithSpace:(CGFloat)space{
    CGFloat imageHeight = self.imageView.image.size.height;
    CGFloat labelWidth = [self.titleLabel tes_sizeThatFits].width;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space/2, 0, -(labelWidth + space/2));
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight + space/2), 0, imageHeight + space/2);
}

+(UIButton *)createTopImageBottomTextWithImgStr:(NSString *)imgStr title:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    return button;
}
@end
