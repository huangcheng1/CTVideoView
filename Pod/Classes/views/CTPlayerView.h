//
//  CTPlayerView.h
//  Pods
//
//  Created by 黄成 on 15/12/25.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CTPlayerView : UIView

@property (nonatomic,strong) AVPlayer *player;

- (void)packagePlayImageHide:(BOOL)isPlay;

@end
