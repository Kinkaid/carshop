//
//  CSEditTimeLineViewCell.h
//  carshop
//
//  Created by 刘金凯 on 2018/1/2.
//  Copyright © 2018年 刘金凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSEditTimeLineViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@end

@interface CSImagesContainerView : UIView


@property(nonatomic,strong) NSMutableArray *imagesAry;


@end

