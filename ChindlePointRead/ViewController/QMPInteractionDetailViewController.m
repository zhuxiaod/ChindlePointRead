//
//  QMPInteractionDetailViewController.m
//  QiMengProject
//
//  Created by mac on 2021/3/16.
//

#import "QMPInteractionDetailViewController.h"
#import "QMPInteractionDetailView.h"
#import "QMPImageLearnDeskView.h"
#import "QMPImageLearnEndView.h"

@interface QMPInteractionDetailViewController ()
@property(nonatomic,strong)QMPInteractionDetailView *interactionDetailView;
@property(nonatomic,strong)QMPImageLearnDeskView *imageLearnDeskView;
@property(nonatomic,strong)QMPImageLearnEndView *imageLearnEndView;
@property(nonatomic,assign)NSInteger totalCount;//页数
@property(nonatomic,assign)NSInteger currentPageNum;//当前数
@property(nonatomic,assign)NSInteger currentPageIndex;//当前索引
@property(nonatomic,assign)NSInteger preloadImageIndex;//预加载索引
@property(nonatomic,assign)BOOL isLoadDone;//是否加载完成

@property(nonatomic,strong)QMPImageLearnModel *imageLearnModel;//点读模型 一本书
@property(nonatomic,strong)QMPImageLearnPageModel *imageLearnPageModel;//点读模型 一页

@property(nonatomic,strong)NSMutableArray *imageLearnPageArray;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger timerSecond;

@end

@implementation QMPInteractionDetailViewController

- (NSMutableArray *)imageLearnPageArray{
    if(_imageLearnPageArray == nil){
        _imageLearnPageArray = [NSMutableArray array];
    }
    return _imageLearnPageArray;
}

- (QMPInteractionDetailView *)interactionDetailView{
    if(_interactionDetailView == nil){
        _interactionDetailView = [[QMPInteractionDetailView alloc] init];
    }
    return _interactionDetailView;
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.totalCount = 0;

    self.fd_interactivePopDisabled = YES;
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setupUI];
    
    [self setupLearningDesk];

    [self setupBackBtn];

    [self setupTimer];

}

-(void)setupBackBtn{
    UIButton *backBtn = [UIButton creatButtonWithBGImg:[UIImage mainResourceImageNamed:@"home_backBtn"]];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(tesAuto(16) + 10);
        make.height.width.mas_equalTo(tesAuto(32));
    }];
    
    WeakifySelf();
    [backBtn addTarget:self
                action:@selector(goBack)
      forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)setupUI{
    
    //标题  按钮
    [self.view addSubview:self.interactionDetailView];
    
    [self.interactionDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    WeakifySelf();
    
    //查看点读模块
    self.interactionDetailView.clickCheckButtonBlock = ^(BOOL isSelected) {
        isSelected?[weakSelf.imageLearnDeskView hiddenPageItems]:[weakSelf.imageLearnDeskView showPageItems];
    };
        
    //播放声音
    self.interactionDetailView.clickSoundButtonBlock = ^{
        if([[TESPlayer shareManager] isPlaying] == YES)return;
        [[TESPlayer shareManager] playFromURLString:weakSelf.imageLearnPageModel.fullRead];
    };
    
    //下一页
    self.interactionDetailView.clickLastPageButtonBlock = ^{
        [weakSelf checkLastPageContent];
    };
    
    //上一页
    self.interactionDetailView.clickNextPageButtonBlock = ^{
        [weakSelf checkNextPageContent];
    };
    
}

#pragma mark - 下一页逻辑
-(void)checkNextPageContent{
        
    //学习时间
    [self postImageLearnTimeRequest];
    
    //停止播放
    [[TESPlayer shareManager] stopPlay];
    
    //弹出结束框
    if(self.totalCount != 0) {//说明获取到正确的页数了
        
        if(self.currentPageNum == self.imageLearnPageArray.count && self.imageLearnPageArray.count != self.totalCount){//说明没有数据
            
            NSLog(@"说明没有数据");
            return;
        }

        
        if(self.currentPageNum == self.totalCount){//最后一页
            
            NSLog(@"最后一页了");
            [self showLearnEndView];
            return;
            
        }
        
    }
    
    //防止越界
    if(self.currentPageNum >= self.imageLearnPageArray.count)return;
    
    //页码变化
    self.currentPageNum = self.currentPageNum + 1;
}

#pragma mark - 上一页
-(void)checkLastPageContent{
    //学习时间
    [self postImageLearnTimeRequest];
    
    //停止播放
    [[TESPlayer shareManager] stopPlay];

    //防止越界
    if(self.currentPageNum == 1)return;
    
    //页码变化
    self.currentPageNum = self.currentPageNum - 1;
}

#pragma mark - 显示完成弹窗
-(void)showLearnEndView{
    [_imageLearnEndView removeFromSuperview];
    
    QMPImageLearnEndView *imageLearnEndView = [[QMPImageLearnEndView alloc] init];
    _imageLearnEndView = imageLearnEndView;
    [self.view addSubview:imageLearnEndView];
    
    [imageLearnEndView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    WeakifySelf();
    imageLearnEndView.goBackLastVC = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //学习结束
    [self postImageLearnEndRequest];
}

#pragma mark - 桌面
-(void)setupLearningDesk{
    QMPImageLearnDeskView *imageLearnDeskView = [[QMPImageLearnDeskView alloc] init];
    _imageLearnDeskView = imageLearnDeskView;
    [self.view addSubview:imageLearnDeskView];
    
    [imageLearnDeskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.interactionDetailView.contentView).offset(tesAuto(5));
        make.right.bottom.equalTo(self.interactionDetailView.contentView).offset(-tesAuto(5));
    }];
    
    WeakifySelf();
    //播放点读块
    self.imageLearnDeskView.playImageLearnItemVoiceBlock = ^(QMPImageLearnItemModel * _Nonnull itemModel) {
        [[TESPlayer shareManager] playFromURLString:itemModel.voice];
    };
}

#pragma mark - 接口
-(void)loadDataListRequest{
    
    NSDictionary *dict = @{
        @"currPage":@(_preloadImageIndex),
        @"lessonId":_lessonModel.lessonId,
        @"pageSize":@"7"
    };
    
    //需要根据加载索引来加载，而不是当前页面 分开
    WeakifySelf();
    [QMPRequestManager getImageLearnRequest:dict success:^(QMPImageLearnModel * _Nonnull imageLearnModel) {
        weakSelf.totalCount = imageLearnModel.totalCount;//记录
        weakSelf.imageLearnModel = imageLearnModel;
        [weakSelf.imageLearnPageArray addObjectsFromArray:imageLearnModel.dataList];
        weakSelf.currentPageNum = weakSelf.currentPageNum;
        weakSelf.preloadImageIndex = weakSelf.preloadImageIndex + 1;
        //下载图片
        [weakSelf downLoadImageWithUrlArray:imageLearnModel.dataList];
        //如果返回数组为0 说明加载完
        if(imageLearnModel.dataList.count == 0){
            NSLog(@"数据加载完成了");
            self.isLoadDone = YES;
        }
    }];
}

#pragma mark - 开始学习
-(void)postImageLearnStartRequest{
    [QMPRequestManager loadImageLearnStartRequest:_lessonModel.lessonId];
}

#pragma mark - 结束学习
-(void)postImageLearnEndRequest{
    [QMPRequestManager postImageLearnDoneRequest:_lessonModel.lessonId];
}

#pragma mark - 记录学习时长
-(void)postImageLearnTimeRequest{
    
    [QMPRequestManager postImageLearnTimeRequest:_lessonModel.lessonId second:self.timerSecond];
    
    self.timerSecond = 0;
    
    NSLog(@"记录了学习时间");
}

#pragma mark - 下载图片
-(void)downLoadImageWithUrlArray:(NSArray *)urlArray{
    
    for (QMPImageLearnPageModel *urlModel in urlArray) {
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:urlModel.url] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//            NSLog(@"下载完成");
        }];
    }
}

#pragma mark - setter
- (void)setImageLearnModel:(QMPImageLearnModel *)imageLearnModel{
    _imageLearnModel = imageLearnModel;
}

- (void)setLessonModel:(QMPLessonModel *)lessonModel{
    _lessonModel = lessonModel;
    
    //设置名字
    self.interactionDetailView.lessonNameString = lessonModel.name;
    //初始化
    self.currentPageNum = 1;
    
    self.preloadImageIndex = 1;
    
    self.isLoadDone = NO;
    
    self.timerSecond = 0;
    
    //请求内容
    [self loadDataListRequest];
    
    //开始学习
    [self postImageLearnStartRequest];
}

- (void)setTotalCount:(NSInteger)totalCount{
    _totalCount = totalCount;
    self.interactionDetailView.totalCountString = [NSString stringWithFormat:@"%ld",(long)totalCount];
}

- (void)setCurrentPageNum:(NSInteger)currentPageNum{
    _currentPageNum = currentPageNum;
    
    //判断是否越界
    if((_currentPageNum - 1) >= self.imageLearnPageArray.count) return;
    
    self.interactionDetailView.currentPageNumString = [NSString stringWithFormat:@"%ld",(long)currentPageNum];
    
    //如果当前页数是一 那么索引就是页数-1
    self.currentPageIndex = currentPageNum - 1;
    self.imageLearnPageModel = self.imageLearnPageArray[self.currentPageIndex];
    
    //如果当前页码为1 上一页按钮禁止点击
    _currentPageNum == 1?[self.interactionDetailView lastPageButtonBanClick]:[self.interactionDetailView lastPageButtonClickAvailable];
    
//    _currentPageNum == _totalCount?[self.interactionDetailView nextPageButtonBanClick]:[self.interactionDetailView nextPageButtonClickAvailable];
    
    //图片预加载
    [self preloadImageData];
}

#pragma mark - 图片预加载
-(void)preloadImageData{
    
    if(self.totalCount == self.imageLearnPageArray.count && self.totalCount != 0){//已经加载完成

        NSLog(@"已经加载完 加载停止");

        return;
    }
    //触发预加载 加载完以后 就不加载了
    if(_currentPageNum >= self.imageLearnPageArray.count - 3 && self.isLoadDone == NO){
        NSLog(@"加载图片了 %d",self.imageLearnPageArray.count);
        [self loadDataListRequest];
    }
}

//设置当前页UI
- (void)setImageLearnPageModel:(QMPImageLearnPageModel *)imageLearnPageModel{
    _imageLearnPageModel = imageLearnPageModel;

    //设置点读模块
    _imageLearnDeskView.imageLearnPageItemArray = imageLearnPageModel.contentList;
    
    //设置学习图片
    _imageLearnDeskView.backgroundImgUrl = imageLearnPageModel.url;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[TESPlayer shareManager] stopPlay];
    
    [_timer invalidate];
    _timer = nil;
    
    //学习时间
    [self postImageLearnTimeRequest];
}

-(void)setupTimer{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(void)timerAction{
    self.timerSecond = self.timerSecond + 1;
//    NSLog(@"self.timerSecond:%ld",self.timerSecond);
}


@end
