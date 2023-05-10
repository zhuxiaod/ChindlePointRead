//
//  AppShareView.h
//  ChindlePointRead
//
//  Created by 朱𣇈丹 on 2023/5/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShareBlock)(NSInteger tag);

@interface AppShareView : UIView

@property(nonatomic,copy)ShareBlock shareBlock;

@property (nonatomic, strong) UIView *contentView;

@end

NS_ASSUME_NONNULL_END
