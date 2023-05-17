#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |spec|
  spec.name             = 'ChindlePointRead'
  spec.version          = '1.0.0'
  spec.summary          = 'ChindlePointRead for cocoapods'

  spec.homepage            = 'https://github.com/zhuxiaod/ChindlePointRead'
  spec.license          =   { :type => 'MIT', :file => 'LICENSE' }
  spec.author              = { 'zhuxiaod' => 'zhuxiaod_183202114@qq.com' }
  spec.source              = { :git => 'https://github.com/zhuxiaod/ChindlePointRead.git', :tag => spec.version.to_s }
  
  spec.platform = :ios

  spec.ios.deployment_target = '11.0'

  spec.static_framework = true

  spec.source_files = 'ChindlePointRead/**/**/*'

  spec.public_header_files = 'ChindlePointRead/**/**/*.h'

  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'DEFINES_MODULE' => 'YES'
  }

  spec.swift_versions = ['5']
    
  spec.frameworks = 'AVFoundation','UIKit','Foundation'

  spec.dependency 'AFNetworking'
  spec.dependency 'MJRefresh'
  spec.dependency 'MJExtension'
  spec.dependency 'Masonry'
  spec.dependency 'ChindleKit'
  spec.dependency 'YYKit'
  spec.dependency 'FDFullscreenPopGesture'
  spec.dependency 'SDWebImage'
  spec.dependency 'SVProgressHUD'
  spec.dependency 'ChindleShareKit'
  spec.dependency 'ChindleKit'

  spec.prefix_header_contents = 
  '#import "ChindlePointRead.h"',
  '#import <AFNetworking/AFHTTPSessionManager.h>',
  '#import <MJRefresh/MJRefresh.h>',
  '#import <MJExtension/MJExtension.h>',
  '#import <Masonry/Masonry.h>',
  '#import <ChindleKit/ChindleBaseKit.h>',
  '#import <YYKit/YYKit.h>',
  '#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>',
  '#import <SDWebImage/SDWebImage.h>',
  '#import <ChindleShareKit/ChindleShareKit.h>',
  '#import <SVProgressHUD/SVProgressHUD.h>'
  '#import <ChindleKit/ChindleBaseKit.h>'
  spec.requires_arc = true

  # 开放的库资源文件 - 有资源则需要打开这里的注释
  spec.resource = 'Assets/*.bundle'

end
