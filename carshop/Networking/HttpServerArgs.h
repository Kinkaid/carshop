//
//  HttpServerArgs.h
//  CoolFlow
//
//  Created by wulanzhou on 16/6/3.
//  Copyright © 2016年 wulanzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

//http请求方式
typedef enum {
    
    SCHW_None = 0,
    SCHW_Get,       //Get
    SCHW_Post       //Post
    
} SCHttpWay;

@interface HttpServerArgs : NSObject

/**
 *  请求base url
 */
@property (nonatomic,strong) NSString *urlString;

/**
 *  请求使用的url
 */
@property (nonatomic,readonly) NSString *requestURLString;

/**
 *  请求使用的url
 */
@property (nonatomic,readonly) NSString *requestURLString_args;

/**
 *  请求方式get,post (默认post请求)
 */
@property (nonatomic,assign) SCHttpWay httpWay;

/**
 *  请求方法
 */
@property (nonatomic,strong) NSString *methodName;

/**
 *  请求成功回调
 */
@property (nonatomic,copy) void (^requestFinishedBlock) (id response);

/**
 *  基于参数args封装(其它参数)
 *
 *  @param firstObject 可变参数 key与value组成
 */
-(void)paramWithObjectsAndKeys:(NSString*)firstObject, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  一次性设置所有请求参数
 *
 *  @param params 请求参数 key与value组成
 */
-(void)addParamWithDictionary:(NSDictionary*)params;

/**
 *  替换请求参数值
 *
 *  @param key   要替换的key
 *  @param value 要替换的值
 */
- (void)replaceParamWithKey:(NSString *)key paramValue:(id)value;

/**
 *  获取所有请求参数
 *
 *  @return
 */
- (NSDictionary *)getRequestParams;

@end
