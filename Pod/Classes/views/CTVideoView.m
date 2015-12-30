//
//  CTVideoView.m
//  Pods
//
//  Created by 黄成 on 15/12/25.
//
//

#import "CTVideoView.h"
#import "AVPlayerItem+Url.h"
#import "AVPlayer+AVPlayerItem.h"
#import "CTPlayerAudioManager.h"
#import "UIView+PlayerItemSize.h"
#import "CTVideoUtil.h"
#import "CTVideoVC.h"
#import "AVPlayerItem+Audio.h"

/*
 * 直接上滑 控制声音
 * 斜上滑
 */

static NSString *const kPlayerItemStatus = @"status";

@interface CTVideoView ()

@end

@implementation CTVideoView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.playView];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnPlayer)]];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
}

- (void)tapOnPlayer{
    [self.playView packagePlayImageHide:YES];
    [[[CTVideoVC alloc]init] showVideoVCWith:self.playView.player withView:self.playView];
}

- (void)packageWithUrl:(NSString *)url hasSound:(BOOL)hasSound play:(BOOL)play{
    NSURL *videoUrl = [NSURL URLWithString:url];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [playerItem setUrlStr:url];
    AVPlayerItem *beforeItem = [self.player currentItem];
    if (beforeItem == nil) {
        [playerItem addObserver:self forKeyPath:kPlayerItemStatus options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    }else{
        //url不一致，重新加载
        [beforeItem removeObserver:self forKeyPath:kPlayerItemStatus];
        [playerItem addObserver:self forKeyPath:kPlayerItemStatus options:NSKeyValueObservingOptionNew context:nil];// 监听status属性

    }
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.playView.player = self.player;
    if (play) {
        [self.player play];
        [self.playView packagePlayImageHide:YES];
    }
    if (hasSound) {
        self.player.muted = NO;
    }else{
        self.player.muted = YES;
    }
}
- (void)setSubFrame{
    self.playView.frame = [self.playView frameWithPlayerItem:[self.playView.player currentItem] withFrame:self.bounds];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:kPlayerItemStatus]) {
        AVPlayerItem *playerItem = (AVPlayerItem*)object;
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            /*
             设置视频frame，获取时长等
             */
            [self setSubFrame];
        }
    }
}
- (CTPlayerView *)playView{
    if (!_playView) {
        _playView = [[CTPlayerView alloc]init];
    }
    return _playView;
}

- (AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}

- (void)dealloc{
    
    AVPlayerItem *beforeItem = [self.player currentItem];
    [beforeItem removeObserver:self forKeyPath:kPlayerItemStatus];
}
@end
