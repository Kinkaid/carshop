//
//  uploadFileModel.h
//  WaDaoServiceDemo
//
//  Created by wulanzhou on 16/6/15.
//  Copyright © 2016年 wulanzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface uploadFileModel : NSObject

/**
 *  图片Data
 */
@property (nonatomic,strong) NSData   *imageData;

/**
 *  上传的文件名
 */
@property (nonatomic,strong) NSString *fileName;

/**
 * 图片参数名
 */
@property (nonatomic,strong) NSString *name;

/**
 *  图片类别(默认值为image/png)
 */
@property (nonatomic,strong) NSString *mimeType;

/**
 *  初始化
 *
 *  @param path 本地图片路径
 *
 *  @return
 */
- (id)initFileImageWithPath:(NSString *)path;

@end
