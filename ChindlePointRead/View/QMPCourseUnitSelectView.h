//
//  QMPCourseUnitSelectView.h
//  QiMengProject
//
//  Created by mac on 2021/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@class QMPLessonModel;
//@class QMPUnitModel;
//@class QMPLessonModel;


typedef void(^SelectedLessonItemBlock)(QMPLessonModel *lessonModel);
typedef void(^LoadLessonListBlock)(QMPUnitModel *unitModel);

@interface QMPCourseUnitSelectView : UIView
@property(nonatomic,copy)SelectedLessonItemBlock selectedLessonItemBlock;
@property(nonatomic,strong)NSArray *unitModelList;
@property(nonatomic,strong)NSArray *lessonModelList;
@property(nonatomic,strong)NSString *bookName;

@property(nonatomic,copy)LoadLessonListBlock loadLessonListBlock;
@end

@interface QMPUnitCoverView : UIView
@property(nonatomic,strong)QMPLessonModel *lessonModel;
@property(nonatomic,strong)UILabel *unitTitleLab;
@end

NS_ASSUME_NONNULL_END
