#
# Be sure to run `pod lib lint CTVideoView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CTVideoView"
  s.version          = "0.1.0"
  s.summary          = "CTVideoView weibo custom video 自定义视频播放器"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  CTVideoView weibo custom video 自定义视频播放器
  模仿微博视频播放器，支持亮度，声音调节，进度控制
                       DESC

  s.homepage         = "https://github.com/Mikora/CTVideoView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "root" => "632300630@qq.com" }
  s.source           = { :git => "https://github.com/Mikora/CTVideoView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  
  s.resource_bundles = {
    'CTVideoView' => ['Pod/Assets/images/*.png']
  }
  
  
  s.public_header_files = 'Pod/Classes/*.h'
  s.source_files = 'Pod/Classes/*.{h,m}'
  
  s.subspec 'categories' do |ss|
      ss.public_header_files = 'Pod/Classes/categories/**/*.h'
      ss.source_files = 'Pod/Classes/categories/**/*'
      ss.frameworks = 'AVFoundation','UIKit','Foundation'
  end
  s.subspec 'manager' do |ss|
      ss.public_header_files = 'Pod/Classes/manager/**/*.h'
      ss.source_files = 'Pod/Classes/manager/**/*'
      ss.frameworks = 'AVFoundation','MediaPlayer','Foundation'
  end
  s.subspec 'views' do |ss|
      ss.dependency 'CTVideoView/categories'
      ss.dependency 'CTVideoView/manager'
      ss.public_header_files = 'Pod/Classes/views/**/*.h'
      ss.source_files = 'Pod/Classes/views/**/*'
      ss.frameworks = 'AVFoundation','UIKit','Foundation'
  end
  s.subspec 'controllers' do |ss|
      ss.dependency 'CTVideoView/views'
      ss.dependency 'CTVideoView/manager'
      ss.public_header_files = 'Pod/Classes/controllers/**/*.h'
      ss.source_files = 'Pod/Classes/controllers/**/*'
      ss.frameworks = 'AVFoundation','UIKit','Foundation'
  end
end
