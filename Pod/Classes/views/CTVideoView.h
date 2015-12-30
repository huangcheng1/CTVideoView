//
//  CTVideoView.h
//  Pods
//
//  Created by 黄成 on 15/12/25.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CTPlayerView.h"

@interface CTVideoView : UIView

@property (nonatomic,strong) AVPlayer *player;

@property (nonatomic,strong) CTPlayerView *playView;

- (void)packageWithUrl:(NSString *)url hasSound:(BOOL)hasSound play:(BOOL)play;

@end
