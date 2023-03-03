//
//  TESCommonTools.m
//  NewTalkEnglishStudentProject
//
//  Created by mac on 2020/12/2.
//

#import "QMPCommonTools.h"

NS_ASSUME_NONNULL_BEGIN

@implementation QMPCommonTools

//显示加载
+(void)hudShow{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
}

//隐藏加载
+(void)hudDismissInMain{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

//判断账号
//+(BOOL)isCorrectAccount:(NSString *)account{
//    if(account.length == 0 || [account tes_isMobile] == NO){
//        [[UIView tes_getRootViewController].view makeToast:qmp_phoneNumErrorMessage duration:2.0 position:CSToastPositionCenter];
//        return NO;
//    }
//    return YES;
//}
//
////判断姓名
//+(BOOL)isCorrectUserName:(NSString *)userName{
//    if(userName.length == 0 || [userName isEqualToString:@""]){
//        [[UIView tes_getRootViewController].view makeToast:qmp_userNameErrorMessage duration:2.0 position:CSToastPositionCenter];
//        return NO;
//    }
//    return YES;
//}
//
////判断密码
//+(BOOL)isCorrectPassword:(NSString *)password{
//    if(password.length == 0 || [password checkPassword] == NO){
//        [[UIView tes_getRootViewController].view makeToast:qmp_passwordErrorMessage duration:2.0 position:CSToastPositionCenter];
//        return NO;
//    }
//    return YES;
//}
//
////判断验证码
//+(BOOL)isCorrectVercode:(NSString *)vercode{
//    if(vercode.length == 0){
//        [[UIView tes_getRootViewController].view makeToast:qmp_verCodeErrorMessage duration:2.0 position:CSToastPositionCenter];
//        return NO;
//    }
//    return YES;
//}

//判断是否为数字
+ (BOOL)isNumber:(NSString *)source {

    if(source.length == 0)return NO;

    NSString *temp = nil;

    NSInteger count = source.length;

    for(NSInteger i = 0; i < count; i++)
    {
        temp = [source substringWithRange:NSMakeRange(i,1)];

        NSString *regex = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";

        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];

        if([pred evaluateWithObject:temp] == YES)return YES;//是数字
    }
    return NO;
}

//是否同意协议
+(BOOL)isAgreePrivacy:(BOOL)isSelected{
    if(isSelected != YES){
//        [[UIView tes_getRootViewController].view makeToast:qmp_agreePrivacyErrorMessage duration:2.0 position:CSToastPositionCenter];
        return NO;
    }
    return YES;
}

//课程Week转星期几
+(NSString *)courseWeekToWeekDay:(NSInteger)week{
    switch (week) {
        case 1:
            return @"日" ;
            break;
        case 2:
            return @"一" ;
            break;
        case 3:
            return @"二" ;
            break;
        case 4:
            return @"三" ;
            break;
        case 5:
            return @"四" ;
            break;
        case 6:
            return @"五" ;
            break;
        case 7:
            return @"六" ;
            break;


        default:
            break;
    }
    return @"";
}

//计算文字高度
+(CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}



//获取App版本号
+(NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

//获取去除小数点的版本号
+(NSInteger)getIntegerAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSInteger versionNum = [[appVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
    return versionNum;
}


///// 审核逻辑方法
///// @param displayOperation 审核显示
///// @param hiddenOperation
//+(void)appConfigDisplayOperation:(nullable void(^)(void))displayOperation hiddenOperation:(nullable void(^)(void))hiddenOperation{
//    if(([[TESUserDefaults standardUserDefaults] getSwitchStatus] == 1) || ([[TESUserDefaults standardUserDefaults] isShow] && [[TESUserDefaults standardUserDefaults] getSwitchStatus] == 0)){
//        displayOperation();
//    }else{
//        hiddenOperation();
//    }
//}

//快速创建导航栏item
+(UIBarButtonItem *)createUIBarButtonItemWithBtn:(UIButton *)btn{
    btn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    
    UIView *rightCustomView = [[UIView alloc]initWithFrame:btn.frame];
    [rightCustomView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

//窗口添加视图
+(void)windowAddSubview:(UIView *)view{
    [[UIApplication sharedApplication].windows[0] addSubview:view];
}

//未读小红点
+(NSMutableAttributedString *)setupLittleRedViewWithContent:(NSString *)content{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    
    UIImage *image = [UIImage mainResourceImageNamed:@"weiduImg"];//要显示的图片

    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(10, 10) alignToFont:[UIFont boldSystemFontOfSize:16] alignment:YYTextVerticalAlignmentCenter];//content：内容  size：图片尺寸 alignToFont:字符串内字体的格式
    attributedString.font = [UIFont systemFontOfSize:16];
    
    [attributedString insertAttributedString:attachText atIndex:0];//插入到第几个下标
    [attributedString insertAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "] atIndex:1];//插入到第几个下标
    return attributedString;
}

// 隐藏手机号码6-10位显示*
+(NSString *)hidePartOfPhoneNumber:(NSString *)str{
    NSMutableString * phoneStr = [NSMutableString stringWithString:str];
    [phoneStr replaceCharactersInRange:NSMakeRange(4, 4) withString:@"****"];
    return phoneStr;
}

+ (UIImage *)transformWidth:(CGFloat)width
                    height:(CGFloat)height image:(NSString *)imageName {
    
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    UIImage *image = [UIImage mainResourceImageNamed:imageName];
    CGImageRef imageRef = image.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}

+(UIImage *)reSizeImageWithName:(NSString *)imageName scaleToSize:(CGSize)size
{
    UIImage *image = [UIImage mainResourceImageNamed:imageName];

    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸

    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];

    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return scaledImage;   //返回的就是已经改变的图片
}




#pragma mark - 获取lab单行高度
+(CGFloat)getLabRowHeight:(CGFloat)fontSize{
    NSString *viewHeightSting = @"单行高度";
    CGSize classTypeViewSize = [viewHeightSting boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingTruncatesLastVisibleLine |
                                NSStringDrawingUsesLineFragmentOrigin |
                                NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return classTypeViewSize.height;
}

#pragma mark - 获取lab Size
+(CGSize)getLabContentSize:(NSString *)contentString width:(CGFloat)width fontSize:(CGFloat)fontSize{
    CGSize lblSize = [contentString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return lblSize;
}

#pragma mark - 获取不需要换行的Lab Size
+(CGSize)getLabContentSize:(NSString *)contentString fontSize:(CGFloat)fontSize{
    CGSize lblSize = [contentString boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return lblSize;
}

#pragma mark - 获取文字高度
+(CGFloat)getTextHeightWithFontSize:(CGFloat)fontSize{
    NSString *str = @"你好";
        
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    CGFloat realHeight = ceilf(rect.size.height);
    
    return realHeight;
}

#pragma mark - 获取阴影
+(UIBezierPath *)getShadowPath:(CGRect)bounds{
    //设置路径
    UIBezierPath *path = [UIBezierPath bezierPath];

    CGFloat x = bounds.origin.x;
    CGFloat y = bounds.origin.y;
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;

    CGFloat addH = 10;

    CGPoint topLeft = bounds.origin;
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
    return path;
}

@end

NS_ASSUME_NONNULL_END
