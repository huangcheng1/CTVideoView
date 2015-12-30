//
//  CTVideoUtil.m
//  Pods
//
//  Created by 黄成 on 15/12/29.
//
//

#import "CTVideoUtil.h"
#import <AVFoundation/AVFoundation.h>

@implementation CTVideoUtil


+ (instancetype)sharedObj{
    static CTVideoUtil *shareObj;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareObj = [[CTVideoUtil alloc]init];
    });
    return shareObj;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
    }
    return self;
}

+ (NSString*)timeStrWithSecond:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[[self sharedObj] dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[[self sharedObj] dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[[self sharedObj] dateFormatter] stringFromDate:d];
    return showtimeNew;
}


+ (void)switchAudioSession:(BOOL)active{
    NSError *sessionError = nil;
    NSError *activeError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&sessionError];
    [[AVAudioSession sharedInstance] setActive:active error: &activeError];
}


@end
