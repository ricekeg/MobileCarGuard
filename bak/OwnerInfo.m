//
//  OwnerInfo.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "OwnerInfo.h"

@implementation OwnerInfo

-(instancetype)initWithName:(NSString *)name andWithTele:(NSString *)tele andWithAddress:(NSString *)address
{
    self=[self init];
    if(self)
    {
        self.name = name;
        self.telephone = tele;
        self.address = address;
    }
    return self;
}

@end
