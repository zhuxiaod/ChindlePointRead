//
//  QMPEnglishInteractionTitleView.m
//  QiMengProject
//
//  Created by mac on 2021/3/11.
//

#import "QMPEnglishInteractionTitleView.h"

@interface QMPEnglishInteractionTitleView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *titleImgView;
@end

@implementation QMPEnglishInteractionTitleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    //title背景
    UIImageView *titleBgImgView = [[UIImageView alloc] init];
    titleBgImgView.userInteractionEnabled = YES;
    titleBgImgView.image = [UIImage mainResourceImageNamed:@"learn_bg_light"];
    [self addSubview:titleBgImgView];
    
    [titleBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-tesAuto(10));
        make.width.mas_equalTo(tesAuto(365));
    }];
    
    //titleImg
    UIImageView *titleImgView = [[UIImageView alloc] init];
    _titleImgView = titleImgView;
    titleImgView.userInteractionEnabled = YES;
    titleImgView.image = [UIImage mainResourceImageNamed:@"learn_bg_nav"];
    [self addSubview:titleImgView];
    
    [titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(tesAuto(264));
        make.height.mas_equalTo(tesAuto(50));
    }];
        
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"test";
    titleLab.textColor = [UIColor AppTextBrownColor];
    [titleLab sizeToFit];
    titleLab.font = [UIFont boldSystemFontOfSize:tRealFontSize(16)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab = titleLab;
    [self addSubview:titleLab];

    [titleLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(titleImgView);
    }];
}

-(void)setIsHiddenTitleImgView:(BOOL)isHiddenTitleImgView{
    _isHiddenTitleImgView = isHiddenTitleImgView;
    _titleImgView.hidden = isHiddenTitleImgView;
    _titleLab.hidden = isHiddenTitleImgView;
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLab.text = titleString;
}
@end
