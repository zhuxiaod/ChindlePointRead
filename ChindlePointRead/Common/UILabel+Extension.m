//
//  UILabel+Extention.m
//  EnglishTeacherPlatform
//
//  Created by MissSunRise on 2020/9/5.
//  Copyright © 2020 com.chindle.talk915. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

//快速创建
+(instancetype)tes_creatLabWithText:(NSString *)text{
    UILabel *lab = [[UILabel alloc] init];
    lab.text = text;
    [lab sizeToFit];
    return lab;
}

+(instancetype)tes_creatLabWithText:(NSString *)text fontSize:(CGFloat)fontSize{
    UILabel *lab = [[UILabel alloc] init];
    lab.text = text;
    lab.font = [UIFont systemFontOfSize:fontSize];
    [lab sizeToFit];
    return lab;
}

+(instancetype)tes_creatLabWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor{
    UILabel *lab = [[UILabel alloc] init];
    lab.text = text;
    lab.font = [UIFont systemFontOfSize:fontSize];
    lab.textColor = textColor;
    [lab sizeToFit];
    return lab;
}

+(instancetype)tes_creatBoldLabWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor{
    UILabel *lab = [[UILabel alloc] init];
    lab.text = text;
    lab.font = [UIFont boldSystemFontOfSize:fontSize];
    lab.textColor = textColor;
    [lab sizeToFit];
    return lab;
}


/// 改变 label 行间距
- (void)tes_changeLineSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [labelText length])];
    
    self.attributedText = attributedString;
    [self sizeToFit];
}

/// 修改 label 字间距
- (void)tes_changeWordSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [labelText length])];
    
    self.attributedText = attributedString;
    [self sizeToFit];
}

/// 改变字间距 行间距
- (void)tes_changeLineSpace:(float)lineSpace wordSpace:(float)wordSpace {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attr;
    [self sizeToFit];
}

+ (UILabel *)tes_labelWithText:(NSString *)text
                     fontSize:(CGFloat)fontSize
                    textColor:(UIColor *)textColor
                    alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text          = text;
    label.textColor     = textColor;
    label.font          = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    
    [label sizeToFit];
    
    return label;
}

+ (UILabel *)tes_labelWithText:(NSString *)text {
    return [self tes_labelWithText:text fontSize:16 textColor:[UIColor darkTextColor] alignment:(NSTextAlignmentLeft)];
}

+ (UILabel *)tes_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize {
    return [self tes_labelWithText:text fontSize:fontSize textColor:[UIColor darkTextColor] alignment:(NSTextAlignmentLeft)];
}

+ (UILabel *)tes_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor {
    return [self tes_labelWithText:text fontSize:fontSize textColor:textColor alignment:(NSTextAlignmentLeft)];
}

//多行
- (CGSize)tes_sizeThatFits:(CGFloat)width{
    return [self sizeThatFits:CGSizeMake(width, MAXFLOAT)];
}

//单行
- (CGSize)tes_sizeThatFits{
    CGSize labSize = [self sizeThatFits:CGSizeMake(kScreenWidth, MAXFLOAT)];
    return labSize;
}

@end
