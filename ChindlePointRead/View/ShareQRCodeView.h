//
//  ShareQRCodeView.h
//  ChindlePointRead
//
//  Created by 朱𣇈丹 on 2023/5/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareQRCodeView : UIView

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *courseNameLab;

- (UIImage *)snapshot;

-(void)setCourseName:(NSString *)courseName;

@end

NS_ASSUME_NONNULL_END
