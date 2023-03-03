//
//  QMPUnitButton.h
//  QiMengProject
//
//  Created by mac on 2021/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QMPUnitButton;

//根据字数修改宽度
typedef void(^ModifyButtonWidthBlock)(QMPUnitButton *button);

//方向类型
typedef NS_ENUM(NSUInteger , QMPUnitButtonType){
    QMPUnitButtonTypeLeft,
    QMPUnitButtonTypeRight
};

//状态
typedef NS_ENUM(NSUInteger , QMPUnitButtonStatus){
    QMPUnitButtonStatusNormal,
    QMPUnitButtonStatusSelected
};



@interface QMPUnitButton : UIButton

@property(nonatomic,copy)NSString *titleString;
@property(nonatomic,copy)ModifyButtonWidthBlock modifyButtonWidthBlock;
@property(nonatomic,assign)QMPUnitButtonType unitButtonType;
@property(nonatomic,assign)QMPUnitButtonStatus unitButtonStatus;
@property(nonatomic,assign)CGFloat buttonWidth;

@property(nonatomic,strong)QMPUnitModel *unitModel;

- (instancetype)initWithType:(QMPUnitButtonType)type buttonStatus:(QMPUnitButtonStatus)buttonStatus buttonW:(CGFloat)buttonW;

@end


NS_ASSUME_NONNULL_END
