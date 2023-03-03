//
//  QMPImageLearnModel.h
//  QiMengProject
//
//  Created by mac on 2021/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class QMPImageLearnLocationModel;

@interface QMPImageLearnModel : NSObject

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) NSArray *dataList;

@end

@interface QMPImageLearnPageModel : NSObject

@property (nonatomic, copy) NSString *imageId;
@property (nonatomic, copy) NSString *fullRead;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray *contentList;

@end

@interface QMPImageLearnLocationModel : NSObject

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end

@interface QMPImageLearnItemModel : NSObject

@property (nonatomic, copy) NSString *contentId;
@property (nonatomic, strong)QMPImageLearnLocationModel *location;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *contents;
@property (nonatomic, copy) NSString *voice;
@property (nonatomic, assign) NSInteger orderNum;
@property (nonatomic, copy) NSString *imageId;

@end




NS_ASSUME_NONNULL_END
