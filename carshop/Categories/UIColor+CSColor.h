//
//  UIColor+CSColor.h
//  carshop
//
//  Created by 刘金凯 on 2017/11/8.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CSColor)

+ (UIColor *)ex_colorFromHexRGB:(NSString *)inColorString;

+ (UIColor *)ex_colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)ex_colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

+ (UIColor *)ex_colorFromInt:(NSInteger)intValue;

- (BOOL)ex_isEqualToColor:(UIColor *)color;

@end
