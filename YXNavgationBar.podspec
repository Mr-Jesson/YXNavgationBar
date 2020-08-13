Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "YXNavgationBar"
  spec.version      = "0.0.1"
  spec.summary      = "YXNavgationBar"

  spec.description  = "iOS导航栏,可进行高度自定义，解决系统导航栏修改麻烦等问题"

  spec.homepage     = "https://github.com/Mr-Jesson/YXNavgationBar"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author    = "Jesson"

  spec.source       = { :git => "https://github.com/Mr-Jesson/YXNavgationBar.git", :tag => "#{spec.version}" }


  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"
  spec.platform = :ios, "9.0"

end
