//
//  QMPImageLearnDeskView.m
//  QiMengProject
//
//  Created by mac on 2021/3/18.
//

#import "QMPImageLearnDeskView.h"

@interface QMPImageLearnDeskView ()
@property(nonatomic,strong)UIImageView *imgBgView;
@property(nonatomic,strong)NSMutableArray *pageItemArray;

@property(nonatomic,strong)UIView *contentView;

@end

@implementation QMPImageLearnDeskView

- (CGFloat)bookViewOldH{
    
    return tesAuto(300);
}

- (CGFloat)bookViewOldW{
    
    return tesAuto(540);
}

- (CGFloat)bookViewH{
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        return kScreenWidth - tesAuto(78);
    }
    return tesAuto(300);
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

- (NSMutableArray *)pageItemArray{
    if(_pageItemArray == nil){
        _pageItemArray = [NSMutableArray array];
    }
    return _pageItemArray;
}

- (UIView *)contentView{
    if (_contentView == nil){
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupImageBgView];
    }
    return self;
}

-(void)setupImageBgView{
    UIImageView *imgBgView = [[UIImageView alloc] init];
    imgBgView.cornerRadius = tesAuto(10);
    _imgBgView = imgBgView;
    [self addSubview:imgBgView];
    
    [imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setBackgroundImgUrl:(NSString *)backgroundImgUrl{
    _backgroundImgUrl = backgroundImgUrl;
    
    WeakifySelf();
    [_imgBgView sd_setImageWithURL:[NSURL URLWithString:backgroundImgUrl] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        if(image){
            //清空items
            [weakSelf cleanItems];

            [weakSelf creatImageLearnPageItems:weakSelf.imageLearnPageItemArray imgSize:image.size];
        }
    }];
}

- (void)setImageLearnPageItemArray:(NSArray *)imageLearnPageItemArray{
    _imageLearnPageItemArray = imageLearnPageItemArray;
}

#pragma mark - 生成点图模块
-(void)creatImageLearnPageItems:(NSArray *)imageLearnPageItemArray imgSize:(CGSize)imgSize{
 
    //计算倍数
    CGFloat proportionW = [self bookViewW] / imgSize.width;
    CGFloat proportionH = [self bookViewH] / imgSize.height;

//    NSLog(@"bookViewW:%f",[self bookViewW]);
    NSInteger buttonTag = 100;
    for (QMPImageLearnItemModel *itemModel in imageLearnPageItemArray) {
        //创建点读模块
        UIButton *pageItem = [UIButton buttonWithType:UIButtonTypeCustom];
        pageItem.tag = buttonTag;
        pageItem.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [self.contentView addSubview:pageItem];
        
        //添加到数组
        [self.pageItemArray addObject:pageItem];
        
        [pageItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(itemModel.location.top * proportionH);
            make.left.equalTo(self.contentView).offset(itemModel.location.left * proportionW);
            make.width.mas_equalTo(itemModel.location.width * proportionW);
            make.height.mas_equalTo(itemModel.location.height * proportionH);
        }];
        
        WeakifySelf();
        [pageItem tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
            [weakSelf clickImageLearnPageItem:btn];
        }];
        
        buttonTag = buttonTag + 1;
    }
}

-(void)clickImageLearnPageItem:(UIButton *)item{
    QMPImageLearnItemModel *itemModel = _imageLearnPageItemArray[item.tag - 100];
    if(self.playImageLearnItemVoiceBlock){
        self.playImageLearnItemVoiceBlock(itemModel);
    }
}

#pragma mark - 隐藏点图模块
-(void)hiddenPageItems{
    
    self.contentView.hidden = YES;

}

#pragma mark - 显示点图模块
-(void)showPageItems{
    
    self.contentView.hidden = NO;
}

#pragma mark - 清空items
-(void)cleanItems{
    
    [self.contentView removeAllSubviews];
    
    [self.pageItemArray removeAllObjects];
    
    self.pageItemArray = nil;
}

@end
