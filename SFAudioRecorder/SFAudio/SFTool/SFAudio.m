//
//  SFAudio.m
//  SFAudioRecorder
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import "SFAudio.h"

@interface SFAudio()
@end

static SFAudio *audioFM = nil;

@implementation SFAudio

+ (SFAudio *)audioFuncManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!audioFM) {
            audioFM = [[SFAudio alloc] init];
        }
    });
    return audioFM;
}

- (instancetype)init{
    if(self = [super init]){
    
    }
    return self;
}

#pragma mark - 共有方法
#pragma mark - 私有方法z
@end
