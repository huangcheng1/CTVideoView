//
//  CTTableViewCell.m
//  Pods
//
//  Created by 黄成 on 15/12/28.
//
//

#import "CTTableViewCell.h"
#import "CTVideoView.h"

@interface CTTableViewCell ()

@property (nonatomic,strong) CTVideoView *videoView;

@end

@implementation CTTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.videoView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)packageWithUrl:(NSString *)url hasSound:(BOOL)hasSound play:(BOOL)play{
    
    [self.videoView packageWithUrl:url hasSound:hasSound play:play];
}

- (CTVideoView *)videoView{
    if (!_videoView) {
        _videoView = [[CTVideoView alloc]init];
        _videoView.frame = CGRectMake(0, 30, 160, 90);
    }
    return _videoView;
}
@end
