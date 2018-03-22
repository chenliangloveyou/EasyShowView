
Pod::Spec.new do |s|


  s.name         = "EasyShowView"
  s.version      = "2.1.1"
  s.summary      = "一款超级简单的展示工具，包括吐丝，loding加载，空白页提示，alertview，actionsheet的定制。可自定义动画，显示样式等各种操作。简单到爆。赶紧来试试吧~~~"
  s.description  = "一款超级简单的展示工具，包括吐丝，loding加载，空白页提示，alertview，actionsheet的定制。可自定义动画，显示样式等各种操作，使各种显示不再孤单。简单到爆。全新改版，定制更加自由，赶紧来试试吧~~~"
  s.homepage     = "https://github.com/chenliangloveyou/EasyShowView"
  s.license      = "MIT"
  s.author       = { "chenliangloveyou" => "ios_elite@163.com" }
  s.source       = { :git => "https://github.com/chenliangloveyou/EasyShowView.git", :commit => "3df6aa1182805e91700774e1c4dd98ceb18e5022" }
  s.source_files = "EasyShowView/**/*.{h,m}"
  s.frameworks = "Foundation", "UIKit"
  # s.public_header_files = "Classes/**/*.h"
  s.ios.deployment_target= '8.0'

 
end
