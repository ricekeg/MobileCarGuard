//
//  LocationViewController.m
//  MobileCarGuard
//
//  Created by 曾智敏 on 15/7/9.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()


@end

@implementation LocationViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.tabBarItem.title =@"当前位置";
        self.tabBarItem.image =[UIImage imageNamed:@"Location"];
        //self.tabBarItem.badgeValue=@"123";

        
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    coordinate.latitude = 26.107283;         //纬度
    coordinate.longitude = 119.223217;      //经度
    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.3, 0.3));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    //显示指南针
    //[_mapView setCompassPosition:CGPointMake(10,50)];
    
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void) viewDidAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 26.107;         //纬度
    coor.longitude = 119.223;      //经度
    annotation.coordinate = coor;
    annotation.title = @"闽A12345";
    [_mapView addAnnotation:annotation];
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

//if (annotation != nil) {
//    [_mapView removeAnnotation:annotation];
//}

@end
