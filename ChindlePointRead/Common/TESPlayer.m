//
//  TESPlayer.m
//  QiMengProject
//
//  Created by mac on 2021/3/18.
//

#import "TESPlayer.h"

@interface TESPlayer (){
    AVPlayer *_player;
    BOOL _isPlaying;
}

@end

@implementation TESPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isPlaying = NO;
    }
    return self;
}

+ (TESPlayer *)shareManager{
    static TESPlayer *managerInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        managerInstance = [[self alloc] init];
    });
    return managerInstance;
}

#pragma mark - 单次播放远程音频
- (void)playFromURLString:(NSString *)URLString{
    //避免重复播放
    if(_isPlaying == YES){
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    _player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:URLString]];
    [_player play];
    _isPlaying = YES;
}


#pragma mark - 当播放结束
-(void)playEnd{
    _isPlaying = NO;
    [self destroyPlayer];
}

#pragma mark - 停止播放
-(void)stopPlay{
    [_player pause];
    _isPlaying = NO;
    [self destroyPlayer];
}

#pragma mark - 销毁播放器
-(void)destroyPlayer{
    _player = nil;
}

#pragma mark - 查看播放状态
-(BOOL)isPlaying{
    return _isPlaying;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    NSLog(@"context:%@",context);
//    if (context == <#Player status context#>) {
//        AVPlayer *thePlayer = (AVPlayer *)object;
//        if ([thePlayer status] == AVPlayerStatusFailed) {
//            NSError *error = [_player error];
//            NSLog(@"_playerError:%@",error);
//            return;
//        }
//        // Deal with other status change if appropriate.
//    }
    // Deal with other change notifications if appropriate.
    [super observeValueForKeyPath:keyPath ofObject:object
                           change:change context:context];
    return;
}

//- (instancetype)initWithPlayerItem:(nullable AVPlayerItem *)item;



@end
