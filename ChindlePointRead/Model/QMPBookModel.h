//
//  QMPBookModel.h
//  QiMengProject
//
//  Created by mac on 2021/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//书
@interface QMPBookModel : NSObject
@property(nonatomic,copy) NSString *bookId;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *cover;

@end

//单元
@interface QMPUnitModel : NSObject
@property (nonatomic, copy) NSString *bookId;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *unitId;
@end

//课程
@interface QMPLessonModel :NSObject
@property (nonatomic , copy) NSString              * orderNum;
@property (nonatomic , copy) NSString              * unitId;
@property (nonatomic , copy) NSString              * updateTime;
@property (nonatomic , copy) NSString              * updateBy;
@property (nonatomic , copy) NSString              * bookCover;
@property (nonatomic , copy) NSString              * bookName;
@property (nonatomic , copy) NSString              * bookId;
@property (nonatomic , copy) NSString              * deleted;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * cover;
@property (nonatomic , copy) NSString              * lessonId;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * createBy;

@end

NS_ASSUME_NONNULL_END
