//
//  UserZoneViewController.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/27.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

@interface UserZoneViewController : UIViewController<BMKMapViewDelegate>

@property (strong,nonatomic) BMKMapView* mapView;

@end
