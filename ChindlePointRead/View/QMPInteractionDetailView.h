//
//  QMPInteractionDetailView.h
//  QiMengProject
//
//  Created by mac on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickCheckButtonBlock)(BOOL isSelected);
typedef void(^ClickSoundButtonBlock)(void);
typedef void(^ClickLastPageButtonBlock)(void);
typedef void(^ClickNextPageButtonBlock)(void);

@interface QMPInteractionDetailView : UIView
@property(nonatomic,copy)ClickCheckButtonBlock clickCheckButtonBlock;
@property(nonatomic,copy)ClickSoundButtonBlock clickSoundButtonBlock;
@property(nonatomic,copy)ClickLastPageButtonBlock clickLastPageButtonBlock;
@property(nonatomic,copy)ClickNextPageButtonBlock clickNextPageButtonBlock;


@property(nonatomic,strong)NSString *lessonNameString;
@property(nonatomic,strong)NSString *totalCountString;
@property(nonatomic,strong)NSString *currentPageNumString;
@property(nonatomic,strong)UIView *contentView;

-(void)lastPageButtonBanClick;

-(void)lastPageButtonClickAvailable;

-(void)nextPageButtonBanClick;

-(void)nextPageButtonClickAvailable;

@end

NS_ASSUME_NONNULL_END
