//
//  AVPlayer+AVPlayerItem.h
//  Pods
//
//  Created by 黄成 on 15/12/25.
//
//

#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, CTPlayerViewStatus){
    CTPlayerViewStatusPause = 0,
    CTPlayerViewStatusPlay = 1,
    CTPlayerViewStatusStop = 2
} ;

@interface AVPlayer (AVPlayerItem)

@property (nonatomic,strong) AVPlayerItem *ctPlayerItem;

@property (nonatomic,assign) CTPlayerViewStatus playStatus;

@end
