//
//  CTVideoUtil.h
//  Pods
//
//  Created by 黄成 on 15/12/29.
//
//

#import <Foundation/Foundation.h>

#define CTVideoImage(key) [NSString stringWithFormat:@"CTVideoView.bundle/%@",(key)]

@interface CTVideoUtil : NSObject

@property (nonatomic,strong) NSDateFormatter *dateFormatter;

+ (instancetype)sharedObj;

+ (NSString*)timeStrWithSecond:(CGFloat)second;

+ (void)switchAudioSession:(BOOL)active;


@end
