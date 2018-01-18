//
//  ViewController.m
//  SFAudioRecorder
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import "ViewController.h"
#import "SFAudioManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SFAudioManager audioManager] sf_getAudioRight];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
