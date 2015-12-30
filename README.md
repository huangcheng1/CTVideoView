# CTVideoView

[![CI Status](http://img.shields.io/travis/root/CTVideoView.svg?style=flat)](https://travis-ci.org/root/CTVideoView)
[![Version](https://img.shields.io/cocoapods/v/CTVideoView.svg?style=flat)](http://cocoapods.org/pods/CTVideoView)
[![License](https://img.shields.io/cocoapods/l/CTVideoView.svg?style=flat)](http://cocoapods.org/pods/CTVideoView)
[![Platform](https://img.shields.io/cocoapods/p/CTVideoView.svg?style=flat)](http://cocoapods.org/pods/CTVideoView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CTVideoView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

## How To Use

```
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
```

you can see CTTestViewController


```ruby
pod "CTVideoView"
```

## preview

![image](http://7xpas5.com1.z0.glb.clouddn.com/ctvideoview_screen_1.png?imageView/1/w/187/h/333)
![image](http://7xpas5.com1.z0.glb.clouddn.com/ctvideoview_screen_2.png?imageView/1/w/187/h/333)
![image](http://7xpas5.com1.z0.glb.clouddn.com/ctvideoview_screen_3.png?imageView/1/w/187/h/333)

## Author

root, 632300630@qq.com

## License

CTVideoView is available under the MIT license. See the LICENSE file for more info.
