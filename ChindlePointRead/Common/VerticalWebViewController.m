//
//  VerticalWebViewController.m
//  ChindlePointRead
//
//  Created by 朱𣇈丹 on 2023/5/11.
//

#import "VerticalWebViewController.h"
#import "TalkWebShareView.h"

@interface VerticalWebViewController ()

@end

@implementation VerticalWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightShareBtn];
    
    [[SwitchOrientationManager alloc] p_switchOrientationWithLaunchScreen:NO viewController:self];

}

-(void)setupRightShareBtn{
    WeakifySelf();
    UIButton *navShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navShareBtn setImage:[UIImage mainResourceImageNamed:@"course_share"] forState:UIControlStateNormal];
    navShareBtn.frame = CGRectMake(0, 0, 70, 30);
    navShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [QMPCommonTools createUIBarButtonItemWithBtn:navShareBtn];
    [navShareBtn tes_addTouchUpInsideBlock:^(UIButton * _Nonnull btn) {
        [weakSelf showShareRules];
    }];
}

-(void)showShareRules{

    TalkWebShareView *webShareView = [[TalkWebShareView alloc]initWithWebShareUrl:self.requestURL.absoluteString];
    webShareView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view.window addSubview:webShareView];
    WeakifySelf();
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if(self.landscapeBlock){
        self.landscapeBlock();
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
