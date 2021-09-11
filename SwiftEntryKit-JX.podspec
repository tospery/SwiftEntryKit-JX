#
# Be sure to run `pod lib lint SwiftEntryKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name = 'SwiftEntryKit-JX'
  s.version = '1.2.7-v1'
  s.summary = 'A simple banner and pop-up displayer for iOS. Written in Swift.'
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.requires_arc = true

s.description      = <<-DESC
SwiftEntryKit is a banner presenter library for iOS. It can be used to easily display pop-ups and notification-like views within your iOS apps. SwiftEntryKit is highly customizable but also offers a bunch of beautiful presets that can be themed with your app fonts and colors.
DESC
  s.homepage         = 'https://github.com/tospery/SwiftEntryKit-JX'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YangJianxiang' => 'tospery@gmail.com' }
  s.source           = { :git => 'https://github.com/tospery/SwiftEntryKit-JX.git', :tag => s.version.to_s }
  s.source_files = 'Source/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'QuickLayout', '3.0.0'
end
