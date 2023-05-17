//
//  AppShareView.m
//  ChindlePointRead
//
//  Created by 朱𣇈丹 on 2023/5/4.
//

#import "AppShareView.h"

@interface AppShareView ()


@end

@implementation AppShareView

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIView *bjView = [[UIView alloc] init];
    bjView.backgroundColor = [[UIColor AppLabBlackColor] colorWithAlphaComponent:0.3];
    [self addSubview:bjView];
    
    [bjView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *shareContentView = [[UIView alloc] init];
    shareContentView.backgroundColor = [UIColor AppWhiteColor];
    [self addSubview:shareContentView];
    
    UIImageView *momentImgView = [[UIImageView alloc] init];
    momentImgView.image = [UIImage mainResourceImageNamed:@"ShareMomment"];
    [shareContentView addSubview:momentImgView];
    
    [momentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareContentView).offset(tesAuto(24));
        make.centerX.equalTo(shareContentView);
        make.height.width.mas_equalTo(tesAuto(44));
    }];
    
    UILabel *momentLab = [[UILabel alloc] init];
    momentLab.text = @"朋友圈";
    momentLab.font = [UIFont systemFontOfSize:tRealFontSize(12)];
    momentLab.textColor = [UIColor AppGrayTitleColor];
    [shareContentView addSubview:momentLab];
    
    [momentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(momentImgView);
        make.top.equalTo(momentImgView.mas_bottom).offset(tesAuto(10));
    }];
    
    UIImageView *wxImgView = [[UIImageView alloc] init];
    wxImgView.image = [UIImage mainResourceImageNamed:@"ShareWX"];
    [shareContentView addSubview:wxImgView];
    
    [wxImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(momentImgView);
        make.height.width.mas_equalTo(tesAuto(44));
        make.right.equalTo(momentImgView.mas_left).offset(-tesAuto(70));
    }];
    
    UILabel *wxLab = [[UILabel alloc] init];
    wxLab.text = @"微信";
    wxLab.font = [UIFont systemFontOfSize:tRealFontSize(12)];
    wxLab.textColor = [UIColor AppGrayTitleColor];
    [shareContentView addSubview:wxLab];
    
    [wxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxImgView.mas_bottom).offset(tesAuto(10));
        make.centerX.equalTo(wxImgView);
    }];
    
    UIImageView *creatImgView = [[UIImageView alloc] init];
    creatImgView.image = [UIImage mainResourceImageNamed:@"CreatShareImg"];
    [shareContentView addSubview:creatImgView];
    
    [creatImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(momentImgView);
        make.height.width.mas_equalTo(tesAuto(44));
        make.left.equalTo(momentImgView.mas_right).offset(tesAuto(70));
    }];
    
    UILabel *creatImgLab = [[UILabel alloc] init];
    creatImgLab.text = @"下载图片";
    creatImgLab.font = [UIFont systemFontOfSize:tRealFontSize(12)];
    creatImgLab.textColor = [UIColor AppGrayTitleColor];
    [shareContentView addSubview:creatImgLab];
    
    [creatImgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(creatImgView.mas_bottom).offset(tesAuto(10));
        make.centerX.equalTo(creatImgView);
    }];
    
    [shareContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(tesAuto(120));
    }];
    
    UIButton *wxBtn = [[UIButton alloc] init];
    wxBtn.tag = 101;
    [wxBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [shareContentView addSubview:wxBtn];
    
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxImgView);
        make.right.left.equalTo(wxImgView);
        make.bottom.equalTo(wxLab);
    }];
    
    UIButton *momentBtn = [[UIButton alloc] init];
    momentBtn.tag = 102;
    [momentBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [shareContentView addSubview:momentBtn];
    
    [momentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(momentImgView);
        make.right.left.equalTo(momentImgView);
        make.bottom.equalTo(momentLab);
    }];
    
    UIButton *creatImgBtn = [[UIButton alloc] init];
    creatImgBtn.tag = 103;
    [creatImgBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [shareContentView addSubview:creatImgBtn];
    
    [creatImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(creatImgView);
        make.right.left.equalTo(creatImgView);
        make.bottom.equalTo(creatImgLab);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setBackgroundImage:[UIImage mainResourceImageNamed:@"endView_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [shareContentView addSubview:cancelBtn];

    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareContentView).offset(tesAuto(16));
        make.right.equalTo(shareContentView).offset(-tesAuto(16));
        make.height.width.mas_equalTo(tesAuto(24));
    }];
    
    UIView *contentView = [[UIView alloc] init];
    _contentView = contentView;
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.bottom.equalTo(shareContentView.mas_top);
    }];

}

-(void)clickBtn:(UIButton *)btn{
    
    if(self.shareBlock){
        self.shareBlock(btn.tag);
    }
    
}

-(void)removeView{
    
    [self removeFromSuperview];
}

@end
