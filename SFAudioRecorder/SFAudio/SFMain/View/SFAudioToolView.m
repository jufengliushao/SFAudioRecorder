//
//  SFAudioToolView.m
//  SFAudioRecorder
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 com.easyhospital. All rights reserved.
//

#import "SFAudioToolView.h"
#import "Masonry.h"

@interface SFAudioToolView(){
    NSInteger currnetTime;
}

@property (nonatomic, strong) NSTimer *secondTimer; // 定时器

@end

@implementation SFAudioToolView
- (instancetype)init{
    if (self = [super init]) {
        currnetTime = 0;
        [self buttonAction];
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    WS(ws);
    [self.recorderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-45);
        make.width.height.mas_equalTo(50);
        make.centerX.mas_equalTo(ws);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-30);
        make.bottom.mas_equalTo(-45);
        make.height.mas_equalTo(25);
    }];
    [super drawRect:rect];
}

#pragma mark - 按钮点击事件
- (void)buttonAction{
    WS(ws);
    [self.recorderBtn addTargetAction:^(UIButton *sender) {
        sender.selected = !sender.isSelected;
        if (sender.isSelected) {
            [ws createTimer];
        }else{
            [ws stopTimer];
        }
    }];
}

#pragma mark - 创建定时器
- (void)createTimer{
    self.secondTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)timerAction:(NSTimer *)sender{
    currnetTime += 1;
    self.timeLabel.text = [NSString stringWithFormat:@"0:%02ld/0:30", currnetTime];
}

- (void)stopTimer{
    currnetTime = 0;
    [self.secondTimer invalidate];
    self.secondTimer = nil;
}

#pragma mark - 懒加载
- (UIButton *)recorderBtn{
    if (!_recorderBtn) {
        _recorderBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_recorderBtn setTitle:@"开始" forState:(UIControlStateNormal)];
        [_recorderBtn setTitle:@"停止" forState:(UIControlStateSelected)];
        [_recorderBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal & UIControlStateSelected)];
        _recorderBtn.selected = NO;
        [self addSubview:_recorderBtn];
    }
    return _recorderBtn;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"0:00/0:30";
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
