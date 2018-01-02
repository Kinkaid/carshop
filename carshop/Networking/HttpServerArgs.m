//
//  HttpServerArgs.m
//  CoolFlow
//
//  Created by wulanzhou on 16/6/3.
//  Copyright © 2016年 wulanzhou. All rights reserved.
//

#import "HttpServerArgs.h"
#import "GlobalNetDefine.h"
#import "Md5Encrypt.h"


@interface HttpServerArgs (){
    NSMutableDictionary *_postDataDic;
    NSString *requestKey_;
}
@property (nonatomic,readonly) NSMutableDictionary *postDataDic;
@end

@implementation HttpServerArgs

@synthesize postDataDic = _postDataDic;

- (id)init {
    if (self=[super init]) {
        self.urlString = Server_url;
        self.httpWay = SCHW_Post;
        _postDataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

- (NSString *)requestURLString {
    return self.urlString;
}

- (NSString *)requestURLString_args {
    if (self.httpWay == SCHW_Get) {
        return self.urlString;
    }else if (self.httpWay == SCHW_Post){
        NSDictionary *dic = [self getRequestParams];
        NSMutableArray *params=[NSMutableArray arrayWithCapacity:0];
        //时间戳
        NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        //签名
        NSString *sign=[Md5Encrypt md5:[NSString stringWithFormat:@"%@%@%@%@",self.methodName,[self dataTojsonString:dic],timeStr,kServiceSignKey]];
        [params addObject:[NSString stringWithFormat:@"time=%@",timeStr]];
        [params addObject:[NSString stringWithFormat:@"sign=%@",sign]];
        [params addObject:[NSString stringWithFormat:@"method=%@",self.methodName]];
        SystemUser *mod=[SystemUser shareInstance];
        if (mod.isLogin) {
            [params addObject:[NSString stringWithFormat:@"id=%@",mod.userId]];
            [params addObject:[NSString stringWithFormat:@"access_token=%@",mod.access_token]];
        }
        NSString *str = [NSString stringWithFormat:@"args=%@",[self dataTojsonString:dic]];
       [params addObject:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        return [NSString stringWithFormat:@"%@?%@",self.urlString,[params componentsJoinedByString:@"&"]];
    }
    return self.urlString;
}

/**
 *  基于参数(data=)封装
 *
 *  @param firstObject 可变参数 key与value组成
 */
-(void)paramWithObjectsAndKeys:(NSString*)firstObject, ... NS_REQUIRES_NIL_TERMINATION{
    NSMutableArray *values=[NSMutableArray arrayWithCapacity:0];
    NSMutableArray *keys=[NSMutableArray arrayWithCapacity:0];
    NSInteger index=0;
    va_list args;
    va_start(args,firstObject);
    if(firstObject)
    {
        [values addObject:firstObject];
        index++;
        NSString *otherString;
        while((otherString=va_arg(args,NSString*)))
        {
            if (index%2==0){
                [values addObject:otherString];
            }else{
                //依次取得所有参数
                [keys addObject:otherString];
            }
            index++;
        }
    }
    va_end(args);
    
    NSAssert([values count]==[keys count], @"paramWithObjectsAndKeys方法设置的key与value不匹配!");
    
    if([keys count]>0&&[values count]>0)
    {
        for(NSInteger i=0;i<[values count];i++)
        {
            [self setParamValue:[values objectAtIndex:i] name:[keys objectAtIndex:i]];
        }
    }
}

/**
 *  一次性设置所有请求参数
 *
 *  @param params 请求参数 key与value组成
 */
-(void)addParamWithDictionary:(NSDictionary*)params{
    if(params && [params count]>0){
        [_postDataDic addEntriesFromDictionary:params];
    }
}


/**
 *  替换请求参数值
 *
 *  @param key   要替换的key
 *  @param value 要替换的值
 */
- (void)replaceParamWithKey:(NSString *)key paramValue:(id)value{
    if (key&&[key isKindOfClass:[NSString class]]) {
        [_postDataDic setValue:value forKey:key];
    }
}

/**
 *  基于参数(data=)封装
 *
 *  @param value 参数值
 *  @param key   参数名
 */
- (void)setParamValue:(NSString*)value name:(NSString*)key{
    [_postDataDic setValue:value forKey:key];
}

/**
 *  获取所有请求参数
 *
 *  @return
 */
- (NSDictionary *)getRequestParams {
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    if (self.httpWay==SCHW_Get) {
        NSString *argStr=[self dataTojsonString:_postDataDic];
        [dic setValue:argStr forKey:@"args"];
        [dic addEntriesFromDictionary:[self getDefaultParamWithArgs:argStr]];
        [dic setValue:self.methodName forKey:@"method"];
        SystemUser *mod=[SystemUser shareInstance];
        if (mod.isLogin) {
            [dic setValue:mod.userId forKey:@"id"];
            [dic setValue:mod.access_token forKey:@"access_token"];
        }
    } else if(self.httpWay==SCHW_Post){ //post请求
        return _postDataDic;
    }
    return dic;
}


#pragma mark -私有方法

/**
 *  url字符串编码处理
 *
 *  @return  url编码字符串
 */
- (NSString*)paramEncode:(NSString *)str {
    NSString *encodedString = ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)str,NULL,            (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return encodedString;
}

- (NSDictionary*)getDefaultParamWithArgs:(NSString *)dicStr{
    //时间戳
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    
    NSString *sign=[Md5Encrypt md5:[NSString stringWithFormat:@"%@%@%@%@",self.methodName,dicStr,timeStr,kServiceSignKey]];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:timeStr,@"time",sign,@"sign", nil];
}

-(NSString*)dataTojsonString:(id)object {
    NSString *jsonString = @"{}";
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
