#
#  Be sure to run `pod spec lint TestAlert.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "TestAlert"
  s.version      = "0.0.1"
  s.summary      = "test podspec"
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC

  s.homepage     = "https://github.com/a603938361/AlertController.git"
  s.license      = "MIT"

  s.author       = { "shunli.huang" => "shunli.huang@connext.com.cn" }

  s.source       = { :git => "https://github.com/a603938361/AlertController.git", :tag => "#{s.version}" }
  s.source_files  = "TestAlert", "*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
