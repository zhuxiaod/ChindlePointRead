//
//  QMPCourseUnitSelectViewController.h
//  QiMengProject
//
//  Created by mac on 2021/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMPCourseUnitSelectViewController : UIViewController

-(instancetype)initWithOrientations:(BOOL)isOrientation;

@property(nonatomic,strong)QMPBookModel *bookModel;
@end

NS_ASSUME_NONNULL_END
