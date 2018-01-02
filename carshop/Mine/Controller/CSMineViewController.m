//
//  CSMineViewController.m
//  carshop
//
//  Created by 刘金凯 on 2017/11/8.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import "CSMineViewController.h"
#import "CSMineViewCell.h"
static NSString *const kCellIdentifier = @"CSMineViewCell";
@interface CSMineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headerView;
@end

@implementation CSMineViewController
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 80)];
        _headerView.layer.borderWidth = 0.5;
        _headerView.layer.borderColor = [UIColor ex_colorFromHexRGB:@"D8D8D8"].CGColor;
        _headerView.backgroundColor = [UIColor whiteColor];
        UIImageView *headerImg = [[UIImageView alloc] init];
        headerImg.image = [UIImage imageNamed:@"icon_header"];
        [_headerView addSubview:headerImg];
        [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(60);
        }];
        headerImg.layer.cornerRadius = 30;
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = @"方块";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor ex_colorFromHexRGB:@"000000"];
        [_headerView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerImg.mas_right).offset(10);
            make.top.mas_equalTo(headerImg.mas_top).offset(10);
        }];
        UILabel *subTitle = [[UILabel alloc] init];
        subTitle.textColor = [UIColor ex_colorFromHexRGB:@"B9B9B9"];
        subTitle.text = @"相册网址：www.baidu.com";
        [_headerView addSubview:subTitle];
        subTitle.font = [UIFont systemFontOfSize:14];
        [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(headerImg.mas_bottom).offset(-10);
            make.left.mas_equalTo(nameLabel.mas_left);
        }];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.navigationBar.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerTableView];
}
- (void)registerTableView {
    [self.tableView setTableHeaderView:self.headerView];
    [self.tableView registerClass:[CSMineViewCell class] forCellReuseIdentifier:kCellIdentifier];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSMineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = bgColor;
    return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = bgColor;
    return footer;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
