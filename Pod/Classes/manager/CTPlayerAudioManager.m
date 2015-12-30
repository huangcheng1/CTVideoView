//
//  CTPlayerAudioManager.m
//  Pods
//
//  Created by 黄成 on 15/12/25.
//
//

#import "CTPlayerAudioManager.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation CTPlayerAudioManager

+ (CGFloat)getSystemAudio{
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    float val = [[MPMusicPlayerController applicationMusicPlayer] volume];
    return val;
#elif __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    MPVolumeView *slide = [[MPVolumeView alloc]init];
    UISlider *volumeView;
    float val = 0.0;
    for (UIView *view in [slide subviews] ) {
        if ([[[view class] description] isEqualToString:@"MPVolumeSlider"]) {
            volumeView = (UISlider*)view;
            val = [volumeView value];
        }
    }
    return val;
    
#endif
}


@end
