//
//  UserZoneViewController.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/27.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "UserZoneViewController.h"

@interface UserZoneViewController ()

@end

@implementation UserZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义区域";
    
    
    CGFloat SCREEN_HEIGHT = [UIScreen mainScreen].bounds.size.height;
    CGFloat SCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _mapView = mapView;
    //可以缩放
    _mapView.zoomEnabled = YES;
    //可以拖拉
    _mapView.scrollEnabled = YES;
    //显示比例尺
    _mapView.showMapScaleBar = YES;
    //自定义比例尺的位置
    _mapView.mapScaleBarPosition = CGPointMake(_mapView.frame.size.width - 70, _mapView.frame.size.height - 100);
    
    _mapView.mapType = BMKMapTypeStandard;
    
    CLLocationCoordinate2D coordinate;                  //设定经纬度
    coordinate.latitude = 39.027283;         //纬度
    coordinate.longitude = 110.313217;      //经度
    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(1.0, 1.0));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    //显示指南针
    //[_mapView setCompassPosition:CGPointMake(10,50)];
    
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

@end
