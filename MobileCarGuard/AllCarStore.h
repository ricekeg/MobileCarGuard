//
//  AllCarStore.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/21.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XHCarInfo;

@interface AllCarStore : NSObject

+(instancetype)shareStore;

-(NSArray *)allIconType;
-(NSArray *)allLineType;

@end
