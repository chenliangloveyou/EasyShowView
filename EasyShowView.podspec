
Pod::Spec.new do |s|


  s.name         = "EasyShowView"
  s.version      = "2.1.4"
  s.summary      = "一款超级简单的展示工具，包括吐丝，loding加载，空白页提示，alertview，actionsheet的定制。可自定义动画，显示样式等各种操作。简单到爆。赶紧来试试吧~~~"
  s.homepage     = "https://github.com/chenliangloveyou/EasyShowView"
  s.license      = "MIT"
  s.author       = { "chenliangloveyou" => "ios_elite@163.com" }
  s.source       = { :git => "https://github.com/chenliangloveyou/EasyShowView.git", :tag => "#{s.version}"}
  s.frameworks = "Foundation", "UIKit"
  # s.public_header_files = "Classes/**/*.h"
  s.ios.deployment_target= '8.0'
  s.source_files = 'EasyShowView/EasyShowView.h'
 # s.public_header_files = 'EasyShowView/EasyShowView.h'

  s.subspec 'EasyText' do |ss|
  ss.dependency 'EasyShowView/EasyShowUtils'
  ss.source_files = 'EasyShowView/EasyText{View,BgView,Config,GlobalConfig,Types}.{h,m}'
 # ss.public_header_files = 'EasyShowView/EasyText{View,BgView,Config,GlobalConfig,Types}.h'
  end
 
  s.subspec 'EasyLoading' do |ss|
  ss.dependency 'EasyShowView/EasyShowUtils'
  ss.source_files = 'EasyShowView/EasyLoading{View,Config,GlobalConfig,Types}.{h,m}'
 # ss.public_header_files = 'EasyShowView/EasyLoading{View,Config,GlobalConfig,Types}.h'
  end

  s.subspec 'EasyEmpty' do |ss|
  ss.dependency 'EasyShowView/EasyShowUtils'
  ss.source_files = 'EasyShowView/EasyEmpty{View,Part,Config,GlobalConfig,Types}.{h,m}'
 #   ss.public_header_files = 'EasyShowView/EasyEmpty{View,Part,Config,GlobalConfig,Types}.h'
  end

  s.subspec 'EasyAlert' do |ss|
  ss.dependency 'EasyShowView/EasyShowUtils'
  ss.source_files = 'EasyShowView/EasyAlert{View,Part,Item,Config,GlobalConfig,Types}.{h,m}'
 #     ss.public_header_files = 'EasyShowView/EasyAlert{View,Part,Item,Config,GlobalConfig,Types}.h'
  end

  s.subspec 'EasyShowUtils' do |ss|
  ss.source_files = 'EasyShowView/EasyShow{Utils,Label}.{h,m}', 'EasyShowView/UIView+EasyShowExt.{h,m}'
#ss.public_header_files = 'EasyShowView/EasyShow{Utils,Label}.h', 'EasyShowView/UIView+EasyShowExt.h'

  end
end
