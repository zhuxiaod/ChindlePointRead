//
//  QMPImageLearnEndView.m
//  QiMengProject
//
//  Created by mac on 2021/3/19.
//

#import "QMPImageLearnEndView.h"

@interface QMPImageLearnEndView()
@property(nonatomic,strong)UIButton *goBackButton;
@property(nonatomic,strong)UIButton *oKButton;

@end

@implementation QMPImageLearnEndView

- (CGFloat)bookViewOldH{
    
    return tesAuto(355);
}

- (CGFloat)bookViewOldW{
    
    return tesAuto(365);
}

- (CGFloat)bookViewH{
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        return kScreenWidth - tesAuto(10);
    }
    return tesAuto(355);
}

- (CGFloat)bookViewW{
    
    return self.bookViewOldW * self.bookViewH / self.bookViewOldH;
}

- (CGFloat)horizontalMultiple:(CGFloat)wValue{
    
    return wValue * self.bookViewW / self.bookViewOldW;
}

- (CGFloat)verticalMultiple{
    
    return self.bookViewH / self.bookViewOldH;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        
        [self setupButtonBlock];
    }
    return self;
}

-(void)setupUI{
    //添加背景按钮
    UIButton *blackView = [UIButton buttonWithType:UIButtonTypeCustom];
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:blackView];
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];

    blackView.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.2];
    
    UIImageView *lightImgView = [[UIImageView alloc] initWithImage:[UIImage mainResourceImageNamed:@"learn_bg_light_y"]];
    lightImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:lightImgView];
    
    [lightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(self.bookViewW);
        make.height.mas_equalTo(self.bookViewH);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.cornerRadius = tesAuto(10);
    [self addSubview:contentView];
    
   
    
    UIImageView *topTitleImgView = [[UIImageView alloc] initWithImage:[UIImage mainResourceImageNamed:@"learn_bg_congrats"]];
    topTitleImgView.contentMode = UIViewContentModeCenter;
    [self addSubview:topTitleImgView];
    
    [topTitleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).offset(-tesAuto(85) / 2* [self verticalMultiple]);
        make.centerX.equalTo(self);
        make.width.mas_equalTo([self horizontalMultiple:tesAuto(212)]);
        make.height.mas_equalTo(tesAuto(85) * [self verticalMultiple]);
    }];
    
    UILabel *titleLab = [UILabel tes_creatLabWithText:@"恭喜你" fontSize:18 textColor:[UIColor AppTextBrownColor]];
    titleLab.font = [UIFont boldSystemFontOfSize:tRealFontSize(18)];
    [self addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(topTitleImgView.mas_top).offset(tesAuto(24) * [self verticalMultiple]);
        make.centerX.equalTo(topTitleImgView);
    }];
    
    UILabel *detailLab = [UILabel tes_creatLabWithText:@"已完成此课程的学习!" fontSize:tRealFontSize(14) textColor:[UIColor AppDarkGrayColor]];
    [contentView addSubview:detailLab];
    
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView).offset(tesAuto(32) * [self verticalMultiple]);
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo([detailLab tes_sizeThatFits]);
    }];
    
    UIImageView *doneImgView = [[UIImageView alloc] initWithImage:[UIImage mainResourceImageNamed:@"learn_img_finish"]];
    [contentView addSubview:doneImgView];
    
    [doneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailLab.mas_bottom).offset(tesAuto(10) * [self verticalMultiple]);
        make.centerX.equalTo(contentView);
        make.width.mas_equalTo([self horizontalMultiple:tesAuto(130)]);
        make.height.mas_equalTo(tesAuto(96) * [self verticalMultiple]);
    }];
    
    UIButton *oKButton = [UIButton creatCustomButtonWithTitle:@"我还想上1V1英语课程" titleColor:[UIColor AppWhiteColor] fontSize:tRealFontSize(14)];
    _oKButton = oKButton;
    oKButton.cornerRadius = tesAuto(15) * [self verticalMultiple];
    oKButton.borderColor = [UIColor AppOrangeColor];
    oKButton.backgroundColor = [UIColor AppOrangeColor];
    oKButton.borderWidth = 1.0f;
    [contentView addSubview:oKButton];
    
    [oKButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(doneImgView.mas_bottom).offset(tesAuto(10) * [self verticalMultiple]);
        make.right.equalTo(contentView).offset(-[self horizontalMultiple:tesAuto(31)]);
        make.left.equalTo(contentView).offset([self horizontalMultiple:tesAuto(31)]);
        make.height.mas_equalTo(tesAuto(30) * [self verticalMultiple]);
    }];
    
    UIButton *goBackButton = [UIButton creatCustomButtonWithTitle:@"再来一课" titleColor:[UIColor AppOrangeColor] fontSize:tRealFontSize(14)];
    _goBackButton = goBackButton;
    goBackButton.cornerRadius = tesAuto(15) * [self verticalMultiple];
    goBackButton.backgroundColor = [UIColor AppWhiteColor];
    goBackButton.borderColor = [UIColor AppOrangeColor];
    goBackButton.borderWidth = 1.0f;
    [contentView addSubview:goBackButton];
    
    [goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oKButton.mas_bottom).offset(tesAuto(10) * [self verticalMultiple]);
        make.right.equalTo(contentView).offset(-[self horizontalMultiple:tesAuto(31)]);
        make.left.equalTo(contentView).offset([self horizontalMultiple:tesAuto(31)]);
        make.height.mas_equalTo(tesAuto(30) * [self verticalMultiple]);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset([self horizontalMultiple:tesAuto(95)]);
        make.width.mas_equalTo([self horizontalMultiple:tesAuto(232)]);
        make.bottom.equalTo(goBackButton.mas_bottom).offset(tesAuto(16) * [self verticalMultiple]);
//        make.height.mas_equalTo(tesAuto(220) * [self verticalMultiple]);
    }];
}

-(void)setupButtonBlock{
    WeakifySelf()
    [_oKButton tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
        [weakSelf removeFromSuperview];
        if(weakSelf.jumpTes)weakSelf.jumpTes();
    }];
    
    [_goBackButton tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
        if(weakSelf.goBackLastVC)weakSelf.goBackLastVC();
    }];
}
@end
