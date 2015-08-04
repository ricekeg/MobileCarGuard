//
//  OwnerInfo.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OwnerInfo : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *telephone;
@property (nonatomic,strong) NSString *address;

-(instancetype)initWithName:(NSString *)name andWithTele:(NSString *)tele andWithAddress:(NSString *)address;

@end
