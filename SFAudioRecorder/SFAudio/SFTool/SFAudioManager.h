//
//  SFAudioManager.h
//  SFAudioRecorder
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFAudioManager : NSObject

+ (SFAudioManager *)audioManager;

/**
 * 获取手机麦克风权限
 */
- (void)sf_getAudioRight;

@end
