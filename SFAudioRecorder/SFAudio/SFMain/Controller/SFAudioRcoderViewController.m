//
//  SFAudioRcoderViewController.m
//  SFAudioRecorder
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import "SFAudioRcoderViewController.h"
#import "SFAudioToolView.h"
#import "Masonry.h"
@interface SFAudioRcoderViewController ()

@property (nonatomic, strong) SFAudioToolView *toolView;

@end

@implementation SFAudioRcoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.toolView.bounds = self.view.bounds;
    self.view = self.toolView;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
- (SFAudioToolView *)toolView{
    if (!_toolView) {
        _toolView = [[SFAudioToolView alloc] init];
    }
    return _toolView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
