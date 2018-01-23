//
//  SFAudio.m
//  SFAudioRecorder
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import "SFAudio.h"
#import <AVFoundation/AVFoundation.h>
#import "SFFileManager.h"
#import "lame.h"
static NSString *fileName = @"a.caf";
static NSString *fileDeName = @"a.mp3";

@interface SFAudio(){
    NSString *filePath;
    NSString *fileDePath;
    NSMutableDictionary *recordSettings;
}

@property (nonatomic, strong) AVAudioRecorder *audioR;

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
        filePath = [[[SFFileManager shareInstance] sf_getDocumentsPath] stringByAppendingPathComponent:fileName];
        fileDePath = [[[SFFileManager shareInstance] sf_getDocumentsPath] stringByAppendingPathComponent:fileDeName];
        [self sf_private_prepare];
    }
    return self;
}

#pragma mark - 共有方法
- (void)sf_startRecord{
    [self.audioR prepareToRecord];
    [self.audioR record];
}

- (void)sf_stopRecord{
    [self.audioR stop];
}

- (void)sf_endocAudio:(void (^)(void))complete{
    [self sf_private_audioDeco:complete];
}

- (void)sf_deleteAudio{
    [[SFFileManager shareInstance] sf_deleteFileWithPath:filePath];
    [[SFFileManager shareInstance] sf_deleteFileWithPath:fileDePath];
}

- (NSString *)audioPath{
    return filePath;
}

- (NSString *)audioDecPath{
    return fileDePath;
}
#pragma mark - 私有方法
- (void)sf_private_prepare{
    [self sf_private_setData];
    [self sf_private_createRecorder];
}

- (void)sf_private_createRecorder{
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    self.audioR = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:filePath] settings:recordSettings error:&error];
    self.audioR.meteringEnabled = YES;
}

- (void)sf_private_setData{
    // 0.2 创建录音设置
    recordSettings = [[NSMutableDictionary alloc] initWithCapacity:0];
    // 设置编码格式
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    // 采样率
    [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];
    // 通道数
    [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //音频质量,采样质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    [recordSettings setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
}

- (void)sf_private_audioDeco:(void(^)(void))complete{
    @try {
        int read, write;
        
        FILE *pcm = fopen([filePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([fileDePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
        if (complete) {
            complete();
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        
    }
}
@end
