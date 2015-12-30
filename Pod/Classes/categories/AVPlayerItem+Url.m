//
//  AVPlayerItem+Url.m
//  Pods
//
//  Created by 黄成 on 15/12/25.
//
//

#import "AVPlayerItem+Url.h"
#import <objc/runtime.h>

static void *kVideoUrl = &kVideoUrl;

@implementation AVPlayerItem (Url)

- (void)setUrlStr:(NSString *)urlStr{
    objc_setAssociatedObject(self, kVideoUrl, urlStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)urlStr{
    return objc_getAssociatedObject(self, kVideoUrl);
}
@end
