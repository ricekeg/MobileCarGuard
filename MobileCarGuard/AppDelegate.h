//
//  AppDelegate.h
//  MobileCarGuard
//
//  Created by 曾智敏 on 15/7/9.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BMKMapManager* mapManager;

@end

