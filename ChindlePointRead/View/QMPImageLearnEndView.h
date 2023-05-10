//
//  QMPImageLearnEndView.h
//  QiMengProject
//
//  Created by mac on 2021/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GoBackLastVC)(void);

@interface QMPImageLearnEndView : UIView
@property(nonatomic,copy) GoBackLastVC goBackLastVC;
@property(nonatomic,copy) GoBackLastVC jumpTes;

@end

NS_ASSUME_NONNULL_END
