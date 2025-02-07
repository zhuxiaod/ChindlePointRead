//
//  QMPEnglishInteractionViewController.m
//  QiMengProject
//
//  Created by mac on 2021/3/10.
//

#import "QMPEnglishInteractionViewController.h"
#import "QMPEnglishInteractionView.h"
#import "QMPCourseUnitSelectViewController.h"

@interface QMPEnglishInteractionViewController ()
@property(nonatomic,strong) QMPEnglishInteractionView *englishInteractionView;
@end

@implementation QMPEnglishInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_interactivePopDisabled = YES;
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setupInterfaceOrientations];

}

-(void)setupBackBtn{
    
    UIButton *backBtn = [UIButton creatButtonWithBGImg:[UIImage mainResourceImageNamed:@"home_backBtn"]];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(tesAuto(16) + 10);
        make.height.width.mas_equalTo(tesAuto(32));
    }];
    
    [backBtn addTarget:self
                action:@selector(goBack)
      forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [[SwitchOrientationManager alloc] p_switchOrientationWithLaunchScreen:NO viewController:self];

}

#pragma mark - 设置EnglishInteractionView
-(void)setupEnglishInteractionView{
    
    QMPEnglishInteractionView *englishInteractionView = [[QMPEnglishInteractionView alloc] init];
    _englishInteractionView = englishInteractionView;
    [self.view addSubview:englishInteractionView];
    
    [englishInteractionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenWidth);
        make.width.mas_equalTo(kScreenHeight);
        make.left.top.equalTo(self.view);
    }];
    
    WeakifySelf();
    englishInteractionView.selectedCourseBlock = ^(QMPBookModel * _Nonnull bookModel) {
        [weakSelf pushCourseUnitSelectViewController:bookModel];
    };
}

-(void)pushCourseUnitSelectViewController:(QMPBookModel *)bookModel{
    if(bookModel == nil)return;
    
    QMPCourseUnitSelectViewController *vc = [[QMPCourseUnitSelectViewController alloc] init];
    vc.bookModel = bookModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置横屏
-(void)setupInterfaceOrientations{

    [[SwitchOrientationManager alloc] p_switchOrientationWithLaunchScreen:true viewController:self];
    
}

-(void)getBookListData{
    WeakifySelf();
    [QMPRequestManager getBookListRequest:^(NSArray * _Nonnull bookList) {
        weakSelf.englishInteractionView.bookArray = bookList;
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
        
        [self setupEnglishInteractionView];
        
        [self setupBackBtn];
        
        [self getBookListData];
    }
}

@end
