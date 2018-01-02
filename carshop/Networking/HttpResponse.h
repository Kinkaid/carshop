//
//  HttpResponse.h
//  WaDaoServiceDemo
//
//  Created by wulanzhou on 16/6/3.
//  Copyright © 2016年 wulanzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

//重新登录通知
#define kNotificationTokenExpiresReLogin @"kNotificationTokenExpiresReLogin"

@interface HttpResponse : NSObject

/**
 *  请求失败状态码
 */
@property (nonatomic,strong) NSString *code;

/**
 *  请求失败原因
 */
@property (nonatomic,strong) id errMsg;

/**
 *  返回的数据
 */
@property (nonatomic,strong) id responseData;

/**
 *  请求是否成功
 */
@property (nonatomic,readonly) BOOL success;

/**
 *  成功请求初始化
 *
 *  @param responseObject 请求返回的数据
 *
 *  @return 
 */
- (id)initWithDictionary:(NSDictionary *)responseObject;

/**
 *  失败请求初始化
 *
 *  @param error
 *
 *  @return
 */
- (id)initWithError:(NSError *)error;

@end
