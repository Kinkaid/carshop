//
//  CSBaseViewController.m
//  carshop
//
//  Created by 刘金凯 on 2017/11/8.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import "CSBaseViewController.h"
@interface CSBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL firstDisplay;

@end

@implementation CSBaseViewController

#pragma mark - Accessor

- (UIView *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, KIsiPhoneX?88:64)];
        _navigationBar.backgroundColor = [UIColor ex_colorFromHexRGB:@"FFFFFF"];
        [self.view addSubview:_navigationBar];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, KIsiPhoneX?87:63, APP_SCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor ex_colorFromHexRGB:@"E0E6ED"];
        [_navigationBar addSubview:lineView];
        [self.view bringSubviewToFront:_navigationBar];
    }
    return _navigationBar;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor ex_colorFromHexRGB:@"FFF"];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [self.navigationBar addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"black_back_icon"] forState:UIControlStateNormal];
        [_backButton setTitle:@"  " forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickBackButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationBar addSubview:_backButton];
    }
    return _backButton;
}
#pragma mark - Life Cycle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = bgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor ex_colorFromHexRGB:@"44A7FB"]];
    self.navigationController.navigationBar.tintColor = [UIColor ex_colorFromHexRGB:@"FFFFFF"];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = YES;
    self.firstDisplay = YES;
    [self customNavgationBar];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isVisible = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isVisible = NO;
    self.firstDisplay = NO;
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

- (void)customNavgationBar {
    if (self.navigationController.viewControllers.count == 1) {
        self.backButton.hidden = YES;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.backButton.hidden = NO;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navigationBar);
        make.bottom.equalTo(self.navigationBar).with.offset(-14);
        make.size.mas_equalTo(CGSizeMake(APP_SCREEN_WIDTH - 120, 16));
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationBar);
        make.bottom.equalTo(self.navigationBar).with.offset(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
    }];
    
}
- (void)isHiddenBackButton:(BOOL)isHidden {
    self.backButton.hidden = isHidden;
}
- (void)setNavigationBarColor:(UIColor *)color {
    self.navigationBar.backgroundColor = color;
}
- (void)clickBackButtonAction {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
- (void)setTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color {
    self.titleLabel.text = title;
    self.titleLabel.font = font;
    self.titleLabel.textColor = color;
}
- (void)setNavigationBarItem:(UIView *)itemView {
    [self.navigationBar addSubview:itemView];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
@end
