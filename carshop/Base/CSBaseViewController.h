//
//  CSBaseViewController.h
//  carshop
//
//  Created by 刘金凯 on 2017/11/8.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSBaseViewController : UIViewController
@property (nonatomic, readonly) BOOL firstDisplay;
@property (nonatomic,strong)UIView *navigationBar;
@property (nonatomic,strong)UIButton *backButton;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, assign)BOOL isVisible;

- (void)isHiddenBackButton:(BOOL)isHidden;
- (void)setNavigationBarColor:(UIColor *)color;
- (void)clickBackButtonAction;
- (void)setTitle:(NSString *)title;
- (void)setTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;
- (void)setNavigationBarItem:(UIView *)itemView;


@end
