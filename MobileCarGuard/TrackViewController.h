//
//  TrackViewController.h
//  MobileCarGuard
//
//  Created by 曾智敏 on 15/7/9.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreActionSheetPicker/ActionSheetPicker.h>

@class AbstractActionSheetPicker;

@interface TrackViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelStartTime;
@property (weak, nonatomic) IBOutlet UILabel *labelEndTime;
@property (weak, nonatomic) IBOutlet UIButton *buttonQuery;

@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;

@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;

- (IBAction)endTrackSetting:(id)sender;

- (IBAction)selectStartTime:(id)sender;
- (IBAction)selectEndTime:(id)sender;
- (IBAction)selectDate:(id)sender;
- (IBAction)selectYesterday:(id)sender;
- (IBAction)selectTomorrow:(id)sender;

@end
