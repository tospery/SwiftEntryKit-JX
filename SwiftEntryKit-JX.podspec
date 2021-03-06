#
# Be sure to run `pod lib lint SwiftEntryKit-JX.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftEntryKit-JX'
  s.version          = '1.2.3'
  s.summary          = 'A simple banner and pop-up displayer for iOS. Written in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/tospery/SwiftEntryKit-JX'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tospery' => 'yangjianxiang@xunyou.com' }
  s.source           = { :git => 'https://github.com/tospery/SwiftEntryKit-JX.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'SwiftEntryKit-JX/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftEntryKit-JX' => ['SwiftEntryKit-JX/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'QuickLayout', '3.0.0'
end
