//
//  SFAudio.h
//  SFAudioRecorder
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFAudio : NSObject

@property (nonatomic, copy, readonly) NSString *audioPath; // 未编码的音频
@property (nonatomic, copy, readonly) NSString *audioDecPath; // 编码完成后的音频

+ (SFAudio *)audioFuncManager;
- (void)sf_startRecord; // 开始录音
- (void)sf_stopRecord; // 停止录音
- (void)sf_endocAudio:(void(^)(void))complete; // 进行编码
- (void)sf_deleteAudio; // 删除录音
@end
