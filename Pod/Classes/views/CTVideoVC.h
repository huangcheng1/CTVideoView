//
//  CTVideoVC.h
//  Pods
//
//  Created by 黄成 on 15/12/28.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CTVideoVC : UIView

@property (nonatomic,strong) AVPlayer *player;

- (void)showVideoVCWith:(AVPlayer*)player withView:(UIView*)view;

@end
