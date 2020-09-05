#
# Be sure to run `pod lib lint mfTextView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'mfTextView'
  s.version          = '1.0.2'
  s.summary          = 'mfTextView is a flexible textView with placeholder that gives you special features and will meet your needs for a textView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
mfTextView is a flexible textView with placeholder that gives you special features and will meet your needs for a textView.
mfTextView uses auto layout and it is easy to implement.
You can set title for that, show validation errors if needed and also you can specify the maximum length.

                       DESC

  s.homepage         = 'https://github.com/mohammadFirouzi/mfTextView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mohammad Firouzi' => 'mohammad.spz@icloud.com' }
  s.source           = { :git => 'https://github.com/mohammadFirouzi/mfTextView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Files/Classes/**/*'
  
  # s.resource_bundles = {
  #   'mfTextView' => ['mfTextView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
