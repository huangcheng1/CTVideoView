//
//  UIView+PlayerItemSize.h
//  Pods
//
//  Created by 黄成 on 15/12/28.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIView (PlayerItemSize)

- (CGRect)frameWithPlayerItem:(AVPlayerItem*)playerItem withFrame:(CGRect)viewFrame;

- (CGRect)frameWithFullScreenPlayerItem:(AVPlayerItem*)playerItem withFrame:(CGRect)viewFrame;

+ (UIView*)getParentView:(UIView*)view;
@end
