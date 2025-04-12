//
//  NetRequestManager.m
//  NetFramework
//
//  Created by chen dandan on 2025/4/12.
//

#import "NetRequestManager.h"

@interface NetRequestManager ()
// 服务器基础URL
@property (nonatomic, strong) NSString *baseURL;
// 会话对象
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation NetRequestManager

#pragma mark - 单例方法
+ (instancetype)sharedManager {
    static NetRequestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        _baseURL = @"https://api.example.com/v1"; // 可以根据需要修改为实际的API地址
        
        // 创建会话配置
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 30.0; // 30秒超时
        
        // 创建会话
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}

#pragma mark - 公共方法
- (void)sendVerificationCodeToPhone:(NSString *)phoneNumber 
                            success:(void(^)(NSDictionary *response))success 
                            failure:(void(^)(NSError *error))failure {
    // 参数校验
    if (phoneNumber.length == 0) {
        NSError *error = [NSError errorWithDomain:@"com.netframework.error" 
                                             code:400 
                                         userInfo:@{NSLocalizedDescriptionKey: @"手机号码不能为空"}];
        if (failure) {
            failure(error);
        }
        return;
    }
    
    // 构建请求URL
    NSString *urlString = [NSString stringWithFormat:@"%@/sms/send", self.baseURL];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 设置请求参数
    NSDictionary *params = @{
        @"phoneNumber": phoneNumber,
        @"type": @"verification"
    };
    
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&jsonError];
    
    if (jsonError) {
        if (failure) {
            failure(jsonError);
        }
        return;
    }
    
    [request setHTTPBody:jsonData];
    
    // 创建数据任务
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 切换到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (failure) {
                    failure(error);
                }
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
                // 解析响应数据
                NSError *jsonError;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    if (failure) {
                        failure(jsonError);
                    }
                } else {
                    if (success) {
                        success(responseDict);
                    }
                }
            } else {
                // 服务器错误
                NSError *serverError = [NSError errorWithDomain:@"com.netframework.error" 
                                                          code:httpResponse.statusCode 
                                                      userInfo:@{NSLocalizedDescriptionKey: @"服务器响应错误"}];
                if (failure) {
                    failure(serverError);
                }
            }
        });
    }];
    
    // 启动任务
    [task resume];
}

@end 