//
//  Public.h
//  MobileCarGuard
//
//  Created by 曾智敏 on 15/8/7.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#ifndef MobileCarGuard_Public_h
#define MobileCarGuard_Public_h

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define navigationBarColor RGB(33, 192, 174)
#define separaterColor RGB(200, 199, 204)


// 3.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 4.屏幕大小尺寸
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//重新设定view的Y值
#define setFrameY(view, newY) view.frame = CGRectMake(view.frame.origin.x, newY, view.frame.size.width, view.frame.size.height)
#define setFrameX(view, newX) view.frame = CGRectMake(newX, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
#define setFrameH(view, newH) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newH)


//取view的坐标及长宽
#define W(view)    view.frame.size.width
#define H(view)    view.frame.size.height
#define X(view)    view.frame.origin.x
#define Y(view)    view.frame.origin.y

//5.常用对象
#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

//6.经纬度
#define LATITUDE_DEFAULT 26.107283
#define LONGITUDE_DEFAULT 119.223217

//7.
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//8.常用颜色
#define TableCOLOR [UIColor colorWithRed:27.0/255.0 green:30.0/255.0 blue:37.0/255.0 alpha:1.0]
#define FontCOLOR [UIColor colorWithRed:177.0/255.0 green:174.0/255.0 blue:172.0/255.0 alpha:1.0]
#define CellCOLOR [UIColor clearColor]//colorWithRed:60.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]
#define CURRENT_SYSTEM_COLOR [UIColor colorWithRed:52.0/255.0 green:170.0/255.0 blue:220.0/255.0 alpha:1.0]

#endif
