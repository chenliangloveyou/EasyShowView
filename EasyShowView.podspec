
Pod::Spec.new do |s|


  s.name         = "EasyShowView"
  s.version      = "2.1.3"
  s.summary      = "一款超级简单的展示工具，包括吐丝，loding加载，空白页提示，alertview，actionsheet的定制。可自定义动画，显示样式等各种操作。简单到爆。赶紧来试试吧~~~"
  s.homepage     = "https://github.com/chenliangloveyou/EasyShowView"
  s.license      = "MIT"
  s.author       = { "chenliangloveyou" => "ios_elite@163.com" }
  s.source       = { :git => "https://github.com/chenliangloveyou/EasyShowView.git", :tag => "#{s.version}"}
  s.frameworks = "Foundation", "UIKit"
  # s.public_header_files = "Classes/**/*.h"
  s.ios.deployment_target= '8.0'
  s.source_files = 'EasyShowView/EasyShowView.h'

  s.subspec 'EasyText' do |ss|
  	ss.source_files = 'EasyShowView/EasyText/EasyText{View,BgView,Config,GlobalConfig,Types}.{h,m}'
  end
 
  s.subspec 'EasyLoading' do |ss|
  	ss.source_files = 'EasyShowView/EasyLoading/EasyLoading{View,Config,GlobalConfig,Types}.{h,m}'
  end

  s.subspec 'EasyEmpty' do |ss|
  	ss.source_files = 'EasyShowView/EasyEmpty/EasyEmpty{View,Part,Config,GlobalConfig,Types}.{h,m}'
  end

  s.subspec 'EasyAlert' do |ss|
  	ss.source_files = 'EasyShowView/EasyAlert/EasyAlert{View,Part,Item,Config,GlobalConfig,Types}.{h,m}'
  end

  s.subspec 'EasyShowUtils' do |ss|
  	ss.source_files = 'EasyShowView/EasyShowUtils/EasyShow{Utils,Label}.{h,m}', 'EasyShowView/EasyShowUtils/UIView+EasyShowExt.{h,m}'
  end
end
