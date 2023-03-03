//
//  TESPlayer.h
//  QiMengProject
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TESPlayer;

@interface TESPlayer : UIView

+ (TESPlayer *)shareManager;

#pragma mark - 单次播放远程音频
- (void)playFromURLString:(NSString *)URLString;

#pragma mark - 停止播放
-(void)stopPlay;

#pragma mark - 查看播放状态
-(BOOL)isPlaying;

@end

NS_ASSUME_NONNULL_END
