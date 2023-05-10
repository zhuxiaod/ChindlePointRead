//
//  QMPInteractionDetailView.m
//  QiMengProject
//
//  Created by mac on 2021/3/16.
//

#import "QMPInteractionDetailView.h"
#import <ChindleKit/ChindleKit-Swift.h>

@interface QMPInteractionDetailView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *totalLab;

@property(nonatomic,strong)UIButton *checkButton;
@property(nonatomic,strong)UIButton *soundButton;
@property(nonatomic,strong)UIButton *lastPageButton;
@property(nonatomic,strong)UIButton *nextPageButton;

@property(nonatomic,strong)UIView *bottomView;

@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation QMPInteractionDetailView

- (CGFloat)bookViewOldH{
    
    return tesAuto(310);
}

- (CGFloat)bookViewOldW{
    NSLog(@"bookViewOldW:%lf",tesAuto(550));
    return tesAuto(550);
}

- (CGFloat)bookViewH{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        NSLog(@"ts:%lf", tScreenWidth());
        NSLog(@"ks:%lf", kScreenWidth);
        return kScreenWidth - tesAuto(68);
    }
    return tesAuto(310);
}

- (CGFloat)bookViewW{
//    702.548726 306.139430 395.982009
    //576.400000 321.736000 324.880000
    NSLog(@"%f %f %f",self.bookViewOldW,self.bookViewH,self.bookViewOldH);
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
        self.backgroundColor = [UIColor AppLightRedBgColor];
        
        [self setupBgView];
        
        [self setupTitleView];

        [self setupContentView];

        [self setupMenuButtons];
        
        [self setupButtonClickBlock];
    }
 
    return self;
}

-(void)setupBgView{
    //标题栏
    QMPEnglishInteractionTitleView *titleView  = [[QMPEnglishInteractionTitleView alloc] init];
    titleView.isHiddenTitleImgView = YES;
    [self addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    _bottomView = bottomView;
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.shadowColor = [UIColor colorWithRed:240/255.0 green:33/255.0 blue:0/255.0 alpha:0.24].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0,-tesAuto(37));
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowRadius = tesAuto(37);
    [self addSubview:bottomView];
    

}

-(void)setupTitleView{
    
    UIStackView *stackView = [[UIStackView alloc] init];
    _stackView = stackView;
    [self addSubview:stackView];
    
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(tesAuto(264));
        make.height.mas_equalTo(tesAuto(50));
    }];
    
    UILabel *totalLab = [UILabel tes_creatLabWithText:@"1/10" fontSize:tRealFontSize(16) textColor:[UIColor AppOrangeColor]];
    _totalLab = totalLab;
    totalLab.textAlignment = NSTextAlignmentCenter;
    totalLab.borderColor = [UIColor AppOrangeColor];
    totalLab.borderWidth = 1.0f;
    totalLab.cornerRadius = tesAuto(28) / 2;
//    totalLab.size = CGSizeMake(tesAuto(60), tesAuto(28));
//    [self addSubview:totalLab];
//
    [totalLab mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.equalTo(self).offset(tesAuto(12));
//        make.left.equalTo(self.mas_centerX).offset(tesAuto(30));
        make.height.mas_equalTo(tesAuto(28));
        make.width.mas_equalTo(tesAuto(60));
    }];
    
    UILabel *titleLab = [UILabel tes_creatLabWithText:@" " fontSize:tRealFontSize(16) textColor:[UIColor AppDarkGrayColor]];
    titleLab.textAlignment = NSTextAlignmentRight;
    titleLab.numberOfLines = 0;
    titleLab.font = [UIFont boldSystemFontOfSize:tRealFontSize(16)];
    _titleLab = titleLab;
//    [self addSubview:titleLab];
//
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make){
//        make.right.equalTo(totalLab.mas_left).offset(-tesAuto(12));
//        make.centerY.equalTo(totalLab);
        make.size.mas_equalTo([titleLab tes_sizeThatFits]);
    }];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = tesAuto(12);
    [stackView addArrangedSubview:titleLab];
    [stackView addArrangedSubview:totalLab];

    
    
}

#pragma mark - 舞台
-(void)setupContentView{
    //550 310
    UIView *contentView = [[UIView alloc] init];
    contentView.cornerRadius = tesAuto(10);
    contentView.backgroundColor = [UIColor AppWhiteColor];
    _contentView = contentView;
    [self addSubview:contentView];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-tesAuto(10));
            make.top.equalTo(self.stackView.mas_bottom).offset(tesAuto(8));
            make.width.mas_equalTo(self.bookViewW);
        }];
        
    }else{
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(self.bookViewW);
            make.height.mas_equalTo(self.bookViewH);

        }];
        
    }
    //518.359772 292.166417
    //544.677419 307.000000
    NSLog(@"%f %f",self.bookViewW, self.bookViewH);
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView).offset(tesAuto(10));
        make.right.left.equalTo(self);
        make.height.mas_equalTo(tesAuto(37));
    }];
    
}

#pragma mark - 菜单按钮
-(void)setupMenuButtons{
    UIButton *checkButton = [self creatMenuButton:@"learn_icon_eye_close" selecteImgString:@"learn_icon_eye_open"];
    _checkButton = checkButton;
    [self addSubview:checkButton];
    
    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-tesAuto(36) - tesAuto(36));
        make.left.equalTo(self.contentView.mas_right);
        make.height.width.mas_equalTo(tesAuto(36) * self.verticalMultiple);
    }];
    
    UIButton *soundButton = [self creatMenuButton:@"learn_icon_listen" selecteImgString:@"learn_icon_listen"];
    _soundButton = soundButton;
    [self addSubview:soundButton];
    
    [soundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-tesAuto(12));
        make.left.equalTo(self.contentView.mas_right);
        make.height.width.mas_equalTo(tesAuto(36) * self.verticalMultiple);
    }];
    
    UIButton *lastPageButton = [self creatMenuButton:@"learn_icon_previous" selecteImgString:@"learn_icon_previous"];
    _lastPageButton = lastPageButton;
    [self addSubview:lastPageButton];
    
    [lastPageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(tesAuto(12));
        make.left.equalTo(self.contentView.mas_right);
        make.height.width.mas_equalTo(tesAuto(36) * self.verticalMultiple);
    }];
    
    UIButton *nextPageButton = [self creatMenuButton:@"learn_icon_next" selecteImgString:@"learn_icon_next"];
    _nextPageButton = nextPageButton;
    [self addSubview:nextPageButton];
    
    [nextPageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(+tesAuto(36) + tesAuto(36));
        make.left.equalTo(self.contentView.mas_right);
        make.height.width.mas_equalTo(tesAuto(36) * self.verticalMultiple);
    }];
}

#pragma mark - 设置按钮点击Block
-(void)setupButtonClickBlock{
    WeakifySelf();

    [_checkButton tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
        btn.selected = !btn.selected;
        if (weakSelf.clickCheckButtonBlock)weakSelf.clickCheckButtonBlock(btn.selected);
    }];
    
    [_soundButton tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
        if (weakSelf.clickSoundButtonBlock)weakSelf.clickSoundButtonBlock();
    }];
    
    [_lastPageButton tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
        if (weakSelf.clickLastPageButtonBlock)weakSelf.clickLastPageButtonBlock();
    }];
    
    [_nextPageButton tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
        if (weakSelf.clickNextPageButtonBlock)weakSelf.clickNextPageButtonBlock();
    }];
    
}

-(UIButton *)creatMenuButton:(NSString *)normalImgString selecteImgString:(NSString *)selecteImgString{
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setImage:[UIImage mainResourceImageNamed:normalImgString] forState:(UIControlStateNormal)];
    [menuButton setImage:[UIImage mainResourceImageNamed:selecteImgString] forState:(UIControlStateSelected)];
    menuButton.layer.backgroundColor = [UIColor AppYellowColor].CGColor;
    
    UIRectCorner rectCorner = UIRectCornerBottomRight | UIRectCornerTopRight;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, tesAuto(36) * self.verticalMultiple , tesAuto(36) * self.verticalMultiple) byRoundingCorners:rectCorner cornerRadii:CGSizeMake(tesAuto(8) * self.verticalMultiple, tesAuto(8) * self.verticalMultiple)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = bezierPath.CGPath;
    menuButton.layer.mask = maskLayer;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:0/255.0 alpha:1.0];
    [menuButton addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(menuButton);
        make.height.mas_equalTo(tesAuto(2));
    }];
    
    return menuButton;
}

- (void)setLessonNameString:(NSString *)lessonNameString{
    _lessonNameString = lessonNameString;
        
    _titleLab.text = lessonNameString;
    
    [_titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.titleLab tes_sizeThatFits].width);
    }];
}

- (void)setTotalCountString:(NSString *)totalCountString{
    _totalCountString = totalCountString;
}

- (void)setCurrentPageNumString:(NSString *)currentPageNumString{
    _currentPageNumString = currentPageNumString;
    _totalLab.text = [NSString stringWithFormat:@"%@/%@",_currentPageNumString,_totalCountString];
}

-(void)lastPageButtonBanClick{
    _lastPageButton.enabled = NO;
}

-(void)lastPageButtonClickAvailable{
    _lastPageButton.enabled = YES;
}

-(void)nextPageButtonBanClick{
    _nextPageButton.enabled = NO;
}

-(void)nextPageButtonClickAvailable{
    _nextPageButton.enabled = YES;
}

@end
