Pod::Spec.new do |spec|
  spec.name         = "NetFramework"
  spec.version      = "0.1.2"
  spec.summary      = "iOS网络请求框架，用于发送验证码等网络操作"
  spec.description  = <<-DESC
                    NetFramework是一个简单的网络请求框架，提供了发送验证码等基本网络功能，
                    支持成功和失败的回调机制，使用NSURLSession实现网络请求。
                    框架简单易用，API设计清晰，适合快速集成到项目中。
                   DESC
  spec.homepage     = "https://github.com/lixiuran/NetFramework"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "chen dandan" => "your_email@example.com" }
  spec.platform     = :ios, "12.0"
  spec.swift_version = "5.0"
  spec.source       = { :git => "https://github.com/lixiuran/NetFramework.git", :tag => "#{spec.version}" }
  spec.source_files = "**/*.{h,m}"
  spec.public_header_files = "**/*.h"
  spec.framework    = "Foundation"
  spec.requires_arc = true
  spec.social_media_url = "https://github.com/lixiuran"
end 