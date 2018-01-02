//
//  CSContactViewController.m
//  carshop
//
//  Created by 刘金凯 on 2017/11/8.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import "CSContactViewController.h"
#import "WSCContactsViewCell.h"
static NSString *const kCellIdentifier = @"WSCContactsViewCell";
@interface CSContactViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation CSContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerTableView];
}
- (void)registerTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor ex_colorFromHexRGB:@"F1EFF4"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    [self.tableView registerClass:[WSCContactsViewCell class] forCellReuseIdentifier:kCellIdentifier];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSCContactsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
@end
