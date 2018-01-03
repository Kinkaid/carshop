//
//  CSHomeViewController.m
//  carshop
//
//  Created by 刘金凯 on 2017/11/8.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSHomeTimeLineViewCell.h"
#import "CSHomeTimeLineModel.h"
#import "TSShareHelper.h"
#import "CSEditTimeLineViewController.h"
static NSString * const kCSHomeTimeLineViewCellIdentifier = @"CSHomeTimeLineViewCell";
@interface CSHomeViewController ()<UITableViewDelegate,UITableViewDataSource,CSHomeTimeLineDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataAry;
@end

@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialNavigationBar];
    [self registerTableView];
    [self loadData];
}
- (void)initialNavigationBar {
   [self setTitle:@"相册动态"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"相机" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setNavigationBarItem:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(0);
    }];
    [btn addTarget:self action:@selector(editTimeLineAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)editTimeLineAction:(UIButton *)sender {
    CSEditTimeLineViewController *vc = [[CSEditTimeLineViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)registerTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CSHomeTimeLineViewCell class] forCellReuseIdentifier:kCSHomeTimeLineViewCellIdentifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navigationBar.mas_bottom).offset(0);
        make.bottom.mas_equalTo(0);
    }];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_WIDTH *0.618)];
    [self.tableView setTableHeaderView:headerView];
    headerView.backgroundColor = [UIColor redColor];
    UIImageView *headerImg = [[UIImageView alloc] init];
    [headerView addSubview:headerImg];
    headerImg.clipsToBounds = YES;
    headerImg.layer.cornerRadius = 50;
    headerImg.image = [UIImage imageNamed:@"icon_header"];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    UILabel *nickLabel = [[UILabel alloc] init];
    [headerView addSubview:nickLabel];
    nickLabel.text = @"八级大狂风";
    nickLabel.textColor = [UIColor whiteColor];
    nickLabel.textAlignment = NSTextAlignmentRight;
    [nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerImg.mas_left).with.offset(-20);
        make.centerY.mas_equalTo(headerImg.mas_centerY);
    }];
}
- (void)loadData {
    self.dataAry = [@[] mutableCopy];
    for (int i =0; i<9; i++) {
        NSString *picUrl = @"http://q.qlogo.cn/qqapp/1106276139/D1A908A09FE81C02D31FD0EA242397F5/100";
        NSMutableArray *picMary = [@[] mutableCopy];
        for (int j=0; j<i+1; j++) {
            if (j!=0) {
            [picMary addObject:picUrl];
            }
            
        }
        CSHomeTimeLineModel *model = [[CSHomeTimeLineModel alloc] init];
        model.avatar = @"http://q.qlogo.cn/qqapp/1106276139/D1A908A09FE81C02D31FD0EA242397F5/100";
        model.nickName = @"方块";
        model.releaseTime = @"一天前";
        model.releaseContent = @"今天去拍照了，请看我的九宫格，漂亮的简直不要不要不要不要的";
        model.imagesAry = picMary;
        [self.dataAry addObject:model];
    }
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataAry.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0||section == 3||section == 5||section == 6) {
        return 9;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor whiteColor];
    return footer;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSHomeTimeLineViewCell *cell= [tableView dequeueReusableCellWithIdentifier:kCSHomeTimeLineViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataAry[indexPath.section];
    cell.delegate = self;
    return cell;
}
#pragma mark -- CSHomeTimeLineDelegate
- (void)shareActionWithModel:(CSHomeTimeLineModel *)model {
    NSMutableArray *imgAry = [@[] mutableCopy];
    [imgAry addObject:@"我是分享的内容"];
//    for (int i=0; i<model.imagesAry.count; i++) {
//        [imgAry addObject:[UIImage imageNamed:@"icon_header"]];
//    }

    [self shareFriendWithImgAry:imgAry andContent:model.releaseContent];
}
-(void)shareFriendWithImgAry:(NSArray *)shareImgAry andContent:(NSString *)content{
    
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = content;
//    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:shareImgAry applicationActivities:nil];
//    //去除多余的分享模块
//    activityViewController.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeOpenInIBooks];
//    UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError)
//    {
//        if (completed) {
//            NSLog(@"分享成功");
//            pasteboard.string = @"";
//        }
//    };
//    activityViewController.completionWithItemsHandler = myBlock;
//    if (activityViewController) {
//        [self presentViewController:activityViewController animated:TRUE completion:^{
//        }];
//    }
    UIImage *img = [UIImage imageNamed:@"icon_header.png"];
    UIImage *img1 = [UIImage imageNamed:@"icon_mine"];
    [TSShareHelper shareWithType:0 andController:self andItems:@[img,img1]];
}
@end
