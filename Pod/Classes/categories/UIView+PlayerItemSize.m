//
//  UIView+PlayerItemSize.m
//  Pods
//
//  Created by 黄成 on 15/12/28.
//
//

#import "UIView+PlayerItemSize.h"

@implementation UIView (PlayerItemSize)

- (CGRect)frameWithPlayerItem:(AVPlayerItem*)playerItem withFrame:(CGRect)viewFrame{
    CGSize playerItemSize = playerItem.presentationSize;
    CGRect frame;
    if (playerItemSize.width <= viewFrame.size.width && playerItemSize.height <= viewFrame.size.height) {//宽高都小于，直接放上去
        frame = CGRectMake(0, (viewFrame.size.height - playerItemSize.height)/2, playerItemSize.width, playerItemSize.height);
        
    }else if (playerItemSize.width > viewFrame.size.width && playerItemSize.height < viewFrame.size.height){
        CGFloat a = playerItemSize.width / viewFrame.size.width;
        CGFloat height = playerItemSize.height / a;
        frame = CGRectMake(0, (viewFrame.size.height - height)/2, viewFrame.size.width, height);
    }else{
        CGFloat a = playerItemSize.height / viewFrame.size.height;
        CGFloat width = playerItemSize.width / a;
        frame = CGRectMake(0, 0, width, viewFrame.size.height);
    }
    return frame;
}

- (CGRect)frameWithFullScreenPlayerItem:(AVPlayerItem*)playerItem withFrame:(CGRect)viewFrame{
    
    CGSize playerItemSize = playerItem.presentationSize;
    CGRect frame;
    if (playerItemSize.width <= viewFrame.size.width && playerItemSize.height <= viewFrame.size.height) {//宽高都小于，直接放上去
        frame = CGRectMake((viewFrame.size.width - playerItemSize.width)/2, (viewFrame.size.height - playerItemSize.height)/2, playerItemSize.width, playerItemSize.height);
        
    }else if (playerItemSize.width > viewFrame.size.width && playerItemSize.height < viewFrame.size.height){
        CGFloat a = playerItemSize.width / viewFrame.size.width;
        CGFloat height = playerItemSize.height / a;
        frame = CGRectMake(0, (viewFrame.size.height - height)/2, viewFrame.size.width, height);
    }else{
        CGFloat a = playerItemSize.height / viewFrame.size.height;
        CGFloat width = playerItemSize.width / a;
        frame = CGRectMake((viewFrame.size.width - width)/2, 0, width, viewFrame.size.height);
    }
    return frame;

}
+ (UIView*)getParentView:(UIView*)view{
    if ([[view nextResponder]isKindOfClass:[UIViewController class]] || view == nil) {
        return view;
    }return [UIView getParentView:view.superview];
}
@end
