#
# Be sure to run `pod lib lint Swiftesla.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Swiftesla'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Swiftesla.'
  s.description      = 'A Swift tool kit'
  s.homepage         = 'https://github.com/wangyutao/Swiftesla'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangyutao' => 'wangyutao0424@163.com' }
  s.source           = { :git => 'https://github.com/wangyutao0424/Swiftesla.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Swiftesla/Classes/**/*'
  s.swift_versions = ['5.0']
#   s.dependency 'AFNetworking', '~> 2.3'
end
