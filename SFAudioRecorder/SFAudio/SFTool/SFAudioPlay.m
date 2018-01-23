//
//  SFAudioPlay.m
//  easyhospital
//
//  Created by apple on 2018/1/23.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import "SFAudioPlay.h"

@interface SFAudioPlay()<AVAudioPlayerDelegate>{
    NSString *_audioP; // 文件路径
}

@property (nonatomic, strong) AVAudioPlayer *player;

@end

static SFAudioPlay *sfaudioPlay = nil;

@implementation SFAudioPlay

+ (SFAudioPlay *)audioPlayerManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sfaudioPlay) {
            sfaudioPlay = [[SFAudioPlay alloc] init];
        }
    });
    return sfaudioPlay;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - public
- (void)sf_audioPlay:(NSString *)filePath{
    if (!filePath) {
        return;
    }
    _audioP = filePath;
    [self sf_private_audioPlay];
}

- (void)sf_audioStart{
    if ([self.player prepareToPlay]) {
        [self.player play];
    }
}

- (void)sf_audioPause{
    [self.player pause];
}

- (void)sf_audioStop{
    [self.player stop];
}
#pragma mark - private
- (void)sf_private_audioPlay{
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:_audioP] error:nil];
    self.player.delegate = self;
    [self.player play];
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    NSLog(@"音频编码失败");
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"播放完成");
    [self sf_audioStop];
    if (self.playComplete) {
        self.playComplete();
    }
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    NSLog(@"播放被中断");
}
@end
