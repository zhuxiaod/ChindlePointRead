//
//  QMPImageLearnDeskView.h
//  QiMengProject
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PlayImageLearnItemVoiceBlock)(QMPImageLearnItemModel *itemModel);

@interface QMPImageLearnDeskView : UIView

@property(nonatomic,copy) PlayImageLearnItemVoiceBlock playImageLearnItemVoiceBlock;

@property(nonatomic,strong)NSString *backgroundImgUrl;

@property(nonatomic,strong)NSArray *imageLearnPageItemArray;

#pragma mark - 隐藏点图模块
-(void)hiddenPageItems;

#pragma mark - 显示点图模块
-(void)showPageItems;

@end

NS_ASSUME_NONNULL_END
