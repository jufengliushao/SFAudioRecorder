//
//  SFAudioManager.m
//  SFAudioRecorder
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import "SFAudioManager.h"
#import <AVFoundation/AVFoundation.h>
#import "LGAlertView.h"
@interface SFAudioManager()<LGAlertViewDelegate>
@end

static SFAudioManager *audioManager = nil;

@implementation SFAudioManager
+ (SFAudioManager *)audioManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!audioManager) {
            audioManager = [[SFAudioManager alloc] init];
        }
    });
    return audioManager;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - 共有方法
- (void)sf_getAudioRight{
    [self sf_private_CamerRight:[self sf_private_getAudioStatus]];
}

#pragma mark - 私有方法
- (AVAuthorizationStatus)sf_private_getAudioStatus{
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
}

//麦克风权限
- (void)sf_private_getAudioRight{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if (granted) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
}
#pragma mark - 权限事件处理
- (void)sf_private_CamerRight:(AVAuthorizationStatus)camerS{
    switch (camerS) {
        case AVAuthorizationStatusNotDetermined:{
            // 未询问用户
            [self sf_private_getAudioRight];
        }
            break;
            
        case AVAuthorizationStatusRestricted:{
            // 设备有问题，请叫家长
            LGAlertView *alter = [[LGAlertView alloc] initWithTitle:@"提示" message:@"请找家长" style:(LGAlertViewStyleAlert) buttonTitles:nil cancelButtonTitle:@"确认" destructiveButtonTitle:nil delegate:self];
            alter.tag = SF_ALTER_TAG_CAMER_Restricted;
            [alter showAnimated:YES completionHandler:nil];
        }
            break;
            
        case AVAuthorizationStatusDenied:{
            // 用户拒绝
            LGAlertView *alter = [[LGAlertView alloc] initWithTitle:@"提示" message:@"请到设置进行授权" style:(LGAlertViewStyleAlert) buttonTitles:@[@"前往"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil delegate:self];
            alter.tag = SF_ALTER_TAG_CAMER_DEFINE;
            [alter showAnimated:YES completionHandler:nil];
        }
            break;
            
        case AVAuthorizationStatusAuthorized:{
            // 用户已授权
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 方法跳转
- (void)sf_private_skipSetting{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([UIDevice currentDevice].systemVersion.doubleValue > 10.0) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark - 方法跳转
- (void)alertView:(LGAlertView *)alertView clickedButtonAtIndex:(NSUInteger)index title:(nullable NSString *)title {
    switch (alertView.tag) {
        case SF_ALTER_TAG_CAMER_DEFINE:{
            // 跳转到应用权限设置中心
            [self sf_private_skipSetting];
        }
            break;
            
        default:
            break;
    }
}

- (void)alertViewCancelled:(LGAlertView *)alertView {
    
}

- (void)alertViewDestructed:(LGAlertView *)alertView {
    
}
@end
