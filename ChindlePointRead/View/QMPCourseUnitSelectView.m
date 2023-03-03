//
//  QMPCourseUnitSelectView.m
//  QiMengProject
//
//  Created by mac on 2021/3/11.
//

#import "QMPCourseUnitSelectView.h"
#import "QMPUnitButton.h"

@interface QMPCourseUnitSelectView ()
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)QMPUnitButton *button;
@property(nonatomic,strong)QMPUnitButton *selectedButton;
@property(nonatomic,strong)UIView *imgBox;
@property(nonatomic,strong)UILabel *unitNameLab;

@property(nonatomic,strong)NSArray *leftMenuButtonModelArray;
@property(nonatomic,strong)NSArray *rightMenuButtonModelArray;
@property(nonatomic,strong)NSMutableArray *leftMenuButtonArray;
@property(nonatomic,strong)NSMutableArray *rightMenuButtonArray;
@property(nonatomic,strong)QMPEnglishInteractionTitleView *titleView;

//原大小
@property(nonatomic,assign)CGFloat bookViewOldH;
@property(nonatomic,assign)CGFloat bookViewOldW;

//当前大小
@property(nonatomic,assign)CGFloat bookViewH;
@property(nonatomic,assign)CGFloat bookViewW;

//横向倍数
//@property(nonatomic,assign)CGFloat horizontalMultiple;
//纵向倍数
@property(nonatomic,assign)CGFloat verticalMultiple;

@property (nonatomic, strong) UIView *unitNameView;
@end

@implementation QMPCourseUnitSelectView

- (CGFloat)bookViewOldH{
    
    return tesAuto(290);
}

- (CGFloat)bookViewOldW{
    
    return tesAuto(510);
}

- (CGFloat)bookViewH{
    
    if(IS_IPHONE){
        return kScreenWidth - tesAuto(50) - tesAuto(15) - tesAuto(8) - tesAuto(12);
    }
    return tesAuto(290);
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


//按钮数据数组
- (NSArray *)leftMenuButtonModelArray{
    if(_leftMenuButtonModelArray == nil){
        _leftMenuButtonModelArray = [NSArray array];
    }
    return _leftMenuButtonModelArray;
}

- (NSArray *)rightMenuButtonModelArray{
    if(_rightMenuButtonModelArray == nil){
        _rightMenuButtonModelArray = [NSArray array];
    }
    return _rightMenuButtonModelArray;
}

//按钮数组
- (NSMutableArray *)leftMenuButtonArray{
    if(_leftMenuButtonArray == nil){
        _leftMenuButtonArray = [NSMutableArray array];
    }
    return _leftMenuButtonArray;
}

- (NSMutableArray *)rightMenuButtonArray{
    if(_rightMenuButtonArray == nil){
        _rightMenuButtonArray = [NSMutableArray array];
    }
    return _rightMenuButtonArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupBgView];
        
        [self setupBookBgView];

        [self setupUnitNameView];
        
        self.backgroundColor = [UIColor AppLightRedBgColor];
    }
    return self;
}

- (void)setUnitModelList:(NSArray *)unitModelList{
    _unitModelList = unitModelList;
    
    self.leftMenuButtonModelArray = _unitModelList.count >= 5?[[unitModelList mutableCopy] subarrayWithRange:NSMakeRange(0, 5)]:unitModelList;
    
    self.rightMenuButtonModelArray = _unitModelList.count >= 10?[[unitModelList mutableCopy] subarrayWithRange:NSMakeRange(5, 5)]:[[unitModelList mutableCopy] subarrayWithRange:NSMakeRange(5, _unitModelList.count - 5)];

    [self setupUnitButton:YES dateArray:self.leftMenuButtonModelArray];
    [self setupUnitButton:NO dateArray:self.rightMenuButtonModelArray];
}

-(void)setupBgView{
    //标题栏
    QMPEnglishInteractionTitleView *titleView  = [[QMPEnglishInteractionTitleView alloc] init];
    _titleView = titleView;
    [self addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenWidth);
        make.width.mas_equalTo(kScreenHeight);
        make.left.top.equalTo(self);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    _bottomView = bottomView;
    bottomView.backgroundColor = [UIColor AppWhiteColor];
    bottomView.layer.shadowColor = [UIColor colorWithRed:240/255.0 green:33/255.0 blue:0/255.0 alpha:0.24].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0,-tesAuto(37));
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowRadius = tesAuto(37);
    [self addSubview:bottomView];

}

-(void)setupBookBgView{
    UIImageView *bookBgImgView = [[UIImageView alloc] initWithImage:[UIImage mainResourceImageNamed:@"learn_bg_book"]];
    bookBgImgView.userInteractionEnabled = YES;
    [self addSubview:bookBgImgView];
    
    [bookBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-tesAuto(10));
        if(IS_IPHONE){
            make.top.equalTo(self).offset(tesAuto(65));
        }else{
            make.centerY.equalTo(self);
        }
        make.centerX.equalTo(self);
        make.width.mas_equalTo(self.bookViewW);
        make.height.mas_equalTo(self.bookViewH);
    }];
    
    UIView *imgBox = [[UIView alloc] init];
    _imgBox = imgBox;
    [self addSubview:imgBox];
    
    [imgBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bookBgImgView).offset(tesAuto(15));
        make.right.equalTo(bookBgImgView).offset(-tesAuto(15));
        make.top.bottom.equalTo(bookBgImgView);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bookBgImgView).offset(tesAuto(10));
        make.right.left.equalTo(self);
        make.height.mas_equalTo(tesAuto(37));
    }];
    
//    NSArray *buttonModelArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
//    [self setupUnitButton:YES dateArray:buttonModelArray];
//    [self setupUnitButton:NO dateArray:buttonModelArray];
}

-(void)setupUnitButton:(BOOL)isLeft dateArray:(NSArray *)dateArray{
    
    //根据方向移除按钮
    [self removeMenuButtonWithDirection:isLeft];
    
    CGFloat buttonY = tesAuto(38) * self.verticalMultiple;
    CGFloat buttonH = tesAuto(34) * self.verticalMultiple;
    CGFloat buttonW = [self horizontalMultiple:isLeft?tesAuto(55):tesAuto(34)];
    CGFloat bgViewW = [self horizontalMultiple:isLeft?tesAuto(55):tesAuto(55)];

    for (NSInteger i = 0; i < dateArray.count; i++) {
        
        QMPUnitButton *button = [[QMPUnitButton alloc] initWithType:isLeft?QMPUnitButtonTypeLeft:QMPUnitButtonTypeRight buttonStatus:(i==0 && isLeft == YES)?QMPUnitButtonStatusSelected:QMPUnitButtonStatusNormal buttonW:0];
        
        button.masksToBounds = YES;
        button.userInteractionEnabled = YES;
        _button = button;
        [button addTarget:self action:@selector(performButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:button];
        
        if(isLeft == YES){
            [self.leftMenuButtonArray addObject:button];
        }else{
            [self.rightMenuButtonArray addObject:button];
        }
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            isLeft == YES?make.right.equalTo(self.imgBox.mas_left):make.left.equalTo(self.imgBox.mas_right);
            make.top.equalTo(self.imgBox).offset(buttonY);
            make.width.mas_equalTo(buttonW);
            make.height.mas_equalTo(buttonH);
        }];
        
        //修改宽度
        WeakifySelf();
        button.modifyButtonWidthBlock = ^(QMPUnitButton * _Nonnull button) {
            [weakSelf modifyButtonWidthBlock:button];
        };
        
        //设置数据
        [self setupMenuButtonData:isLeft button:button index:i];
        
        if(i == 0 && isLeft == YES){
            _selectedButton = button;
            
            //unit 名字

            //更新数据
            [self loadLessonData:button];
        }
        
        buttonW = [self horizontalMultiple:tesAuto(34)];
        bgViewW = [self horizontalMultiple:tesAuto(34)];
        
        buttonY = buttonY + tesAuto(10) * self.verticalMultiple + buttonH;
    }
}

//修改按钮宽度
-(void)modifyButtonWidthBlock:(QMPUnitButton *)button{
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(tesAuto(46));
    }];
}

//根据方向移除按钮
-(void)removeMenuButtonWithDirection:(BOOL)isLeft{
    //初始化按钮
    if(isLeft == YES){
        [self removeMenuButton:self.leftMenuButtonArray];
        self.leftMenuButtonArray = nil;
    }else{
        [self removeMenuButton:self.rightMenuButtonArray];
        self.rightMenuButtonArray = nil;
    }
}

//移除按钮
-(void)removeMenuButton:(NSMutableArray *)menuButtonArray{
    for (QMPUnitButton *button in menuButtonArray) {
        [button removeFromSuperview];
    }
}

//设置按钮数据
-(void)setupMenuButtonData:(BOOL)isLeft button:(QMPUnitButton *)button index:(NSInteger)index{
    if(self.leftMenuButtonModelArray.count == 0 || self.rightMenuButtonModelArray.count == 0)return;
    //设置title
    QMPUnitModel *unitModel = isLeft == YES?self.leftMenuButtonModelArray[index]:self.rightMenuButtonModelArray[index];
    button.unitModel = unitModel;
    
    if(isLeft == YES && index == 0){
        
        [self setUnitNameWithString:unitModel.name];

    }
}

-(void)setUnitNameWithString:(NSString *)name{
    _unitNameLab.text = name;
    
    CGSize labWH = [QMPCommonTools getLabContentSize:name fontSize:tRealFontSize(16)];
    
    [self.unitNameView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(labWH.width + tesAuto(60));
    }];
}

#pragma mark - 选择单元按钮
-(void)performButton:(QMPUnitButton *)button{
    if(_selectedButton == button)return;

    CGFloat duration = 0.3;

    //当前按钮设置普通状态
    [_selectedButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([[self.selectedButton.titleString substringToIndex:4] containsString:@"Un"]?[self horizontalMultiple:tesAuto(34)]:[self horizontalMultiple:tesAuto(46)]);
    }];
    
    //修改按钮状态
    _selectedButton.unitButtonStatus = QMPUnitButtonStatusNormal;
    
    //当前按钮设置选择状态
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self horizontalMultiple:tesAuto(55)]);
    }];
    
    //修改选中按钮状态
    button.unitButtonStatus = QMPUnitButtonStatusSelected;
    
    //修改文字
    _selectedButton.titleString = _selectedButton.titleString;
    button.titleString = button.titleString;
    
    WeakifySelf();
    [UIView animateWithDuration:duration animations:^{
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.selectedButton = button;
    }];
    
    //更新数据
    [self loadLessonData:button];
    
    //修改单元名字
    [self setUnitNameWithString:button.unitModel.name];

}

//更新数据
-(void)loadLessonData:(QMPUnitButton *)button{
    if(self.loadLessonListBlock){
        self.loadLessonListBlock(button.unitModel);
    }
}

#pragma mark - 单元名字
-(void)setupUnitNameView{
    
    CGFloat cornerRadius = tesAuto(16) * self.verticalMultiple;
    
    UIView *unitNameView = [[UIView alloc] init];
    _unitNameView = unitNameView;
    unitNameView.borderWidth = 1;
    unitNameView.borderColor = [UIColor AppWhiteColor];
    unitNameView.cornerRadius = cornerRadius;
    [self addSubview:unitNameView];
    
    [unitNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgBox);
        make.bottom.equalTo(self.imgBox.mas_bottom).offset(tesAuto(8));
        make.width.mas_equalTo([self horizontalMultiple:tesAuto(210)]);
        make.height.mas_equalTo(tesAuto(32) * self.verticalMultiple);
    }];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.layer.backgroundColor = [[UIColor AppWhiteColor] colorWithAlphaComponent:0.7].CGColor;
    effectView.cornerRadius = cornerRadius;
    [unitNameView addSubview:effectView];
    
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(unitNameView);
        make.left.equalTo(unitNameView);
        make.right.equalTo(unitNameView);
        make.bottom.equalTo(unitNameView);
    }];
    
    UILabel *unitNameLab = [UILabel tes_creatLabWithText:@"" fontSize:16 textColor:[UIColor AppLabBlackColor]];
    _unitNameLab = unitNameLab;
    unitNameLab.font = [UIFont boldSystemFontOfSize:tRealFontSize(16)];
    unitNameLab.textAlignment = NSTextAlignmentCenter;
    [unitNameView addSubview:unitNameLab];
    
    [unitNameLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.centerY.equalTo(unitNameView);
        make.width.mas_equalTo(effectView);
        make.height.mas_equalTo(effectView);
    }];
}

#pragma mark - 内容区
-(void)setupContentItemsWithArray:(NSArray *)lessonModelList{
    //清空内容
    [self.imgBox removeAllSubviews];

    CGFloat viewX = 0.0;
    CGFloat viewY = 0.0;
    CGFloat viewW = (self.bookViewW - [self horizontalMultiple:tesAuto(30)]) / 2;
    CGFloat viewH = self.bookViewH / 2 - tesAuto(15) * self.verticalMultiple;
    for (NSInteger i = 0; i < lessonModelList.count; i++) {
        UIView *placeholderView = [[UIView alloc] init];
        [self.imgBox addSubview:placeholderView];
        
        [placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(viewW);
            make.height.mas_equalTo(viewH);
            make.top.equalTo(self.imgBox).offset(viewY);
            make.left.equalTo(self.imgBox).offset(viewX);
        }];
        
        //设置内容页
        QMPUnitCoverView *unitCoverView = [[QMPUnitCoverView alloc] init];
        unitCoverView.tag = i;
        unitCoverView.unitTitleLab.text = [NSString stringWithFormat:@"L%ld",i + 1];
        unitCoverView.lessonModel = self.lessonModelList[i];
        [placeholderView addSubview:unitCoverView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        //设置属性
        //tap 手势一共两个属性，一个是设置轻拍次数，一个是设置点击手指个数
        //设置轻拍次数
        tap.numberOfTapsRequired = 1;
        //设置手指字数
        tap.numberOfTouchesRequired = 1;
        //别忘了添加到testView上
        [unitCoverView addGestureRecognizer:tap];
        
        [unitCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
            switch (i) {
                case 0:
                    make.top.equalTo(placeholderView.mas_top).offset(tesAuto(17) * self.verticalMultiple);
                    make.right.equalTo(placeholderView.mas_right).offset([self horizontalMultiple:-tesAuto(39)]);
                    break;
                case 1:
                    make.top.equalTo(placeholderView.mas_top).offset(tesAuto(17) * self.verticalMultiple);
                    make.left.equalTo(placeholderView.mas_left).offset([self horizontalMultiple:tesAuto(39)]);
                    break;
                case 2:
                    make.top.equalTo(placeholderView.mas_top).offset(tesAuto(12) * self.verticalMultiple);
                    make.right.equalTo(placeholderView.mas_right).offset([self horizontalMultiple:-tesAuto(39)]);
                    break;
                case 3:
                    make.top.equalTo(placeholderView.mas_top).offset(tesAuto(12) * self.verticalMultiple);
                    make.left.equalTo(placeholderView.mas_left).offset([self horizontalMultiple:tesAuto(39)]);
                    break;
                default:
                    break;
            }
            make.width.mas_equalTo([self horizontalMultiple:tesAuto(157)]);
            make.height.mas_equalTo(tesAuto(113) * self.verticalMultiple);
        }];
        
        viewX = viewX + viewW;
        
        if(i == 1){
            viewX = 0.0;
            viewY = viewH;
        }
    }
}

#pragma mark - 选择课程
-(void)tapView:(UITapGestureRecognizer *)tap{
    QMPLessonModel *lessonModel = _lessonModelList[tap.view.tag];
    if(self.selectedLessonItemBlock){
        self.selectedLessonItemBlock(lessonModel);
    }
}

#pragma mark - 设置课程数据
- (void)setLessonModelList:(NSArray *)lessonModelList{
    _lessonModelList = lessonModelList;
    
    [self setupContentItemsWithArray:lessonModelList];
}

#pragma mark - 设置课本名字
- (void)setBookName:(NSString *)bookName{
    _bookName = bookName;
    
    _titleView.titleString = bookName;

}

@end

@interface QMPUnitCoverView ()
@property(nonatomic,strong)UILabel *courseTitleLab;
@property(nonatomic,strong)UIImageView *coverImgView;
@end

@implementation QMPUnitCoverView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        
        [self addShadowEffect];
        
    }
    return self;
}

-(void)setupUI{
    //边线
    UIView *lineView = [[UIView alloc] init];
    lineView.borderColor = [UIColor AppLightRedLineColor];
    lineView.borderWidth = 1.0f;
    lineView.cornerRadius = tesAuto(6);
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(tesAuto(2));
        make.left.equalTo(self).offset(tesAuto(2));
        make.right.equalTo(self).offset(-tesAuto(2));
        make.bottom.equalTo(self).offset(-tesAuto(2));
    }];
    
    UIView *topView = [[UIView alloc] init];
//    topView.backgroundColor = [UIColor redColor];
    [self addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(lineView);
        make.height.mas_equalTo(tesAuto(24));
    }];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.image = [UIImage mainResourceImageNamed:@"learn_icon_tag"];
    [topView addSubview:iconView];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(topView).offset(tesAuto(6));
        make.height.mas_equalTo(tesAuto(14));
        make.width.mas_equalTo(tesAuto(24));
    }];
    
    UILabel *unitTitleLab = [UILabel tes_creatLabWithText:@" " fontSize:tesAuto(9) textColor:[UIColor AppWhiteColor]];
    _unitTitleLab = unitTitleLab;
    unitTitleLab.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:unitTitleLab];
    
    [unitTitleLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(iconView);
    }];
    
    UILabel *courseTitleLab = [UILabel tes_creatLabWithText:@"" fontSize:12 textColor:[UIColor AppTextBrownColor]];
    _courseTitleLab = courseTitleLab;
    courseTitleLab.font = [UIFont boldSystemFontOfSize:tRealFontSize(12)];
    [topView addSubview:courseTitleLab];
    
    [courseTitleLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(iconView);
        make.left.equalTo(iconView.mas_right).offset(tesAuto(6));
        make.right.equalTo(topView.mas_right).offset(-tesAuto(6));
        make.height.mas_equalTo([QMPCommonTools getTextHeightWithFontSize:tRealFontSize(12)]);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.right.left.equalTo(lineView);
        make.bottom.equalTo(lineView);
    }];
    
    UIImageView *coverImgView = [[UIImageView alloc] initWithImage:[UIImage mainResourceImageNamed:@""]];
    _coverImgView = coverImgView;
    coverImgView.cornerRadius = tesAuto(2);
    [bottomView addSubview:coverImgView];
    
    [coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView);
        make.left.equalTo(bottomView).offset(tesAuto(6));
        make.right.equalTo(bottomView).offset(-tesAuto(6));
        make.bottom.equalTo(bottomView).offset(-tesAuto(6));
    }];
}

-(void)addShadowEffect{
    self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:254/255.0 alpha:1.0];
    self.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:209/255.0 blue:174/255.0 alpha:0.37].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,5);//偏移 0 为四周发散
    self.layer.shadowOpacity = 1;//阴影程度
    self.layer.shadowRadius = tesAuto(6.0f);
    self.layer.cornerRadius = tesAuto(6);
    self.layer.shadowPath = [QMPCommonTools getShadowPath:CGRectMake(0, 0, tesAuto(157), tesAuto(113))].CGPath;
}

- (void)setLessonModel:(QMPLessonModel *)lessonModel{
    _lessonModel = lessonModel;
    
    _courseTitleLab.text = lessonModel.name;
    [_coverImgView sd_setImageWithURL:[NSURL URLWithString:lessonModel.cover]];
}

@end
