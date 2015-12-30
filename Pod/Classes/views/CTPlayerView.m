//
//  CTPlayerView.m
//  Pods
//
//  Created by 黄成 on 15/12/25.
//
//

#import "CTPlayerView.h"
#import "CTVideoUtil.h"

@interface CTPlayerView ()

@property (nonatomic,strong) UIImageView *playImageBtn;

@end

@implementation CTPlayerView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        [self addSubview:self.playImageBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.playImageBtn.frame = CGRectMake(0, 0, 50, 50);
    self.playImageBtn.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) ;
}

- (void)packagePlayImageHide:(BOOL)isPlay{
    if (isPlay) {
        [self.playImageBtn setHidden:YES];
    }else{
        [self.playImageBtn setHidden:NO];
    }
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

- (UIImageView *)playImageBtn{
    if (!_playImageBtn) {
        _playImageBtn = [[UIImageView alloc]init];
        [_playImageBtn setImage:[UIImage imageNamed:CTVideoImage(@"ctvideo_btn_play@2x")]];
    }
    return _playImageBtn;
}
@end
