//
//  CSHomeTimeLineViewCell.h
//  carshop
//
//  Created by 刘金凯 on 2017/12/20.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSHomeTimeLineModel.h"

@protocol CSHomeTimeLineDelegate<NSObject>
- (void)shareActionWithModel:(CSHomeTimeLineModel *)model;
@end

@interface CSHomeTimeLineViewCell : UITableViewCell

@property (nonatomic,strong) CSHomeTimeLineModel *model;
@property (nonatomic,assign) id<CSHomeTimeLineDelegate>delegate;
@end



@interface ImagesContainerView : UIView


@property(nonatomic,strong) NSMutableArray *imagesAry;


@end

