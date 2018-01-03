//
//  CSEditTimeLineViewController.m
//  carshop
//
//  Created by 刘金凯 on 2018/1/2.
//  Copyright © 2018年 刘金凯. All rights reserved.
//

#import "CSEditTimeLineViewController.h"
#import "CSEditTimeLineViewCell.h"
static NSString *const kEditTimeLineViewCellIdentifier = @"CSEditTimeLineViewCell";
@interface CSEditTimeLineViewController ()<UITableViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation CSEditTimeLineViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = bgColor;
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
    [self.tableView registerClass:[CSEditTimeLineViewCell class] forCellReuseIdentifier:kEditTimeLineViewCellIdentifier];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSEditTimeLineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEditTimeLineViewCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tableView = self.tableView;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
@end
