//
//  CarInfo.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "CarInfo.h"

@implementation CarInfo

-(instancetype)initWithDeviceInfo:(DeviceInfo *)device andOwner:(OwnerInfo *)owner andDetail:(DetailCarInfo *)detail{
    self =[super init];
    if(self)
    {
        self.deviceInfo = device;
        self.ownerInfo = owner;
        self.detailInfo = detail;
    }
    return self;
}


@end
