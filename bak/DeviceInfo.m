//
//  DeviceInfo.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo

-(instancetype)initWithCarNum:(NSString *)carNum andDeviceID:(NSString *)deviceID andSvrBeginTime:(NSDate *)dateBegin andSvrEndTime:(NSDate *)dateEnd andSvrState:(NSString *)svrState
{
    self =[self init];
    if(self)
    {
        self.carNum = carNum;
        self.deviceID = deviceID;
        self.seviceBeginTime = dateBegin;
        self.seviceEndTime = dateEnd;
        self.serviceState = svrState;
    }
    return self;
}

@end
