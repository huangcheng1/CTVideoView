//
//  CTVideoVC.m
//  Pods
//
//  Created by 黄成 on 15/12/28.
//
//

#import "CTVideoVC.h"
#import "UIView+PlayerItemSize.h"
#import "CTPlayerView.h"
#import "AVPlayer+AVPlayerItem.h"
#import "AVPlayerItem+Audio.h"
#import "CTVideoUtil.h"
#import "CTVideoControlView.h"
#import <MediaPlayer/MediaPlayer.h>

static NSString *const kPlayerItemStatus = @"status";
static NSString *const kPlayerItemLoadedTime = @"loadedTimeRanges";

@interface CTVideoVC ()<CTVideoControlViewDelegate>
{
    BOOL scrollEnable;  // if originViewController is scrollView need.
    CGPoint locationPoint;
    NSInteger deviceDirection;
    CGFloat startPoint;
    CGFloat lightValue;
    CGFloat volumeValue;
}

@property (nonatomic,strong) CTPlayerView *playView;
@property (nonatomic,strong) CTVideoControlView *controlView;

@property (nonatomic, strong) MPVolumeView *volumeView;
@property (nonatomic, strong) UISlider *volumeSlider;

@property (nonatomic,strong) id playbackTimeObserver;

@property (nonatomic,assign) CGFloat totalTime;
@property (nonatomic,assign) CGFloat cacheTime;
@property (nonatomic,assign) CGFloat currentTime;

@property (nonatomic,strong) UIView *sourceView;

@property (nonatomic,assign) BOOL muted;

@end

@implementation CTVideoVC

- (instancetype)init{
    self = [super init];
    if (self) {
        self.totalTime = 0.0;
        self.cacheTime = 0.0;
        self.currentTime = 0.0;
        [self addSubview:self.playView];
        [self addSubview:self.controlView];
        [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        self.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnView:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapGesture];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panOnView:)];
        [self addGestureRecognizer:panGesture];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}
/*
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    dispatch_after(3.0, dispatch_get_main_queue(), ^{
        [self controlViewHide];
    });
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self controlViewShow];
}
 */

- (void)tapOnView:(id)sender{
    
    if (self.playView.player.playStatus == CTPlayerViewStatusPlay) {
        [self hide];
    }else{
        [self packageSubView:YES];
    }
}
- (void)panOnView:(id)sender{
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer*)sender;
    CGPoint translationPoint = [gesture translationInView:self];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        locationPoint = [gesture locationInView:self];
        lightValue = [UIScreen mainScreen].brightness;
        volumeValue = self.volumeSlider.value;
        startPoint = locationPoint.y;
    }
    CGFloat result;
    if (locationPoint.x < CGRectGetWidth(self.bounds)/2.f) {
        // 亮度
        if (translationPoint.y < -10 || translationPoint.y > 10) {
            result = lightValue - translationPoint.y/400.f;
            [[UIScreen mainScreen] setBrightness:result];
        }
        
    } else {
        // 声音
        if (translationPoint.y < -10 || translationPoint.y > 10) {
            result = volumeValue - translationPoint.y/400.f;
            [self.volumeSlider setValue:result animated:YES];
            [self.volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)showVideoVCWith:(AVPlayer*)player withView:(UIView *)view{
    
    [CTVideoUtil switchAudioSession:YES];
    
    self.sourceView = view;
    self.player = player;
    AVPlayerItem *playerItem = [player currentItem];
    [playerItem setAudioMixWithValue:1.0];
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    window.windowLevel = UIWindowLevelAlert;
    [window addSubview:self];
    
    UIView *sourceView = view;
    CGRect rect = [sourceView.superview convertRect:sourceView.frame toView:[UIView getParentView:sourceView]];
    self.playView.frame = rect;
    
    if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
        [self readyToPlay];
        [playerItem addObserver:self forKeyPath:kPlayerItemStatus options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
        [playerItem addObserver:self forKeyPath:kPlayerItemLoadedTime options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    }else{
        [playerItem addObserver:self forKeyPath:kPlayerItemStatus options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
        [playerItem addObserver:self forKeyPath:kPlayerItemLoadedTime options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIView *root = [UIView getParentView:self.sourceView];
    [self setFrame:root.bounds];
    AVPlayerItem *playerItem = [self.playView.player currentItem];
    CGRect targetTemp = [self.playView frameWithFullScreenPlayerItem:playerItem withFrame:self.bounds];
    self.playView.frame = targetTemp;
    self.controlView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 44);
    [self orientChange:nil];
    [self controlViewShow];
}

- (void)packageSubView:(BOOL)isPlay{
    if (isPlay) {
        [self.playView.player play];
        [self.controlView packagePlay:YES];
        [self.playView.player setPlayStatus:CTPlayerViewStatusPlay];
        [self.playView packagePlayImageHide:YES];
    }else{
        [self.playView.player pause];
        [self.controlView packagePlay:NO];
        [self.playView.player setPlayStatus:CTPlayerViewStatusPause];
        [self.playView packagePlayImageHide:NO];
    }
}

- (void)controlViewShow{
    [UIView animateWithDuration:0.2 animations:^{
        self.controlView.frame = CGRectMake(0, self.frame.size.height - 44, self.frame.size.width, 44);
    }];
}
- (void)controlViewHide{
    [UIView animateWithDuration:0.2 animations:^{
        self.controlView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 44);
    }];
}
- (void)orientChange:(NSNotification *)notif
{
    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
    switch (orient)
    {
        case UIDeviceOrientationPortrait:
            deviceDirection = 1;
            break;
        case UIDeviceOrientationLandscapeLeft:
            deviceDirection = 2;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            deviceDirection = 3;
            break;
        case UIDeviceOrientationLandscapeRight:
            deviceDirection = 4;
            break;
        default:
            deviceDirection = 1;
            
            break;
    }
}

- (void)hide{
    
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    window.windowLevel = UIWindowLevelNormal;
    if (self.muted) {
        self.playView.player.muted = NO;
    }
    if (self.sourceView) {
        UIView *sourceView = self.sourceView;
        CGRect rect = [sourceView.superview convertRect:sourceView.frame toView:[UIView getParentView:sourceView]];
        [UIView animateWithDuration:0.3 animations:^{
            self.playView.frame = rect;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [self removeFromSuperview];
    }
}

- (void)readyToPlay{
    [self packageSubView:YES];
    if ([self.playView.player isMuted]) {
        self.muted = YES;
        self.player.muted = NO;
    }
    AVPlayerItem *playerItem = [self.playView.player currentItem];
    CGRect targetTemp = [self.playView frameWithFullScreenPlayerItem:playerItem withFrame:self.bounds];
    [UIView animateWithDuration:.2 animations:^{
        self.playView.frame = targetTemp;
    } completion:^(BOOL finished) {
    }];
    CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;
    self.totalTime = totalSecond;
    [self monitoringPlayBack];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:kPlayerItemStatus]) {
        AVPlayerItem *playerItem = (AVPlayerItem*)object;
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            /*
             设置视频frame，获取时长等
             */
            [self readyToPlay];
        }
    }else if ([keyPath isEqualToString:kPlayerItemLoadedTime]){
        
        NSArray *array = [self.player.currentItem loadedTimeRanges];
        CMTimeRange range = [array.firstObject CMTimeRangeValue];//从哪儿开始的
        CGFloat start = CMTimeGetSeconds(range.start);//缓存了多少
        CGFloat duration = CMTimeGetSeconds(range.duration);//一共缓存了多少
        CGFloat allCache = start+duration;
        self.cacheTime = allCache;
    }
}


- (void)monitoringPlayBack{
    if (self.playbackTimeObserver) {
        [self.playView.player removeTimeObserver:self.playbackTimeObserver];
    }
    
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.playView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) usingBlock:^(CMTime time) {
        AVPlayerItem *beforeItem = [weakSelf.player currentItem];
        CGFloat currentSecond = beforeItem.currentTime.value/beforeItem.currentTime.timescale;
        weakSelf.currentTime = currentSecond;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.controlView packageNowTime:currentSecond maxTime:weakSelf.totalTime available:weakSelf.cacheTime];
        });
    }];
}

#pragma mark - CTVideoControlViewDelegate

- (void)seekTimeToValue:(CGFloat)value{
    [self.playView.player pause];
    [self.playView.player seekToTime:CMTimeMake(value, 1) toleranceBefore:CMTimeMake(1, 1) toleranceAfter:CMTimeMake(1, 1)];
}

- (void)seekTimeTouchEnd{
    [self packageSubView:YES];
}

- (void)didSelectedPlay{
    if ([self.playView.player playStatus] == CTPlayerViewStatusPause) {
        [self packageSubView:YES];
    }else if ([self.playView.player playStatus] == CTPlayerViewStatusStop){
        [self packageSubView:YES];
    }else if ([self.playView.player playStatus] == CTPlayerViewStatusPlay){
        [self packageSubView:NO];
    }
}

#pragma mark - getter

- (void)setPlayer:(AVPlayer *)player{
    if (player) {
        self.playView.player = player;
        _player = player;
    }
}
- (CTPlayerView *)playView{
    if (!_playView) {
        _playView = [[CTPlayerView alloc]init];
    }
    return _playView;
}

- (CTVideoControlView *)controlView{
    if (!_controlView) {
        _controlView = [[CTVideoControlView alloc]init];
        _controlView.delegate = self;
    }
    return _controlView;
}
- (UISlider *)volumeSlider
{
    if (!_volumeSlider) {
        _volumeSlider = ({
            UISlider *volumeSlider = nil;
            for (UIView *view in self.volumeView.subviews) {
                if ([view.class.description isEqualToString:@"MPVolumeSlider"]) {
                    volumeSlider = (UISlider *)view;
                    break;
                }
            }
            volumeSlider;
        });
    }
    return _volumeSlider;
}

- (MPVolumeView *)volumeView{
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc]init];
    }
    return _volumeView;
}

- (void)dealloc{
    
    [self.playView.player removeTimeObserver:self.playbackTimeObserver];
    [[self.playView.player currentItem] removeObserver:self forKeyPath:kPlayerItemStatus];
    [[self.playView.player currentItem] removeObserver:self forKeyPath:kPlayerItemLoadedTime];
}
@end
