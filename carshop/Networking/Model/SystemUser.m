//
//  SystemUser.m
//  CZBaseFramework
//
//  Created by wulanzhou-mini on 15-5-22.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "SystemUser.h"
#import "Md5Encrypt.h"

#define kCFSystemLoginDateKey   @"login_%@_date"


@implementation SystemUser

static SystemUser *user = nil;


- (id)init{
    if (self=[super init]) {
      
        self.userId=@"";
        self.mobile =@"";
        self.password=@"";
        self.access_token=@"";
        self.refresh_token=@"";
        self.expires_in=@"";
        self.cId = @"";
        self.isLogin=NO;
        self.userHeadImage =  @"";
        self.pid = @"";
    }
    return self;
}

+ (SystemUser*)shareInstance{
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        user = [[SystemUser alloc]init];
    });
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *info = [userDefault objectForKey:@"USER"];
    if(!ISEMPTY(info)){
        user.userId = [NSString stringWithFormat:@"%@",[info objectForKey:@"id"]];
        user.access_token= [NSString stringWithFormat:@"%@",[info objectForKey:@"access_token"]];
        user.refresh_token= [NSString stringWithFormat:@"%@",[info objectForKey:@"refresh_token"]];
        user.expires_in= [NSString stringWithFormat:@"%@",[info objectForKey:@"expires_in"]];
        user.isLogin = YES;
        user.mobile = [NSString stringWithFormat:@"%@",[info objectForKey:@"mobile"]];
        user.pid = [NSString stringWithFormat:@"%@",[info objectForKey:@"p_id"]];
        user.userHeadImage =[NSString stringWithFormat:@"%@",[info objectForKey:@"img"]];
    } else {
        user.isLogin = NO;
    }
     return user;
}
/**
 *  字典转换为对象
 *  @param dic 登录成功后的字典内容
 *  @reutrn    字典转对象
 */
- (id)initWithDictionary:(NSDictionary*)dic{
    if (self=[super init]) {
        if (dic&&[dic isKindOfClass:[NSDictionary class]]&&[dic count]>0) {
            
            if ([dic.allKeys containsObject:@"id"]) {
                self.userId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            }
            
            if ([dic.allKeys containsObject:@"access_token"]){
                self.access_token=[dic objectForKey:@"access_token"];
            }
            
            if ([dic.allKeys containsObject:@"expires_in"]) {
                self.expires_in=[NSString stringWithFormat:@"%@",[dic objectForKey:@"expires_in"]];
            }
            if ([dic.allKeys containsObject:@"refresh_token"]){
                self.refresh_token=[dic objectForKey:@"refresh_token"];
            }
            self.isLogin=YES;
        }
    }
    return self;
}
/**
 *  保存token访问时间
 */
- (void)saveExpiresDate:(NSString *)time{
    [[NSUserDefaults standardUserDefaults] setObject:time forKey:[NSString stringWithFormat:kCFSystemLoginDateKey,self.userId]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  判断access_token是否已过期
 *

- (BOOL)isExpiresAccessToken{
    NSString *key=[NSString stringWithFormat:kCFSystemLoginDateKey,self.userId];
    NSString *loginDate=[CacheDataUtil valueForKey:key];
    if (loginDate) {
        NSInteger logintime = [loginDate intValue];
        NSInteger nowtime = [[NSDate date]timeIntervalSince1970];
         if (nowtime-logintime>=7000) {
            return YES;
         } else {
             return NO;
         }
    } else {
        return YES;
    }

}
**/
- (void)removeAllUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USER"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
