//
//  LeftMenuViewController.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIView *headerView;
@property (nonatomic,strong) IBOutlet UIView *bottomView;

// headerView 相关
@property (weak, nonatomic) IBOutlet UILabel *carNum;
@property (weak, nonatomic) IBOutlet UILabel *carState;
@property (weak, nonatomic) IBOutlet UIImageView *carImage;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

// bottomView 相关
@property (weak, nonatomic) IBOutlet UIImageView *bottomBgImage;
@property (weak, nonatomic) IBOutlet UILabel *settingLabel;

// headerView 相关
-(IBAction)toggleCarDetail:(id)sender;
// bottomView 相关
-(IBAction)toggleCarSetting:(id)sender;

@end
