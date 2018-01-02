//
//  SystemUser.h
//  CZBaseFramework
//
//  Created by wulanzhou-mini on 15-5-22.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZBaseObject.h"

/**
 * 登录用户信息
 */
@interface SystemUser : CZBaseObject

+ (SystemUser*)shareInstance;

/**
 *  用户UID号
 */
@property (nonatomic,strong) NSString *userId;
/**
 *  用户pid
 */
@property (nonatomic,strong) NSString *pid;
/**
 *  用户CID号  个推
 */
@property (nonatomic,strong) NSString *cId;
/**
 *  手机号码
 */
@property (nonatomic,strong) NSString *mobile;

/**
 *  用户密码
 */
@property (nonatomic,strong) NSString *password;
/**
 *  用户名称
 */
@property (nonatomic,strong) NSString *userName;
/**
 *  用户头像
 */
@property (nonatomic,strong) NSString *userHeadImage;

/**
 *  请求的token
 */
@property (nonatomic,strong) NSString *access_token;

/**
 *  过期时间
 */
@property (nonatomic,strong) NSString *expires_in;

/**
 *  保持登录的token
 */
@property (nonatomic,strong) NSString *refresh_token;


/**
 *  是否登陆
 */
@property (nonatomic,assign) BOOL isLogin;
/*
 *  环信用户名
 */
@property (nonatomic,strong) NSString *hx_username;
/*
 * 环信密码
 */
@property (nonatomic,strong) NSString *hx_password;



//判断是否为第一次运行
+ (BOOL)isFirstRun;

//设置完成第一次运行
+ (void)setFinisheFirstRun;

/**
 *  字典转换为对象
 *  @param dic 登录成功后的字典内容
 *  @reutrn    字典转对象
 */
- (id)initWithDictionary:(NSDictionary*)dic;


/**
 *  保存token访问时间
 */
- (void)saveExpiresDate:(NSString *)time;

/**
 *  判断access_token是否已过期
 *
 *  @return YES:表示过期 NO:表示未过期
 */
- (BOOL)isExpiresAccessToken;



- (void)removeAllUserInfo;
@end
