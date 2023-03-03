//
//  UIView+Extention.m
//  EnglishTeacherPlatform
//
//  Created by MissSunRise on 2020/9/5.
//  Copyright © 2020 com.chindle.talk915. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

//获取根控制器
+ (UIViewController *)tes_getRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

//获取最上层VC
+ (UIViewController *)tes_findVisibleViewController{
    
    UIViewController* currentViewController = [self tes_getRootViewController];
    
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    
    return currentViewController;
}






/*----------------------------- layer ------------------------------*/
- (void)setCornerRadius:(NSInteger)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (NSInteger)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(NSInteger)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (NSInteger)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setMasksToBounds:(BOOL)bounds {
    self.layer.masksToBounds = bounds;
}

- (BOOL)masksToBounds {
    return self.layer.masksToBounds;
}

//添加 shadowColor
-(void)tes_addShadowColor:(CGRect)rect{
    [self layoutIfNeeded];
    
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = tesAuto(8);
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);//偏移 0 为四周发散
    self.layer.shadowOpacity = 0.3f;//阴影程度
    self.layer.shadowRadius = tesAuto(8);
    
    //设置路径
    UIBezierPath *path = [UIBezierPath bezierPath];

    CGFloat x = self.bounds.origin.x;
    CGFloat y = self.bounds.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;

    CGFloat addH = 10;

    CGPoint topLeft = rect.origin;
    CGPoint topMidle = CGPointMake(x + width * 0.5, y - addH);
    CGPoint topRight = CGPointMake(x + width, y);
    CGPoint rightMidle = CGPointMake(x + width + addH, y + height * 0.5);
    CGPoint rightBottom = CGPointMake(x + width, y + height);
    CGPoint bottomMidle = CGPointMake(x + width, y + height + addH);
    CGPoint bottomLeft = CGPointMake(x, y + height);
    CGPoint leftMidle = CGPointMake(x - addH, y + height * 0.5);

    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight controlPoint:topMidle];
    [path addQuadCurveToPoint:rightBottom controlPoint:rightMidle];
    [path addQuadCurveToPoint:bottomLeft controlPoint:bottomMidle];
    [path addQuadCurveToPoint:topLeft controlPoint:leftMidle];

    self.layer.shadowPath = path.CGPath;
}



//添加 shadowColor 控制阴影程度
-(void)tes_addShadowColor:(CGRect)rect shadowOpacity:(CGFloat)shadowOpacity{
    [self layoutIfNeeded];
    
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = tesAuto(8);
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);//偏移 0 为四周发散
    self.layer.shadowOpacity = shadowOpacity;//阴影程度
    self.layer.shadowRadius = tesAuto(8);
    
    //设置路径
    UIBezierPath *path = [UIBezierPath bezierPath];

    CGFloat x = self.bounds.origin.x;
    CGFloat y = self.bounds.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;

    CGFloat addH = 10;

    CGPoint topLeft = rect.origin;
    CGPoint topMidle = CGPointMake(x + width * 0.5, y - addH);
    CGPoint topRight = CGPointMake(x + width, y);
    CGPoint rightMidle = CGPointMake(x + width + addH, y + height * 0.5);
    CGPoint rightBottom = CGPointMake(x + width, y + height);
    CGPoint bottomMidle = CGPointMake(x + width, y + height + addH);
    CGPoint bottomLeft = CGPointMake(x, y + height);
    CGPoint leftMidle = CGPointMake(x - addH, y + height * 0.5);

    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight controlPoint:topMidle];
    [path addQuadCurveToPoint:rightBottom controlPoint:rightMidle];
    [path addQuadCurveToPoint:bottomLeft controlPoint:bottomMidle];
    [path addQuadCurveToPoint:topLeft controlPoint:leftMidle];

    self.layer.shadowPath = path.CGPath;
}

+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
