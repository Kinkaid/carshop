//
//  HttpManager.m
//  CoolFlow
//
//  Created by wulanzhou on 16/6/3.
//  Copyright © 2016年 wulanzhou. All rights reserved.
//

#import "HttpManager.h"
#import "AFNetworking.h"
#import "GlobalNetDefine.h"
#import "SystemUser.h"
#import "Md5Encrypt.h"
#import "WDApplicationUtil.h"
//#import "WDRequestTimeoutUtil.h"

@interface HttpManager()
@property (nonatomic, strong) AFHTTPSessionManager  *manager;
@property (nonatomic, strong) NSMutableArray        *arrayHttpArgs;
@end

@implementation HttpManager

+ (HttpManager *)shareInstance {
    static dispatch_once_t  onceToken;
    static HttpManager * _sharedInstance;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HttpManager alloc] init];
    });
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.arrayHttpArgs = [NSMutableArray array];
    }
    return self;
}

- (void)requestWithHttpWayType:(SCHttpWay)httpWay
                    methodName:(NSString *)method
                    parameters:(NSDictionary *)parameters
                    args:(BOOL)args
                    success:(void (^)(HttpResponse *))success {
    HttpServerArgs *arg=[[HttpServerArgs alloc] init];
    arg.methodName = method;
    arg.httpWay = httpWay;
    if (!ISEMPTY(parameters)) {
        [arg addParamWithDictionary:parameters];
    }
    [self requestWithHttpArgs:arg success:success arg:args];
}

- (void)requestWithHttpArgs:(HttpServerArgs *)args
                    success:(void(^)(HttpResponse *response)) success
                        arg:(BOOL)arg {
    args.requestFinishedBlock = success;
    //TOKEN NEED REFRESH
    if ([self isNeedRefreshWithArgs:args]) {
        return;
    }
    if(args){
        if (args.httpWay==SCHW_Get) {
            [self get:args.requestURLString parameters:[args getRequestParams] success:success];
        }else if (args.httpWay==SCHW_Post){
            [self post:args.requestURLString_args parameters:[args getRequestParams] success:success];
        }
    }
}


- (void)get:(NSString *) URLString
 parameters:(NSDictionary *) parameters
    success:(void(^)(HttpResponse *response)) success{
    self.manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.requestSerializer.timeoutInterval = 10.0f;
    [self.manager GET:URLString
           parameters:parameters
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSError *err=nil;
                  NSDictionary *resultDict;
                  if ([responseObject isKindOfClass:[NSDictionary class]]) {
                      resultDict = responseObject;
                  } else {
                      resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
                      if (err) {
                           NSLog(@"解析失败 原因=%@",err.description);
                      }
                  }
                  HttpResponse *model=[[HttpResponse alloc] initWithDictionary:resultDict];
                  if (success) {
                      success(model);
                  }
                  [SVProgressHUD dismiss];
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  HttpResponse *model=[[HttpResponse alloc] init];
                  model.code = [NSString stringWithFormat:@"%ld",(long)error.code];
                  model.errMsg = error.userInfo;
                  if ([model.code isEqualToString:@"-1001"]) {
//                      [WDRequestTimeoutUtil showRequestErrorView];
                  } else {
                      if ([model.errMsg isKindOfClass:[NSString class]]) {
                          [WDApplicationUtil alertHud:model.errMsg afterDelay:1];
                      }
                  }
                  success(model);
                  [SVProgressHUD dismiss];
               }];
}


- (void)post:(NSString *) URLString
  parameters:(NSDictionary *) parameters
     success:(void(^)(HttpResponse *response)) success {
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    self.manager.requestSerializer.timeoutInterval = 10.0f;
    [self.manager POST:URLString
            parameters:parameters
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if ([responseObject isKindOfClass:[NSData class]]) {
                       responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                   }
                   HttpResponse *model=[[HttpResponse alloc] initWithDictionary:responseObject];
                   [SVProgressHUD dismiss];
                   if (success) {
                       success(model);
                   }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   HttpResponse *model=[[HttpResponse alloc] init];
                   model.code = [NSString stringWithFormat:@"%ld",(long)error.code];
                   model.errMsg = error.userInfo;
                   success(model);
                   if ([model.code isEqualToString:@"-1001"]) {
//                      [WDRequestTimeoutUtil showRequestErrorView];
                   } else {
                       if ([model.errMsg isKindOfClass:[NSString class]]) {
                           [WDApplicationUtil alertHud:model.errMsg afterDelay:1];
                       }
                   }
                   [SVProgressHUD dismiss];
               }];
}

/**
 *  单文件上传(默认为post请求)
 *
 *  @param method       请求的方法名
 *  @param parameters   请求参数
 *  @param uploadFile   上传的图片对象数据
 *  @param progress     上传进度
 *  @param success      请求成功回调
 */
- (void)uploadFileWithMethodName:(NSString *)method
                      parameters:(NSDictionary *) parameters
                      uploadFile:(uploadFileModel *)uploadFile
                        progress:(void(^)(float progress))progress
                         success:(void(^)(HttpResponse *response)) success{
    HttpServerArgs *args= [[HttpServerArgs alloc] init];
    args.urlString = Server_url;
    args.methodName = method;
    if (!ISEMPTY(parameters)) {
        [args addParamWithDictionary:parameters];
    }
    args.requestFinishedBlock=success;
    //表示需要刷新token
    if ([self isNeedRefreshWithArgs:args]) {
        return;
    }
    if(args){
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSMutableDictionary *params= [NSMutableDictionary dictionaryWithCapacity:0];
        //时间戳
        NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        //签名
        NSString *sign=[Md5Encrypt md5:[NSString stringWithFormat:@"%@%@%@%@",method,@"\"{}\"",timeStr,kServiceSignKey]];
        [params setObject:timeStr forKey:@"time"];
        [params setObject:sign forKey:@"sign"];
        [params setObject:method forKey:@"method"];
        [params setObject:timeStr forKey:@"time"];
        SystemUser *mod=[SystemUser shareInstance];
        if (mod.isLogin) {
            [params setObject:mod.userId forKey:@"id"];
            [params setObject:mod.access_token forKey:@"access_token"];
        }
        
        [params setObject:[@"\"{}\"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"args"];
        NSURLSessionDataTask *task = [self.manager POST:args.requestURLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:uploadFile.imageData
                                        name:uploadFile.name
                                    fileName:uploadFile.fileName
                                    mimeType:uploadFile.mimeType];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress.fractionCompleted);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            HttpResponse *model=[[HttpResponse alloc] initWithDictionary:responseObject];
            if (success) {
                success(model);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            HttpResponse *model=[[HttpResponse alloc] initWithError:error];
            if (success) {
                success(model);
            }
            [SVProgressHUD dismiss];
        }];
        [task resume];
    }
}
- (void)apiRequestWithHttpArgs:(HttpServerArgs *)args
                        params:(NSDictionary *)params
                           arg:(BOOL)arg
                       success:(void(^)(HttpResponse *response)) success {
    if (!ISEMPTY(params)) {
        [args addParamWithDictionary:params];
    }
    [self requestWithHttpArgs:args success:success arg:arg];
}
/**
 *  多文件上传(默认为post请求)
 *
 *  @param method       请求的方法名
 *  @param parameters   请求参数
 *  @param uploadFiles  多文件图片对象
 *  @param progress     上传进度
 *  @param success      请求成功回调
 */
- (void)uploadMultFilesWithMethodName:(NSString *)method
                                 args:(BOOL )isArgs
                           parameters:(NSDictionary *) parameters
                          uploadFiles:(NSArray <uploadFileModel*> *)uploadFiles
                             progress:(void(^)(float progress))progress
                              success:(void(^)(HttpResponse *response)) success{
    HttpServerArgs *arg=[[HttpServerArgs alloc] init];
    arg.methodName=method;
    if (!ISEMPTY(parameters)) {
        [arg addParamWithDictionary:parameters];
    }
    arg.requestFinishedBlock=success;
    //表示需要刷新token
    if ([self isNeedRefreshWithArgs:arg]) {
        return;
    }
    if(arg) {
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                           @"text/html",
                           @"image/jpeg",
                           @"image/png",
                           @"application/octet-stream",
                           @"text/json",nil];
        NSMutableDictionary *params= [NSMutableDictionary dictionaryWithDictionary:parameters];
        //时间戳
        NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        //签名
        NSString *sign=[Md5Encrypt md5:[NSString stringWithFormat:@"%@%@%@%@",method,@"\"{}\"",timeStr,kServiceSignKey]];
        [params setObject:timeStr forKey:@"time"];
        [params setObject:sign forKey:@"sign"];
        [params setObject:method forKey:@"method"];
        SystemUser *mod=[SystemUser shareInstance];
        if (mod.isLogin) {
            [params setObject:mod.userId forKey:@"id"];
            [params setObject:mod.access_token forKey:@"access_token"];
        }
        [params setObject:[@"\"{}\"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"args"];
        self.manager = [AFHTTPSessionManager manager];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSURLSessionDataTask *task = [self.manager POST:arg.urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (uploadFileModel *item in uploadFiles) {
                [formData appendPartWithFileData:item.imageData
                                            name:item.name
                                        fileName:item.fileName
                                        mimeType:item.mimeType];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress.fractionCompleted);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            HttpResponse *model=[[HttpResponse alloc] initWithDictionary:resultDict];
            if (success) {
                success(model);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            HttpResponse *model=[[HttpResponse alloc] initWithError:error];
            if (success) {
                success(model);
            }
        }];
        [task resume];
    }
}


#pragma mark -私有方法
/**
 *  判断是否需要刷新token
 *
 *  @param args
 *
 *  @return  YES：表示需要  NO:表示不需要
 */
- (BOOL)isNeedRefreshWithArgs:(HttpServerArgs *)args {
    //表示已登录
    SystemUser *mod=[SystemUser shareInstance];
    if (mod.isLogin) {
         //判断请求token是否已过期
        if ([mod isExpiresAccessToken]) {
            [self.arrayHttpArgs addObject:args];
            //判断当前刷新token请求是否存在
            NSPredicate *per=[NSPredicate predicateWithFormat:@"SELF.methodName==%@",@"user/refresh_access_token"];
            NSArray *arr=[self.arrayHttpArgs filteredArrayUsingPredicate:per];
            if (arr && [arr count] > 0) {
                return YES;
            }
             NSLog(@"开始重新取得请求token");
            //重新获取token
            HttpServerArgs *httpArgs = [[HttpServerArgs alloc] init];
            httpArgs.urlString = LoginServer_url;
            httpArgs.methodName = @"user/refresh_access_token";
            httpArgs.httpWay = SCHW_Get;
            [httpArgs paramWithObjectsAndKeys:mod.userId,@"id",mod.refresh_token,@"refresh_token", nil];
            //添加
            [self.arrayHttpArgs addObject:httpArgs];
            [self get:httpArgs.urlString parameters:[httpArgs getRequestParams] success:^(HttpResponse *response) {
                 NSLog(@"重新取得请求token完成 =%@",response.responseData);
                //移除
                [self.arrayHttpArgs removeObject:httpArgs];
                if (response.success) { //请求成功
                    NSDictionary *dic=(NSDictionary *)response.responseData;
                    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
                    [mod saveExpiresDate:timeSp];
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    NSDictionary *info = [userDefault objectForKey:@"USER"];
                     NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
                    for (NSString *key in info) {
                        if ([key isEqualToString:@"access_token"]) {
                            [mutableDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"access_token"]] forKey:key];
                        }else{
                            [mutableDic setObject:[info objectForKey:key] forKey:key];
                        }
                    }
                    [userDefault setObject:mutableDic forKey:@"USER"];
                    [userDefault synchronize];
                    mod.access_token=[dic objectForKey:@"access_token"];
                    mod.expires_in=[NSString stringWithFormat:@"%@",[dic objectForKey:@"expires_in"]];//保存时间
                    //替换访问请求的token参数
                    for (HttpServerArgs *item in self.arrayHttpArgs) {
                        [item replaceParamWithKey:@"access_token" paramValue:mod.access_token];
                        if (item.httpWay==SCHW_Get) {
                            [self get:args.urlString parameters:[args getRequestParams] success:args.requestFinishedBlock];
                        } else if (item.httpWay==SCHW_Post){
                            [self post:args.requestURLString_args parameters:[args getRequestParams] success:args.requestFinishedBlock];
                        }
                    }
                    [self.arrayHttpArgs removeAllObjects];
                } else {
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:@"" forKey:@"USER"];
                    [userDefault synchronize];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTokenExpiresReLogin object:nil];;
                }
            }];
            return YES;
        }
    }
    return NO;
}

@end
