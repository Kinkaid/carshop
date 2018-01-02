//
//  CSHomeTimeLineModel.h
//  carshop
//
//  Created by 刘金凯 on 2017/12/24.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CSHomeTimeLineModel : MTLModel

@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *releaseTime;
@property (nonatomic,copy) NSString *releaseContent;
@property (nonatomic,copy) NSArray *imagesAry;

@end
