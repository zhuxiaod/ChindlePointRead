//
//  TalkWebShareView.m
//  talk915Evaluation
//
//  Created by 贺怀民 on 2023/2/1.
//

#import "TalkWebShareView.h"
#import "UIView+Extension.h"

@interface TalkWebShareView()

@property (nonatomic,strong)  UIView *bjView;
@property (nonatomic,strong)  UIControl *hudControl;
@property (nonatomic,copy) NSString *urlStr;
@end

@implementation TalkWebShareView

-(instancetype)initWithWebShareUrl:(NSString *)urlStr{
    if (self = [super init]) {
        self.urlStr = urlStr;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    UIControl *hudControl = [[UIControl alloc]init];
//    [hudControl addTarget:self action:@selector(removeHudView) forControlEvents:UIControlEventTouchDown];
    hudControl.backgroundColor = [UIColor blackColor];
    hudControl.alpha = 0.6;
    [self addSubview:hudControl];
    [hudControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
    }];
    self.hudControl = hudControl;
    
    self.bjView = [[UIView alloc]init];
    self.bjView.userInteractionEnabled = YES;
    self.bjView.backgroundColor = [UIColor AppWhiteColor];
    [self addSubview:self.bjView];
    [self.bjView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(tesAuto(126) + tesAuto(50));
    }];
    self.bjView.hg_cornerRadius = tesAuto(12);
    self.bjView.hg_cornerPosition = HGCornerPositionTop;
    
    UIView *bottonView = [[UIView alloc]init];
    bottonView.cornerRadius = tesAuto(18);
    bottonView.backgroundColor =[UIColor colorWithHexString:@"#E6F3FF"];
    [self.bjView addSubview:bottonView];
    [bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjView).offset(tesAuto(20));
        make.left.equalTo(self.bjView).offset(16);
        make.right.equalTo(self.bjView).offset(-16);
        make.height.mas_equalTo(tesAuto(36));
    }];
    
    
    UIButton *shareCopyBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    [shareCopyBtn setTitle:@"复制链接" forState:UIControlStateNormal];
    [shareCopyBtn setTitleColor:[UIColor AppWhiteColor] forState:UIControlStateNormal];
    shareCopyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    shareCopyBtn.backgroundColor =[UIColor colorWithHexString:@"#0087FF"];
    shareCopyBtn.cornerRadius = tesAuto(18);
    [bottonView addSubview:shareCopyBtn];
    [shareCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottonView);
        make.size.mas_equalTo(CGSizeMake(tesAuto(100), tesAuto(36)));
    }];
    
    UILabel *titleLabel = [UILabel tes_creatLabWithText:[NSString stringWithFormat:@"91点读：%@",self.urlStr] fontSize:14 textColor:[UIColor AppLabBlackColor]];
    [bottonView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottonView).offset(15);
        make.centerY.equalTo(bottonView);
        make.right.equalTo(shareCopyBtn.mas_left).offset(-10);
    }];
    
    UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn setTitleColor:[UIColor AppLabBlackColor] forState:UIControlStateNormal];
    [self.bjView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottonView.mas_bottom).offset(tesAuto(20));
        make.left.right.equalTo(self.bjView);
        make.height.mas_equalTo(tesAuto(40));
    }];
    WeakifySelf();
    [shareCopyBtn tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
        [weakSelf copyURL];
    }];
    [cancelBtn tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
        [weakSelf removeFromSuperview];
    }];
    
}
-(void)copyURL{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:[NSString stringWithFormat:@"%@",self.urlStr]];
    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
