//
//  TrackViewController.m
//  MobileCarGuard
//
//  Created by 曾智敏 on 15/7/9.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "TrackViewController.h"
#import "NSDate+TCUtils.h"


#define CURRENT_SYSTEM_COLOR [UIColor colorWithRed:52.0/255.0 green:170.0/255.0 blue:220.0/255.0 alpha:1.0]

@interface TrackViewController ()
{
    NSDate *_selectDate;
    NSDate *_startDateTime;
    NSDate *_endDateTime;
}
@end

@implementation TrackViewController

#pragma mark -初始化

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.tabBarItem.title =@"历史轨迹";
        self.tabBarItem.image =[UIImage imageNamed:@"Track"];
        
        _startDateTime =[NSDate date];
        _endDateTime =[NSDate date];
        _selectDate =[NSDate date];
        [self refreshDateLabel];
        [self refreshStartTime];
        [self refreshEndTime];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buttonQuery.backgroundColor = CURRENT_SYSTEM_COLOR;
    _buttonQuery.titleLabel.textColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 设置起止时间，然后开始查询轨迹

- (IBAction)endTrackSetting:(id)sender {
   
}

- (IBAction)selectStartTime:(id)sender {
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeTime selectedDate:_startDateTime target:self action:@selector(dateWasSelected:element:) origin:sender];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSCalendarUnitDay amount:-1]];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)selectEndTime:(id)sender {
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeTime selectedDate:_endDateTime target:self action:@selector(dateWasSelected:element:) origin:sender];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSCalendarUnitDay amount:-1]];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)selectDate:(id)sender {
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:_endDateTime target:self action:@selector(dateWasSelected:element:) origin:sender];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSCalendarUnitDay amount:-1]];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
    
}

- (IBAction)selectYesterday:(id)sender {
    _selectDate = [_selectDate dateByAddingTimeInterval:3600*24*-1];
    [self refreshDateLabel];
}

- (IBAction)selectTomorrow:(id)sender {
    _selectDate = [_selectDate dateByAddingTimeInterval:3600*24];
    [self refreshDateLabel];
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    UIButton *button = (UIButton *)element;
    
    if(button.tag ==0)
    {
        _startDateTime = selectedDate;
        [self refreshStartTime];
    }
    else if(button.tag ==1)
    {
        _endDateTime = selectedDate;
        [self refreshEndTime];
    }
    else if(button.tag ==2)
    {
        _selectDate = selectedDate;
        [self refreshDateLabel];
    }
}

-(void)refreshDateLabel
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.labelDate.text =[dateFormatter stringFromDate:_selectDate];
}

-(void)refreshStartTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    self.startTime.text =[dateFormatter stringFromDate:_startDateTime];
}

-(void)refreshEndTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    self.endTime.text =[dateFormatter stringFromDate:_endDateTime];
}
@end
