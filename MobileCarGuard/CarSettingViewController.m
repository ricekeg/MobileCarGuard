//
//  CarSettingViewController.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/28.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "CarSettingViewController.h"

@interface CarSettingViewController ()
{
    XHCarInfo *_currentCar;
}
@end

@implementation CarSettingViewController

-(instancetype)initWithCar:(XHCarInfo *)car
{
    self =[super init];
    if (self) {
        _currentCar = car;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
