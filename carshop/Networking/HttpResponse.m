//
//  HttpResponse.m
//  WaDaoServiceDemo
//
//  Created by wulanzhou on 16/6/3.
//  Copyright © 2016年 wulanzhou. All rights reserved.
//

#import "HttpResponse.h"

@implementation HttpResponse


/**
 *  失败请求初始化
 *
 *  @param error
 *
 *  @return
 */
- (id)initWithError:(NSError *)error{
    self = [super init];
    if (self){
    
        self.code=@"-3";
        self.errMsg=error.description;
        NSLog(@"请求错误 error.userInfo-->\n%@",error.userInfo);
    }
    return self;
}

/**
 *  初始化
 *
 *  @param responseObject 请求返回的数据
 *
 *  @return
 */
- (id)initWithDictionary:(NSDictionary *)responseObject {
    if (self = [super init]) {
        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]&&[responseObject count]>0) {
        
            if ([responseObject.allKeys containsObject:@"code"]) {
                self.code=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
                if ([self.code isEqualToString:@"000"]) {
//                    self.success = YES;
                }else{
//                    self.success = NO;
                }
            } else {
                self.code=@"-1";
            }
            if ([responseObject.allKeys containsObject:@"msg"]) {
                self.errMsg=[responseObject objectForKey:@"msg"];
            } else {
                self.errMsg=@"未取到状态码";
            }
            //返回的数据
            if ([responseObject.allKeys containsObject:@"data"]){
                self.responseData=[responseObject objectForKey:@"data"];
            }
        } else {
            self.code=@"-2";
            self.errMsg=@"数据解析失败";
        }
    }
    return self;
}


#pragma mark -属性
- (BOOL)success {
     if (([self.code length]>0&&[self.code isEqualToString:@"000"]) ) {
        return  YES;
     } else if ([self.errMsg isKindOfClass:[NSString class]]){
         if([self.errMsg isEqualToString:@"成功"]){
             return  YES;
         } else {
             return NO;
         }
     }
    return NO;
}

@end
