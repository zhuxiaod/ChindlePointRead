//
//  QMPCourseUnitSelectViewController.m
//  QiMengProject
//
//  Created by mac on 2021/3/11.
//

#import "QMPCourseUnitSelectViewController.h"
#import "QMPCourseUnitSelectView.h"
#import "QMPInteractionDetailViewController.h"

@interface QMPCourseUnitSelectViewController ()
@property(nonatomic,strong)QMPCourseUnitSelectView *courseUnitSelectView;

@property(nonatomic,assign)BOOL isOrientation;

@end

@implementation QMPCourseUnitSelectViewController

-(instancetype)initWithOrientations:(BOOL)isOrientation{
    
    QMPCourseUnitSelectViewController *vc = [[QMPCourseUnitSelectViewController alloc] init];
    
    vc.isOrientation = isOrientation;
    
    return vc;
}

- (QMPCourseUnitSelectView *)courseUnitSelectView{
    if(_courseUnitSelectView == nil){
        _courseUnitSelectView = [[QMPCourseUnitSelectView alloc] init];
    }
    return _courseUnitSelectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_interactivePopDisabled = YES;
    
    self.fd_prefersNavigationBarHidden = YES;
    
    if(self.isOrientation == YES) {

        [self setupInterfaceOrientations];
        
    }else{
        
        [self setupCourseUnitSelectView];
        
        [self setupBackBtn];
        
    }
    
}

#pragma mark - 设置横屏
-(void)setupInterfaceOrientations{

    [[SwitchOrientationManager shareManager] p_switchOrientationWithLaunchScreen:true viewController:self];
    
}

- (void)setBookModel:(QMPBookModel *)bookModel{
    _bookModel = bookModel;
    
    WeakifySelf();
    [QMPRequestManager getUnitListRequest:bookModel.bookId success:^(NSArray * _Nonnull unitList) {
        weakSelf.courseUnitSelectView.unitModelList = unitList;
        weakSelf.courseUnitSelectView.bookName = bookModel.name;
        
        //请求第一个
        if(unitList != 0){
            [weakSelf loadLessonListData:unitList[0]];
        }
    }];
    
}

-(void)setupCourseUnitSelectView{


    [self.view addSubview:self.courseUnitSelectView];
    
    [self.courseUnitSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenWidth);
        make.width.mas_equalTo(kScreenHeight);
        make.left.top.equalTo(self.view);
    }];
    
    WeakifySelf();
    self.courseUnitSelectView.selectedLessonItemBlock = ^(QMPLessonModel * _Nonnull lessonModel) {
        [weakSelf jumpToInteractionDetailViewController:lessonModel];
    };
    
    self.courseUnitSelectView.loadLessonListBlock = ^(QMPUnitModel * _Nonnull unitModel) {
        [weakSelf loadLessonListData:unitModel];
    };
    
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
    
    
    if(self.isOrientation == YES){
        
        [[SwitchOrientationManager shareManager] p_switchOrientationWithLaunchScreen:NO viewController:self];
    }
}


#pragma mark - 跳转详情页面
-(void)jumpToInteractionDetailViewController:(QMPLessonModel *)lessonModel{
    if(lessonModel == nil)return;
    
    QMPInteractionDetailViewController *vc = [[QMPInteractionDetailViewController alloc] initWithOrientations:NO lessonModel:lessonModel isEnterMain:NO];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 请求课程数据
-(void)loadLessonListData:(QMPUnitModel *)unitModel{
    
    WeakifySelf();
    [QMPRequestManager getLessonListRequest:unitModel.unitId success:^(NSArray * _Nonnull unitList) {
        
        //设置课程
        if(unitList.count > 4){
            weakSelf.courseUnitSelectView.lessonModelList = [unitList subarrayWithRange:NSMakeRange(0, 4)];
            return;
        }
        
        weakSelf.courseUnitSelectView.lessonModelList = unitList;
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    BOOL isLaunchScreen = NO;
    NSLog(@"view 发生改变:%@", NSStringFromCGSize(size));
    
    if (@available(iOS 16.0, *)) {
        NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
        UIWindowScene *scene = [array firstObject];
        isLaunchScreen = scene.interfaceOrientation == UIInterfaceOrientationLandscapeRight;
    } else {
        isLaunchScreen = [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft;
    }
    NSLog(@"将要%@", isLaunchScreen ? @"横屏" : @"竖屏");
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginChange:) object:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"isLaunchScreen"] = @(isLaunchScreen);
    [self performSelector:@selector(beginChange:) withObject:param afterDelay:0.25];
}

- (void)beginChange:(NSDictionary *)param {
    BOOL isLaunchScreen = [[param objectForKey:@"isLaunchScreen"] boolValue];
    
    if(isLaunchScreen != YES){
        
        
        
    }else{
        NSLog(@"横屏");
        
        [self setupCourseUnitSelectView];
        
        [self setupBackBtn];
        
//        [self.view layoutIfNeeded];
    }
}


@end
