//
//  AppDelegate.m
//  MobileCarGuard
//
//  Created by 曾智敏 on 15/7/9.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "AppDelegate.h"
#import "Public.h"
#import "LocationViewController.h"
#import "TrackViewController.h"
#import "UserInfoViewController.h"
#import "LeftMenuViewController.h"
#import "SlideNavigationController.h"
#import "SlideTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"9RgMtGSAptjYx4WncyInbvaS"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"map manager start failed!");
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LocationViewController *lvc = [[LocationViewController alloc] init];
//    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:lvc];
    
    TrackViewController *tvc = [[TrackViewController alloc] init];
    UserInfoViewController *userVC =[[UserInfoViewController alloc] init];
    UINavigationController *navUser = [[UINavigationController alloc] initWithRootViewController:userVC];

    SlideTabBarController *tabBarController = [[SlideTabBarController alloc] init];
    tabBarController.viewControllers = @[lvc,tvc,navUser];
    
    SlideNavigationController *nav =[[SlideNavigationController alloc] initWithRootViewController:tabBarController];
    
    LeftMenuViewController *leftMenu =[[LeftMenuViewController alloc] init];
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    
    //定制导航栏的背景色和前景色
    [[UINavigationBar appearance] setBarTintColor:CURRENT_SYSTEM_COLOR];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    
    self.window.rootViewController = nav;
    
    self.window.backgroundColor =[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:YES];
    }
}

@end
