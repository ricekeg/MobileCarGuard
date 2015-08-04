//
//  DetailCarInfo.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "DetailCarInfo.h"

@implementation DetailCarInfo

-(instancetype)initWithBrand:(NSString *)brand andColor:(NSString *)color andModel:(NSString *)model
{
    self = [self init];
    if(self)
    {
        self.vehicleBrand = brand;
        self.vehicleColor = color;
        self.vehicleModel = model;
    }
    return self;
}

@end
