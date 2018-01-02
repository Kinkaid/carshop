//
//  WDApplicationUtil.m
//  wadaoduobao
//
//  Created by 刘金凯 on 16/9/9.
//  Copyright © 2016年 iju. All rights reserved.
//

#import "WDApplicationUtil.h"
#import "MBProgressHUD.h"
@implementation WDApplicationUtil


+ (WDApplicationUtil*)sharedInstance{
    static WDApplicationUtil *singleton=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton=[[self alloc]init];
    });
    return singleton;
}


+ (void)alertHud:(NSString *)text afterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.label.text =[NSString stringWithFormat:@"%@",text];
    hud.label.numberOfLines = 0;
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:delay];
}


@end
