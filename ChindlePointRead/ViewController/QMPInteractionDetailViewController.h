//
//  QMPInteractionDetailViewController.h
//  QiMengProject
//
//  Created by mac on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMPInteractionDetailViewController : UIViewController

-(instancetype)initWithOrientations:(BOOL)isOrientation lessonModel:(QMPLessonModel *)lessonModel isEnterMain:(BOOL)isEnterMain;

@property(nonatomic,strong) QMPLessonModel *lessonModel;

@end

NS_ASSUME_NONNULL_END
