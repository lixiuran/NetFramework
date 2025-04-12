//
//  NetRequestManager.h
//  NetFramework
//
//  Created by chen dandan on 2025/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 网络请求管理器，用于处理验证码等网络请求
 */
@interface NetRequestManager : NSObject

/**
 * 单例方法
 */
+ (instancetype)sharedManager;

/**
 * 发送验证码
 * @param phoneNumber 手机号码
 * @param success 成功回调
 * @param failure 失败回调
 */
- (void)sendVerificationCodeToPhone:(NSString *)phoneNumber 
                            success:(void(^)(NSDictionary *response))success 
                            failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END 