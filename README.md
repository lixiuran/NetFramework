# NetFramework

NetFramework是一个简单的iOS网络请求框架，专注于提供验证码发送等网络功能。它基于NSURLSession实现，简单易用，支持成功和失败的回调机制。

## 功能特点

- 发送短信验证码
- 基于NSURLSession实现的网络请求
- 支持成功和失败的回调
- 简单易用的API设计

## 安装方法

### CocoaPods

```ruby
pod 'NetFramework', :git => 'https://github.com/yourusername/NetFramework.git'
```

### 手动安装

1. 下载仓库代码
2. 将NetFramework文件夹拖入项目中
3. 在需要使用的地方导入头文件：`#import <NetFramework/NetFramework.h>`

## 使用方法

### 发送验证码

```objective-c
[[NetRequestManager sharedManager] sendVerificationCodeToPhone:@"13812345678" 
                                                     success:^(NSDictionary *response) {
    // 处理成功响应
    NSLog(@"验证码发送成功: %@", response);
} failure:^(NSError *error) {
    // 处理错误
    NSLog(@"验证码发送失败: %@", error.localizedDescription);
}];
```

## 需求

- iOS 12.0+
- Xcode 13.0+

## 许可证

NetFramework 遵循 MIT 许可证。详情见 [LICENSE](LICENSE) 文件。 