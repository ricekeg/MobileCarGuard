//
//  DeviceInfo.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject

#pragma mark 车牌号
@property (nonatomic,strong) NSString *carNum;
#pragma mark 设备号
@property (nonatomic,strong) NSString *deviceID;
#pragma mark 入网时间
@property (nonatomic,strong) NSDate *seviceBeginTime;
#pragma mark 到期时间
@property (nonatomic,strong) NSDate *seviceEndTime;
#pragma mark 服务状态
@property (nonatomic,strong) NSString *serviceState;

-(instancetype)initWithCarNum:(NSString *)carNum andDeviceID:(NSString *)deviceID andSvrBeginTime:(NSDate *)dateBegin andSvrEndTime:(NSDate *)dateEnd andSvrState:(NSString *)svrState;

@end
