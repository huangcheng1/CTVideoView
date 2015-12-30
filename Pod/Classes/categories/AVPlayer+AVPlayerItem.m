//
//  AVPlayer+AVPlayerItem.m
//  Pods
//
//  Created by 黄成 on 15/12/25.
//
//

#import "AVPlayer+AVPlayerItem.h"
#import <objc/runtime.h>

static void *kVideoPlayerItem = &kVideoPlayerItem;
static void *kVideoPlayerStatus = &kVideoPlayerStatus;

@implementation AVPlayer (AVPlayerItem)

- (void)setCtPlayerItem:(AVPlayerItem *)ctPlayerItem{
    objc_setAssociatedObject(self, kVideoPlayerItem, ctPlayerItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AVPlayerItem *)ctPlayerItem{
    return objc_getAssociatedObject(self, kVideoPlayerItem);
}

- (void)setPlayStatus:(CTPlayerViewStatus)playStatus{
    objc_setAssociatedObject(self, kVideoPlayerStatus, @(playStatus), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CTPlayerViewStatus)playStatus{
    return (int)[objc_getAssociatedObject(self, kVideoPlayerStatus) intValue];
}

@end
