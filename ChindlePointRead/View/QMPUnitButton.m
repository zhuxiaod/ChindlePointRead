//
//  QMPUnitButton.m
//  QiMengProject
//
//  Created by mac on 2021/3/11.
//

#import "QMPUnitButton.h"

@interface QMPUnitButton ()

@property(nonatomic,strong)CAShapeLayer *maskLayer;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UIView *shadowView;
@property(nonatomic,strong)UIView *backgroundMaskView;
@property(nonatomic,strong)UIView *shadowMaskView;

@end

@implementation QMPUnitButton

- (instancetype)initWithType:(QMPUnitButtonType)type buttonStatus:(QMPUnitButtonStatus)buttonStatus buttonW:(CGFloat)buttonW
{
    self = [super init];
    if (self) {
        _unitButtonType = type;
        _unitButtonStatus = buttonStatus;
                
        self.layer.needsDisplayOnBoundsChange = YES;
        
        self.userInteractionEnabled = YES;
        
        [self creatButtonUI:type buttonStatus:buttonStatus];
    }
    return self;
}

-(void)creatButtonUI:(QMPUnitButtonType)type buttonStatus:(QMPUnitButtonStatus)buttonStatus{
    //背景
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.userInteractionEnabled = NO;
    backgroundView.cornerRadius = tesAuto(8);
    _backgroundView = backgroundView;
    [self addSubview:backgroundView];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.equalTo(self);
    }];
    
    //底线
    UIView *shadowView = [[UIView alloc] init];
    shadowView.userInteractionEnabled = NO;
    _shadowView = shadowView;
    [backgroundView addSubview:shadowView];
    
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.equalTo(backgroundView);
        make.height.mas_equalTo(tesAuto(2));
    }];
    
    //右边背景蒙版
    UIView *backgroundMaskView = [[UIView alloc] init];
    _backgroundMaskView = backgroundMaskView;
    backgroundView.userInteractionEnabled = NO;
    [self addSubview:backgroundMaskView];
    
    [backgroundMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(tesAuto(10));
        type == QMPUnitButtonTypeLeft?make.right.equalTo(self):make.left.equalTo(self);
    }];
    
    //右边底线蒙版
    UIView *shadowMaskView = [[UIView alloc] init];
    _shadowMaskView = shadowMaskView;
    shadowMaskView.userInteractionEnabled = NO;
    [self addSubview:shadowMaskView];
    
    [shadowMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.mas_equalTo(tesAuto(10));
        make.height.mas_equalTo(tesAuto(2));
        type == QMPUnitButtonTypeLeft?make.right.equalTo(self):make.left.equalTo(self);
    }];

    //文字显示
    UILabel *titleLab = [UILabel tes_creatLabWithText:@"" fontSize:tRealFontSize(14)];
    _titleLab = titleLab;
    titleLab.textColor = buttonStatus == QMPUnitButtonStatusNormal?[UIColor AppOrangeColor]:[UIColor AppTextBrownColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.bottom.equalTo(self);
    }];
    
    _backgroundView.backgroundColor = buttonStatus == QMPUnitButtonStatusNormal?[UIColor AppLightRedBgColor]:[UIColor AppYellowColor];
    _shadowView.backgroundColor = buttonStatus == QMPUnitButtonStatusSelected?[UIColor colorWithRed:255/255.0 green:192/255.0 blue:0/255.0 alpha:1.0]:[UIColor colorWithRed:255/255.0 green:202/255.0 blue:194/255.0 alpha:1.0];
    _backgroundMaskView.backgroundColor = buttonStatus == QMPUnitButtonStatusNormal?[UIColor AppLightRedBgColor]:[UIColor AppYellowColor];
    _shadowMaskView.backgroundColor = buttonStatus == QMPUnitButtonStatusSelected?[UIColor colorWithRed:255/255.0 green:192/255.0 blue:0/255.0 alpha:1.0]:[UIColor colorWithRed:255/255.0 green:202/255.0 blue:194/255.0 alpha:1.0];
}

- (void)setUnitButtonStatus:(QMPUnitButtonStatus)unitButtonStatus{
    _unitButtonStatus = unitButtonStatus;
    
    WeakifySelf();
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.backgroundView.backgroundColor = weakSelf.unitButtonStatus == QMPUnitButtonStatusNormal?[UIColor AppLightRedBgColor]:[UIColor AppYellowColor];
        weakSelf.shadowView.backgroundColor = weakSelf.unitButtonStatus == QMPUnitButtonStatusSelected?[UIColor colorWithRed:255/255.0 green:192/255.0 blue:0/255.0 alpha:1.0]:[UIColor colorWithRed:255/255.0 green:202/255.0 blue:194/255.0 alpha:1.0];
        weakSelf.backgroundMaskView.backgroundColor = weakSelf.unitButtonStatus == QMPUnitButtonStatusNormal?[UIColor AppLightRedBgColor]:[UIColor AppYellowColor];
        weakSelf.shadowMaskView.backgroundColor = weakSelf.unitButtonStatus == QMPUnitButtonStatusSelected?[UIColor colorWithRed:255/255.0 green:192/255.0 blue:0/255.0 alpha:1.0]:[UIColor colorWithRed:255/255.0 green:202/255.0 blue:194/255.0 alpha:1.0];
        weakSelf.titleLab.textColor = (weakSelf.unitButtonStatus == QMPUnitButtonStatusNormal?[UIColor AppOrangeColor]:[UIColor AppTextBrownColor]);
    }];
    
}

//设置数据
- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    //选中状态
    if(_unitButtonStatus == QMPUnitButtonStatusSelected){
        _titleLab.text = [titleString substringToIndex:6];
    }else{
        //如果是不是unit 显示前六位
        NSString *unitName = [titleString substringToIndex:4];
        
        //修改按钮宽度
        _titleLab.text = [unitName containsString:@"Un"]?[titleString substringWithRange:NSMakeRange(4,2)]:[titleString substringToIndex:6];
        
        if(self.modifyButtonWidthBlock && [unitName containsString:@"Un"] == NO){
            self.modifyButtonWidthBlock(self);
        }
    }
}

- (void)setUnitModel:(QMPUnitModel *)unitModel{
    _unitModel = unitModel;
    self.titleString = unitModel.name;
}


@end
