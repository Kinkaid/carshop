//
//  HttpManager.h
//  CoolFlow
//
//  Created by wulanzhou on 16/6/3.
//  Copyright © 2016年 wulanzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpResponse.h"
#import "HttpServerArgs.h"
#import "uploadFileModel.h"

@interface HttpManager : NSObject

+ (HttpManager *)shareInstance;

/**
 *  http请求
 *
 *  @param httpWay    请求方式(get或post)
 *  @param method     请求的方法名
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param args       args(有参数)
 */

- (void)requestWithHttpWayType:(SCHttpWay)httpWay
                    methodName:(NSString *)method
                    parameters:(NSDictionary *) parameters
                          args:(BOOL)args   //args 不能为空
                       success:(void(^)(HttpResponse *response)) success;


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
                         success:(void(^)(HttpResponse *response)) success;

/**
 *  单文件上传(默认为post请求)
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
                              success:(void(^)(HttpResponse *response)) success;

- (void)apiRequestWithHttpArgs:(HttpServerArgs *)args
                     params:(NSDictionary *)params
                     arg:(BOOL)arg
                    success:(void(^)(HttpResponse *response)) success;

@end
