//
//  TESAdapter.h
//  NewTalkEnglishStudentProject
//
//  Created by mac on 2020/12/14.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


/** 适配手机类型 */
typedef NS_ENUM(NSInteger,TESAdapterPhoneType) {
    /** iPhone3GS_4_4S */
    TXAdapterPhoneType_iPhone3GS_4_4S    = 0,
    /** iPhone5_5C_5S_5SE */
    TXAdapterPhoneType_iPhone5_5C_5S_5SE = 1,
    /** iPhone6_6S_7_8 */
    TXAdapterPhoneType_iPhone6_6S_7_8_SE = 2,
    /** iPhone6Plus_6SPlus_7Plus_8Plus */
    TXAdapterPhoneType_iPhone6Plus_6SPlus_7Plus_8Plus = 3,
    /** iPhoneX_XS_11Pro_12mini */
    TXAdapterPhoneType_iPhoneX_XS_11Pro_12mini        = 4,
    /** iPhoneXSMax_XR_11_11ProMax */
    TXAdapterPhoneType_iPhoneXSMax_XR_11_11ProMax     = 5,
    /** iPhone12_12Pro */
    TXAdapterPhoneType_iPhone12_12Pro                 = 6,
    /** iPhone12ProMax */
    TXAdapterPhoneType_iPhone12ProMax                 = 7,
    /** 其他 */
    TXAdapterPhoneTypeOther                           = 8,
};

/** 所需适配机型-屏幕宽 */
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone3GS_4_4S;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone5_5C_5S_5SE;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone6_6S_7_8_SE;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone6Plus_6SPlus_7Plus_8Plus;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhoneX_XS_11Pro_12mini;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhoneXSMax_XR_11_11ProMax;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone12_12Pro;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone12ProMax;

/** 所需适配机型-屏幕高 */
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone3GS_4_4S;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone5_5C_5S_5SE;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone6_6S_7_8_SE;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone6Plus_6SPlus_7Plus_8Plus;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhoneX_XS_11Pro_12mini;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhoneXSMax_XR_11_11ProMax;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone12_12Pro;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone12ProMax;


/** 屏幕宽度 */
static inline CGFloat tScreenWidth() {
//    return [UIScreen mainScreen].nativeBounds.size.width;
//    return [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale;

    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {//横屏
        return [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale;
    } else {
        return [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale;
    }
}

/** 幕高度 */
static inline CGFloat tScreenHeight() {
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {//横屏
        if ([UIApplication sharedApplication].statusBarFrame.size.width > 20) {
            return [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale - 20;
        }
        return [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale;
    } else {
        if ([UIApplication sharedApplication].statusBarFrame.size.height > 20) {
            return [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale - 20;
        }
        return [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale;
    }
}

/** 当前屏幕类型 */
static inline TESAdapterPhoneType tCurrentType() {
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone3GS_4_4S) return TXAdapterPhoneType_iPhone3GS_4_4S;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone5_5C_5S_5SE) return TXAdapterPhoneType_iPhone5_5C_5S_5SE;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone6_6S_7_8_SE) return TXAdapterPhoneType_iPhone6_6S_7_8_SE;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone6Plus_6SPlus_7Plus_8Plus) return TXAdapterPhoneType_iPhone6Plus_6SPlus_7Plus_8Plus;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhoneX_XS_11Pro_12mini) return TXAdapterPhoneType_iPhoneX_XS_11Pro_12mini;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhoneXSMax_XR_11_11ProMax) return TXAdapterPhoneType_iPhoneXSMax_XR_11_11ProMax;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone12_12Pro) return TXAdapterPhoneType_iPhone12_12Pro;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone12ProMax) return TXAdapterPhoneType_iPhone12ProMax;
    return TXAdapterPhoneTypeOther;
}

@interface TESAdapter : NSObject

/** 共享适配器 */
+ (instancetype)shareAdapter;

/** 屏幕默认类型 默认为TESAdapterPhoneType_iPhone6_6S_7_8 */
@property(nonatomic)TESAdapterPhoneType defaultType;

/** 屏幕宽度 */
@property(nonatomic,assign)CGFloat defaultScreenWidth;

/** 屏幕高度 */
@property(nonatomic,assign)CGFloat defaultScreenHeight;

/** 放大系数*/
@property(nonatomic,assign)CGFloat defaultScreenRatio;

/// 状态栏高度
+ (CGFloat)statusBarHeight;

/// 导航栏高度
+ (CGFloat)navigationBarHeight;
/// 导航栏+状态栏高度
+ (CGFloat)navigationAndStatusHeight;

@end

///** 真实字体大小 */
static inline CGFloat tRealFontSize(CGFloat defaultSize) {

    //如果是iphone8
    if([TESAdapter shareAdapter].defaultType == tCurrentType()){
        return defaultSize;
    }
    
    return tScreenWidth() / [TESAdapter shareAdapter].defaultScreenWidth * defaultSize;

//    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){//如果是ipad
//        return defaultSize * 1.5;
//    }
    
//    return defaultSize;

//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//
//    if(app.blockRotation){//横屏
////        NSLog(NSLocalizedString(@"横屏", @"横屏"));
//        return defaultSize;
//    }else{
//
////        NSLog(NSLocalizedString(@"竖屏", @"竖屏"));
//        return tScreenWidth() / [TESAdapter shareAdapter].defaultScreenWidth * defaultSize;
//
//    }

}

static inline CGFloat tesAuto(CGFloat defaultLength) {

    if([TESAdapter shareAdapter].defaultType == tCurrentType()){
        NSLog(@"defaultLength:%f",defaultLength);
        return defaultLength;
    }
    NSLog(@"tScreenWidth:%f", tScreenWidth());
    NSLog(@"defaultScreenWidth:%f", [TESAdapter shareAdapter].defaultScreenWidth);

    return tScreenWidth() / [TESAdapter shareAdapter].defaultScreenWidth * defaultLength;
}

static inline NSString* imgLocalizedString(NSString *key) {
    return NSLocalizedStringFromTable(key, @"ImageLocalizable", nil);
}

static inline CGFloat imagegAuto(CGFloat defaultLength) {

    if([TESAdapter shareAdapter].defaultType == tCurrentType()){
        return defaultLength;
    }

    return tScreenWidth() / [TESAdapter shareAdapter].defaultScreenWidth * defaultLength;
}

/** 根据设备返回缩放因子 */
static inline NSInteger tesDeviceRender() {
    switch (tCurrentType()) {
        case TXAdapterPhoneType_iPhone3GS_4_4S:
        case TXAdapterPhoneType_iPhone5_5C_5S_5SE:
        case TXAdapterPhoneType_iPhone6_6S_7_8_SE:
//            NSLog(@"tesDeviceRender:2");
            return 2;
            break;
        case  TXAdapterPhoneType_iPhoneX_XS_11Pro_12mini:
        case  TXAdapterPhoneType_iPhoneXSMax_XR_11_11ProMax:
        case  TXAdapterPhoneType_iPhone12_12Pro:
        case  TXAdapterPhoneType_iPhone12ProMax:
//            NSLog(@"tesDeviceRender:3");
            return 3;
        default:
            break;
    }
//    NSLog(@"tesDeviceRender:2");
//    NSLog(@"tesDeviceRender:2");
//    NSLog(@"tesDeviceRender:2");
    return 2;
}

static inline CGFloat tesLocal(CGFloat defaultLength) {

    if([TESAdapter shareAdapter].defaultType == tCurrentType()){
        return defaultLength;
    }
//    else if ((UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)){
//        return defaultLength * 1.5;
//    }

    return tScreenWidth() / [TESAdapter shareAdapter].defaultScreenWidth * defaultLength;
}




NS_ASSUME_NONNULL_END
