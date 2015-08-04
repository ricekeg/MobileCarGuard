//
//  CarInfo.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"
#import "OwnerInfo.h"
#import "DetailCarInfo.h"

@interface CarInfo : NSObject

#pragma mark 设备信息
@property (nonatomic,strong) DeviceInfo *deviceInfo;
#pragma mark 车主信息
@property (nonatomic,strong) OwnerInfo *ownerInfo;
#pragma mark 车辆详情
@property (nonatomic,strong) DetailCarInfo *detailInfo;

#pragma mark 带参数的构造函数
-(instancetype)initWithDeviceInfo:(DeviceInfo *)device andOwner:(OwnerInfo *)owner andDetail:(DetailCarInfo *)detail;

@end
