//
//  QMPPLessonProgressModel.h
//  ChindlePointRead
//
//  Created by 朱𣇈丹 on 2023/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMPPLessonProgressModel : NSObject

@property (nonatomic , copy) NSString              * unitId;
@property (nonatomic , copy) NSString              * lessonCover;
@property (nonatomic , copy) NSString              * nextLessonName;
@property (nonatomic , copy) NSString              * bookName;
@property (nonatomic , copy) NSString              * bookId;
@property (nonatomic , copy) NSString              * lessonName;
@property (nonatomic , copy) NSString              * learnedPercent;
@property (nonatomic , copy) NSString              * unitName;
@property (nonatomic , copy) NSString              * lessonId;
@property (nonatomic , copy) NSString              * firstLessonID;
@property (nonatomic , copy) NSString              * firstLessonName;
@property (nonatomic , copy) NSString              * nextLessonID;

@end

NS_ASSUME_NONNULL_END
