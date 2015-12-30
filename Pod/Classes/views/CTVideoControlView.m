//
//  CTVideoControlView.m
//  Pods
//
//  Created by 黄成 on 15/12/28.
//
//

#import "CTVideoControlView.h"
#import "CTVideoUtil.h"

@interface CTVideoControlView ()

@property (nonatomic,assign) CGFloat maxTime;
@property (nonatomic,assign) CGFloat nowTime;
@property (nonatomic,strong) UIButton *playBtn;
@property (nonatomic,strong) UILabel *nowTimeLabel;
@property (nonatomic,strong) UILabel *maxTimeLabel;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation CTVideoControlView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.playBtn];
        [self addSubview:self.nowTimeLabel];
        [self addSubview:self.maxTimeLabel];
        [self addSubview:self.slider];
        [self.slider addSubview:self.progressView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.playBtn.frame = CGRectMake(16, (self.bounds.size.height - 44 )/2, 44 , 44);
    
    self.nowTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.playBtn.frame) + 8, (self.bounds.size.height - 21 )/2, 40, 21);
    
    self.slider.frame = CGRectMake(CGRectGetMaxX(self.nowTimeLabel.frame) + 8, (self.bounds.size.height - 31 )/2, self.bounds.size.width - CGRectGetMaxX(self.nowTimeLabel.frame) - 8*2 - 16 - 40, 31);
    
    self.maxTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.slider.frame) + 8, (self.bounds.size.height - 21 )/2, 40, 21);
    
    self.progressView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.slider.frame)-4, 3);
    self.progressView.center = CGPointMake(CGRectGetWidth(self.slider.bounds)/2.f, CGRectGetHeight(self.slider.bounds)/2.f);
}

- (void)packageNowTime:(CGFloat)nowTime maxTime:(CGFloat)maxTime available:(CGFloat)availableTime{
    self.maxTime = maxTime;
    self.nowTime = nowTime;
    self.nowTimeLabel.text = [CTVideoUtil timeStrWithSecond:nowTime];
    self.maxTimeLabel.text = [CTVideoUtil timeStrWithSecond:maxTime];
    
    CGFloat available = availableTime / maxTime ;
    CGFloat now = nowTime / maxTime;
    
    [self.slider sendSubviewToBack:self.progressView];
    self.progressView.progress = available;
    self.slider.value = now;
    
}
- (void)sliderValueChanged:(UISlider *)sender {
    // 滑条滑动
    if ([self.delegate respondsToSelector:@selector(seekTimeToValue:)]) {
        [self.delegate seekTimeToValue:sender.value*self.maxTime ];
    }
}

- (void)sliderTouchUpInside:(UISlider *)sender {
    if ([self.delegate respondsToSelector:@selector(seekTimeTouchEnd)]) {
        [self.delegate seekTimeTouchEnd];
    }
}

- (void)didSelectedPlayBtn{
    if ([self.delegate respondsToSelector:@selector(didSelectedPlay)]) {
        [self.delegate didSelectedPlay];
    }
}

- (void)packagePlay:(BOOL)isPlay{
    if (isPlay) {
        [self.playBtn setImage:[UIImage imageNamed:CTVideoImage(@"ctvideo_pause")] forState:UIControlStateNormal];
    }else{
        [self.playBtn setImage:[UIImage imageNamed:CTVideoImage(@"ctvideo_play")] forState:UIControlStateNormal];
    }
}


- (UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [[UIButton alloc]init];
        [_playBtn addTarget:self action:@selector(didSelectedPlayBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UILabel *)nowTimeLabel{
    if (!_nowTimeLabel) {
        _nowTimeLabel = [[UILabel alloc]init];
        _nowTimeLabel.font = [UIFont systemFontOfSize:12.0];
        _nowTimeLabel.textColor = [UIColor whiteColor];
        _nowTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nowTimeLabel;
}

- (UILabel *)maxTimeLabel{
    if (!_maxTimeLabel) {
        _maxTimeLabel = [[UILabel alloc]init];
        _maxTimeLabel.font = [UIFont systemFontOfSize:12.0];
        _maxTimeLabel.textColor = [UIColor whiteColor];
        _maxTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _maxTimeLabel;
}

- (UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]init];
        [_slider setThumbImage:[UIImage imageNamed:CTVideoImage(@"ctvideo_record")] forState:UIControlStateNormal];
        [_slider setMinimumTrackTintColor:[UIColor whiteColor]];
        [_slider setMaximumTrackTintColor:[UIColor clearColor]];
        _slider.value = 0.0;
        [_slider addTarget:self action:@selector(sliderValueChanged:)  forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _slider;
}


- (UIProgressView *)progressView{
    
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        // 后面段
        _progressView.trackTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        // 前面段
        _progressView.progressTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    return _progressView;
}
@end
