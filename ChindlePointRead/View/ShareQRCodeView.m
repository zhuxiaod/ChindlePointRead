//
//  ShareQRCodeView.m
//  ChindlePointRead
//
//  Created by 朱𣇈丹 on 2023/5/9.
//

#import "ShareQRCodeView.h"

@implementation ShareQRCodeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CGFloat viewHeight = kScreenWidth - tesAuto(120) - tesAuto(40);
        CGFloat viewWidth = 375 * viewHeight / 510;
        
        UIImageView *bannerView = [[UIImageView alloc] init];
        [self addSubview:bannerView];
        
        [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ShareCourse" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        bannerView.image = image;
        
        //封面
        UIImageView *coverView = [[UIImageView alloc] init];
        _coverView = coverView;
        coverView.backgroundColor = [UIColor AppLabBlackColor];
        [bannerView addSubview:coverView];
        
        coverView.cornerRadius = 8 * viewWidth / 375;

        CGFloat coverViewTop = 90.5 * viewWidth / 375;
        CGFloat coverViewleft = 26 * viewWidth / 375;
        CGFloat coverViewW = 323 * viewWidth / 375;
        CGFloat coverViewH = 179 * viewWidth / 375;

        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bannerView).offset(coverViewTop);
            make.left.equalTo(bannerView).offset(coverViewleft);
            make.height.mas_equalTo(coverViewH);
            make.width.mas_equalTo(coverViewW);
        }];
        
        //课程名字
        CGFloat fontSize = tRealFontSize(16) * viewWidth / 375;

        UILabel *courseNameLab = [[UILabel alloc] init];
        _courseNameLab = courseNameLab;
        courseNameLab.numberOfLines = 2;
        courseNameLab.font = [UIFont boldSystemFontOfSize:fontSize];
        courseNameLab.textColor = [UIColor AppLabBlackColor];
        [bannerView addSubview:courseNameLab];
        
        CGFloat courseNameLabTop = 37 * viewWidth / 375;
        CGFloat courseNameLabLeft = 32.5 * viewWidth / 375;
        CGFloat courseNameLabHeight = 41 * viewWidth / 375;
        
        [courseNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverView.mas_bottom).offset(courseNameLabTop);
            make.left.equalTo(bannerView).offset(courseNameLabLeft);
            make.right.equalTo(bannerView).offset(-courseNameLabLeft);
            make.height.mas_equalTo(courseNameLabHeight);
        }];

        CGFloat codeViewRight = 35 * viewWidth / 375;
        CGFloat codeViewBottom = 40 * viewWidth / 375;
        CGFloat codeViewWH = 65 * viewWidth / 375;

        UIImageView *codeView = [[UIImageView alloc] init];

#ifdef DEBUGFORMAL || APPSTORE

        codeView.image = [UIImage mainResourceImageNamed:@"xianwShareUrl"];

#else

        codeView.image = [UIImage mainResourceImageNamed:@"testShareUrl"];

#endif

        [self addSubview:codeView];
        
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bannerView).offset(-codeViewRight);
            make.bottom.equalTo(bannerView).offset(-codeViewBottom);
            make.height.width.mas_equalTo(codeViewWH);
        }];
    }
    return self;
}

// 3. 实现截图方法
- (UIImage *)snapshot {
    CGFloat scale = 2.0;
    CGSize size = self.bounds.size;
    
    //计算一个倍数
    CGFloat percent = 750 / size.width;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width * percent, size.height * percent), self.opaque, scale);
    [self drawViewHierarchyInRect:CGRectMake(0, 0, size.width * percent, size.height * percent) afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

-(void)setCourseName:(NSString *)courseName{
    _courseNameLab.text = courseName;
    
    [_courseNameLab sizeToFit];
}
@end
