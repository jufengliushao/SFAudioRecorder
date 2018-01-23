//
//  SFAudioPlay.h
//  easyhospital
//
//  Created by apple on 2018/1/23.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^PlayCompleteBlock)();

@interface SFAudioPlay : NSObject

+ (SFAudioPlay *)audioPlayerManager;

@property (nonatomic, copy)  PlayCompleteBlock playComplete;

- (void)sf_audioPlay:(NSString *)filePath; // 播放本地文件，调用此方法无需调用 start
- (void)sf_audioStart; // 开始播放
- (void)sf_audioPause; // 暂停
- (void)sf_audioStop; // 停止

@end
