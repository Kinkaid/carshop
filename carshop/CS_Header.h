//
//  CS_Header.h
//  carshop
//
//  Created by 刘金凯 on 2017/11/8.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#ifndef CS_Header_h
#define CS_Header_h

#define APP_SCREEN_WIDTH    ([[UIScreen mainScreen]bounds].size.width)
#define APP_SCREEN_HEIGHT   ([[UIScreen mainScreen]bounds].size.height)
#define ISEMPTY(x)	(((x) == nil ||[(x) isKindOfClass:[NSNull class]] ||([(x) isKindOfClass:[NSString class]] &&  ([(NSString*)(x) length] == 0 ||[(NSString*)(x) isEqualToString:@"(null)"])) || ([(x) isKindOfClass:[NSArray class]] && [(NSArray*)(x) count] == 0))|| ([(x) isKindOfClass:[NSDictionary class]] && [(NSDictionary*)(x) count] == 0))
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define bgColor  [UIColor ex_colorFromHexRGB:@"F4F8FA"]
#endif /* CS_Header_h */
