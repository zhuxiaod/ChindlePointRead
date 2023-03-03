//
//  QMPEnglishInteractionView.m
//  QiMengProject
//
//  Created by mac on 2021/3/10.
//

#import "QMPEnglishInteractionView.h"
#import "QMPLineCollectionViewFlowLayout.h"

@interface QMPEnglishInteractionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIView *bookshelfView;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)UIView *bookshelfBottomView;
@end

@implementation QMPEnglishInteractionView

- (void)setBookArray:(NSArray *)bookArray{
    _bookArray = bookArray;
    
    [self.collectionView reloadData];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor AppLightRedBgColor];

        [self setupUI];
    
        [self setupContentView];
    }
    return self;
}



-(void)setupUI{
    QMPEnglishInteractionTitleView *titleView  = [[QMPEnglishInteractionTitleView alloc] init];
    titleView.titleString = @"Magic Growth 系列";
    [self addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenWidth);
        make.width.mas_equalTo(kScreenHeight);
        make.left.top.equalTo(self);
    }];
    
    //书架UI
    UIView *bookshelfView = [[UIView alloc] init];
    _bookshelfView = bookshelfView;
    bookshelfView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:252/255.0 blue:251/255.0 alpha:1.0].CGColor;
    bookshelfView.layer.shadowColor = [UIColor colorWithRed:240/255.0 green:33/255.0 blue:0/255.0 alpha:0.24].CGColor;
    bookshelfView.layer.shadowOffset = CGSizeMake(0, -tesAuto(37));
    bookshelfView.layer.shadowOpacity = 1;
    bookshelfView.layer.shadowRadius = tesAuto(37);
    [self addSubview:bookshelfView];
    
    UIView *bookshelfBottomView = [[UIView alloc] init];
    _bookshelfBottomView = bookshelfBottomView;
    bookshelfBottomView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:239/255.0 blue:236/255.0 alpha:1.0].CGColor;
    bookshelfBottomView.layer.shadowColor = [UIColor colorWithRed:240/255.0 green:33/255.0 blue:0/255.0 alpha:0.24].CGColor;
    bookshelfBottomView.layer.shadowOffset = CGSizeMake(0,tesAuto(24));
    bookshelfBottomView.layer.shadowOpacity = 1;
    bookshelfBottomView.layer.shadowRadius = tesAuto(24);
    [self addSubview:bookshelfBottomView];

}

-(void)setupContentView{
    
    UICollectionViewFlowLayout *layOut = [[QMPLineCollectionViewFlowLayout alloc]init];
    layOut.itemSize = CGSizeMake(tesAuto(145), tesAuto(132));
    layOut.minimumLineSpacing = tesAuto(40);

    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layOut];
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:collectionView];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.top.equalTo(self).offset(tesAuto(65));
            make.height.mas_equalTo(tesAuto(180));
        }];
        
    }else{
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(tesAuto(180));
        }];
        
    }
    
    [_bookshelfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(collectionView.mas_bottom).offset(tesAuto(10));
        make.height.mas_equalTo(tesAuto(37));
        make.left.right.equalTo(self);
    }];
    
    [_bookshelfBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bookshelfView.mas_bottom).offset(0);
        make.left.right.equalTo(_bookshelfView);
        make.height.mas_equalTo(tesAuto(24));
    }];
    
    [collectionView registerClass:[QMPEnglishCourseCell class] forCellWithReuseIdentifier:@"QMPEnglishCourseCellID"];
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bookArray.count;
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"QMPEnglishCourseCellID";
    QMPBookModel *model = self.bookArray[indexPath.row];
    QMPEnglishCourseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell.covorImgView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    cell.courseNameString = model.name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    QMPBookModel *model = self.bookArray[indexPath.row];
    if(self.selectedCourseBlock){
        self.selectedCourseBlock(model);
    }
}

@end

#pragma mark - QMPEnglishCourseCell

@interface QMPEnglishCourseCell()
@property(nonatomic,strong)UIView *coverView;
@property(nonatomic,strong)UILabel *courseNameLab;
@property(nonatomic,strong)UIVisualEffectView *effectView;
@end

@implementation QMPEnglishCourseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
        [self addShadowEffect];
    }
    return self;
}

-(void)setupUI{
    UIView *coverView = [[UIView alloc] init];
    _coverView = coverView;
    [self.contentView addSubview:coverView];
    
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
    }];
    
    UIImageView *covorImgView = [[UIImageView alloc] initWithImage:[UIImage mainResourceImageNamed:@"UIImageView"]];
    _covorImgView = covorImgView;
    covorImgView.cornerRadius = tesAuto(8);
    [coverView addSubview:covorImgView];
    
    [covorImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(coverView);
    }];
    
    // 毛玻璃效果 (iOS8.0以后适用)
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _effectView = effectView;
    effectView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7].CGColor;
    effectView.cornerRadius = tesAuto(27) / 2;
    effectView.borderWidth = 1;
    effectView.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [self.contentView addSubview:effectView];
    
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(tesAuto(27));
        make.width.mas_equalTo(tesAuto(100));
    }];
    
    UILabel *courseNameLab = [UILabel tes_labelWithText:@"" fontSize:12 textColor:[UIColor AppDarkGrayColor] alignment:(NSTextAlignmentCenter)];
    _courseNameLab = courseNameLab;
    courseNameLab.font = [UIFont boldSystemFontOfSize:tRealFontSize(12)];
    [self.contentView addSubview:courseNameLab];
    
    [courseNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(tesAuto(27));
        make.width.mas_equalTo(tesAuto(100));
    }];
        
}

- (void)setCourseNameString:(NSString *)courseNameString{
    _courseNameString = courseNameString;
    _courseNameLab.text = courseNameString;
    
    CGSize labWH = [QMPCommonTools getLabContentSize:_courseNameString fontSize:tRealFontSize(12)];
    CGFloat labW;
    CGFloat effectViewW;
    if(labWH.width > (tesAuto(145) - 20)){
        labW = tesAuto(145) - 20;
        effectViewW = tesAuto(145);
    }else{
        labW = labWH.width + 10;
        effectViewW = labWH.width + 30;
    }
    
    if(labW > (tesAuto(145) - 20)) labW = tesAuto(145) - 20;
    [_courseNameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(labW);
    }];
     
    if(effectViewW > tesAuto(145)) effectViewW = tesAuto(145);
    [_effectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(effectViewW);
    }];
}

-(void)addShadowEffect{
    _coverView.backgroundColor = [UIColor AppWhiteColor];
    _coverView.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:105/255.0 blue:81/255.0 alpha:0.2].CGColor;
    _coverView.layer.shadowOffset = CGSizeMake(0,3);//偏移 0 为四周发散
    _coverView.layer.shadowOpacity = 0.1;//阴影程度
    _coverView.layer.shadowRadius = tesAuto(8.0f);
    _coverView.layer.cornerRadius = tesAuto(8);
    _coverView.layer.shadowPath = [QMPCommonTools getShadowPath:CGRectMake(0, 0, tesAuto(145), tesAuto(132) - 8)].CGPath;
}

@end
