//
//  CarDetailViewController.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHCarInfo.h"

@interface CarDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

-(instancetype)initWithCar:(XHCarInfo *)car;
  
@end
