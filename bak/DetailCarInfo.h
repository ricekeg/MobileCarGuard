//
//  DetailCarInfo.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailCarInfo : NSObject

#pragma mark 车辆品牌
@property (nonatomic,strong) NSString *vehicleBrand;

#pragma mark 车辆颜色
@property (nonatomic,strong) NSString *vehicleColor;

#pragma mark 车辆型号
@property (nonatomic,strong) NSString *vehicleModel;

-(instancetype)initWithBrand:(NSString *)brand andColor:(NSString *)color andModel:(NSString *)model;


@end
