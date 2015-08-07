//
//  UserZoneViewController.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/27.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "UserZoneViewController.h"
#import "Public.h"

@interface UserZoneViewController ()

@end

@implementation UserZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义区域";
    
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
    coordinate.latitude = LATITUDE_DEFAULT;         //纬度
    coordinate.longitude = LONGITUDE_DEFAULT;      //经度
    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.5,0.5));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    //显示指南针
    //[_mapView setCompassPosition:CGPointMake(10,50)];
    
    [self.view addSubview:_mapView];
    
    // 添加多边形覆盖物
    CLLocationCoordinate2D coords[4] = {0};
    coords[0].latitude = 26.107;
    coords[0].longitude = 119.423;
    coords[1].latitude = 26.107;
    coords[1].longitude = 119.203;
    coords[2].latitude = 26.217;
    coords[2].longitude = 119.313;
    coords[3].latitude = 26.217;
    coords[3].longitude = 119.463;
    BMKPolygon* polygon = [BMKPolygon polygonWithCoordinates:coords count:4];
    
    [_mapView addOverlay:polygon];
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

// Override
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolygon class]]){
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth = 5.0;
        
        return polygonView;
    }
    return nil;
}

@end
