//
//  CTVideoControlView.h
//  Pods
//
//  Created by 黄成 on 15/12/28.
//
//

#import <UIKit/UIKit.h>

@protocol CTVideoControlViewDelegate <NSObject>

@optional

- (void)seekTimeToValue:(CGFloat)value;
- (void)seekTimeTouchEnd;

- (void)didSelectedPlay;

@end

@interface CTVideoControlView : UIView

@property (nonatomic,weak) id<CTVideoControlViewDelegate>delegate;

- (void)packagePlay:(BOOL)isPlay;

- (void)packageNowTime:(CGFloat)nowTime maxTime:(CGFloat)maxTime available:(CGFloat)availableTime;

@end
