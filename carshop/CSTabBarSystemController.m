//
//  CSTabBarSystemController.m
//  carshop
//
//  Created by 刘金凯 on 2017/11/8.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import "CSTabBarSystemController.h"
#import "CSHomeViewController.h"
#import "CSContactViewController.h"
#import "CSPlatformViewController.h"
#import "CSMineViewController.h"
#import "UIColor+CSColor.h"
#import "CSImage.h"
#import "CSBaseNavigationController.h"
@interface CSTabBarSystemController ()

@end

@implementation CSTabBarSystemController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customerTabBar];
}

- (void)customerTabBar {
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor ex_colorFromHexRGB:@"F6F6F6"];
    [self.tabBar insertSubview:bgView atIndex:0];
    
    CSHomeViewController *vc1 = [[CSHomeViewController alloc] init];
    UINavigationController *nav1 = [[CSBaseNavigationController alloc]initWithRootViewController:vc1];
    vc1.tabBarItem.title = @"相册动态";
    [vc1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor ex_colorFromHexRGB:@"44A7FB"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    vc1.tabBarItem.selectedImage = [CSImage imageNameWithOriginalMode:[NSString stringWithFormat:@"home_tab_icon1_selec"]];
    vc1.tabBarItem.image = [CSImage imageNameWithOriginalMode:[NSString stringWithFormat:@"home_tab_icon1"]];
    [self addChildViewController:nav1];
    
    CSContactViewController *vc2 = [[CSContactViewController alloc] init];
    UINavigationController *nav2 = [[CSBaseNavigationController alloc]initWithRootViewController:vc2];
    vc2.tabBarItem.title = @"已关注";
    [vc2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor ex_colorFromHexRGB:@"44A7FB"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    vc2.tabBarItem.selectedImage = [CSImage imageNameWithOriginalMode:[NSString stringWithFormat:@"home_tab_icon1_selec"]];
    vc2.tabBarItem.image = [CSImage imageNameWithOriginalMode:[NSString stringWithFormat:@"home_tab_icon1"]];
    [self addChildViewController:nav2];
    
    CSPlatformViewController *vc3 = [[CSPlatformViewController alloc] init];
    UINavigationController *nav3 = [[CSBaseNavigationController alloc]initWithRootViewController:vc3];
    vc3.tabBarItem.title = @"商品";
    [vc3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor ex_colorFromHexRGB:@"44A7FB"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    vc3.tabBarItem.selectedImage = [CSImage imageNameWithOriginalMode:[NSString stringWithFormat:@"home_tab_icon1_selec"]];
    vc3.tabBarItem.image = [CSImage imageNameWithOriginalMode:[NSString stringWithFormat:@"home_tab_icon1"]];
    [self addChildViewController:nav3];
    
    CSMineViewController *vc4 = [[CSMineViewController alloc] init];
    UINavigationController *nav4 = [[CSBaseNavigationController alloc]initWithRootViewController:vc4];
    vc4.tabBarItem.title = @"我";
    [vc4.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor ex_colorFromHexRGB:@"44A7FB"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    vc4.tabBarItem.selectedImage = [CSImage imageNameWithOriginalMode:[NSString stringWithFormat:@"home_tab_icon1_selec"]];
    vc4.tabBarItem.image = [CSImage imageNameWithOriginalMode:[NSString stringWithFormat:@"home_tab_icon1"]];
    [self addChildViewController:nav4];
}

@end
