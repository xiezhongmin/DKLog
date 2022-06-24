#
# Be sure to run `pod lib lint DKLog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DKLog'
  s.version          = '0.0.1'
  s.summary          = '基于mars/xlog的高性能日志组件, 支持 Cocoapods 集成.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xiezhongmin/DKLog'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiezhongmin' => '364101515@qq.com' }
  s.source           = { :git => 'https://github.com/xiezhongmin/DKLog.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'DKLog/Classes/**/*'
  s.public_header_files = 'DKLog/Classes/*.{h}'
  s.vendored_frameworks = 'DKLog/Frameworks/mars.framework'
  
  s.preserve_path = 'DKLog/Modulemap/DKLog.modulemap'
  s.module_map = 'DKLog/Modulemap/DKLog.modulemap'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.libraries = 'resolv.9', 'z'
  s.frameworks = 'SystemConfiguration', 'CoreTelephony'
  
  s.xcconfig = {
      'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
  }
  
end
