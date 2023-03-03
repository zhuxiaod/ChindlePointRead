//
//  QMPEnglishInteractionView.h
//  QiMengProject
//
//  Created by mac on 2021/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectedCourseBlock)(QMPBookModel *bookModel);

@interface QMPEnglishInteractionView : UIView
@property(nonatomic,copy)SelectedCourseBlock selectedCourseBlock;
@property(nonatomic,strong)NSArray *bookArray;

@end

@interface QMPEnglishCourseCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *covorImgView;
@property(nonatomic,copy)NSString *courseNameString;

@end

NS_ASSUME_NONNULL_END
