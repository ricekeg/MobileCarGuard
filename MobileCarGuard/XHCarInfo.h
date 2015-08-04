//
//  XHCarInfo.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/21.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface XHCarInfo : NSManagedObject

// 车牌号
@property (nonatomic, copy) NSString * carId;
// sim卡号
@property (nonatomic, copy) NSString * simNum;
// 速度
@property (nonatomic, assign) double speed;
// 方向
@property (nonatomic, assign) double direct;
// 里程
@property (nonatomic, assign) double distanceDiff;
// gps时间
@property (nonatomic, copy) NSDate * gpsTime;

// 是否有gps信号
@property (nonatomic, assign) BOOL hasGpsSingnal;
// 是否有acc
@property (nonatomic, assign) BOOL isAcc;
// 是否重车
@property (nonatomic, assign) BOOL isTranSport;
// 车牌号
@property (nonatomic, copy) NSString * carNum;
// 地址
@property (nonatomic, copy) NSString * address;
// 报警信息
@property (nonatomic, copy) NSString * warningMessages;
// 车主姓名
@property (nonatomic, copy) NSString * ownerName;
// 是否离线
@property (nonatomic, assign) BOOL isOnline;
// 真实纬度
@property (nonatomic, assign) double latitude;
// 真实经度
@property (nonatomic, assign) double longtitude;

// 轨迹类型
@property (nonatomic, retain) NSManagedObject *linetype;
// 图标类型
@property (nonatomic, retain) NSManagedObject *icontype;

@end
