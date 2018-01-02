//
//  uploadFileModel.m
//  WaDaoServiceDemo
//
//  Created by wulanzhou on 16/6/15.
//  Copyright © 2016年 wulanzhou. All rights reserved.
//

#import "uploadFileModel.h"

@implementation uploadFileModel

- (id)init{

    if (self=[super init]) {
        
        self.mimeType=@"image/png";

    }
    return self;
}


/**
 *  初始化
 *
 *  @param path 本地图片路径
 *
 *  @return
 */
- (id)initFileImageWithPath:(NSString *)path{

    self = [super init];
    if (self) {
        
        //取得图片数据
        self.imageData=[NSData dataWithContentsOfFile:path];
        //取得文件名
        self.fileName=[path lastPathComponent];
        self.mimeType=@"image/png";

    }
    
    return self;
}

@end
