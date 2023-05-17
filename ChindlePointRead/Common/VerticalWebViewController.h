//
//  VerticalWebViewController.h
//  ChindlePointRead
//
//  Created by 朱𣇈丹 on 2023/5/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LandscapeBlock)(void);

@interface VerticalWebViewController : KKUIWebViewController

@property (nonatomic, strong) LandscapeBlock landscapeBlock;

@end

NS_ASSUME_NONNULL_END
