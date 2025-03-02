Pod::Spec.new do |s|
  s.name             = 'ZHHSlidePopupView'
  s.version          = '0.0.1'
  s.summary          = 'ZHHSlidePopupView - 一个支持滑动弹出的自定义视图组件。'

  # 详细描述 pod 的功能、用途及特点
  s.description      = <<-DESC
  ZHHSlidePopupView 是一个轻量级的自定义视图组件，支持从屏幕底部或指定位置滑动弹出，
  并提供多种交互方式，如手势拖动关闭、自动对齐、背景模糊效果等。
  适用于弹窗、选项面板、输入框等场景，增强用户交互体验。
  DESC

  s.homepage         = 'https://github.com/yue5yueliang/ZHHSlidePopupView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '桃色三岁' => '136769890@qq.com' }
  s.source           = { :git => 'https://github.com/yue5yueliang/ZHHSlidePopupView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'

  # 源文件路径，指明需要包含的源代码文件
  s.source_files = 'ZHHSlidePopupView/Classes/**/*'

  # 如果需要包含资源文件，可以通过下面的代码添加
  # s.resource_bundles = {
  #   'ZHHSlidePopupView' => ['ZHHSlidePopupView/Assets/*.png']
  # }

  # 如果有公共的头文件，可以指定公共头文件路径
  # s.public_header_files = 'ZHHSlidePopupView/Classes/**/*.h'

  # 如果库依赖其他框架，可以在这里声明依赖
  s.frameworks = 'UIKit'

  # 如果库依赖其他第三方 pod，可以通过 s.dependency 来声明
  # s.dependency 'AFNetworking', '~> 2.3'
end
