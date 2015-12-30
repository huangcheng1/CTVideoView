//
//  AVPlayerItem+Audio.m
//  Pods
//
//  Created by 黄成 on 15/12/28.
//
//

#import "AVPlayerItem+Audio.h"
#import "AVPlayerItem+Url.h"

@implementation AVPlayerItem (Audio)


- (void)setAudioMixWithValue:(CGFloat)audio{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:[self urlStr]] options:nil];
    NSArray *audioArray = [asset tracksWithMediaType:AVMediaTypeAudio];
    NSMutableArray *allAudioParams = [NSMutableArray array];
    for (AVAssetTrack * track in audioArray) {
        AVMutableAudioMixInputParameters *audioInputParams = [AVMutableAudioMixInputParameters audioMixInputParameters];
        [audioInputParams setVolume:audio atTime:kCMTimeZero];
        [audioInputParams setTrackID:[track trackID]];
        [allAudioParams addObject:audioInputParams];
    }
    
    AVMutableAudioMix *audioZeroMix = [AVMutableAudioMix audioMix];
    [audioZeroMix setInputParameters:allAudioParams];
    [self setAudioMix:audioZeroMix];
}


@end
