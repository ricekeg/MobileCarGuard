//
//  VSensorSettingViewController.h
//  MobileCarGuard
//
//  Created by tyz on 15/7/27.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSensorSettingViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIView *settingSensorView;
@property (nonatomic,strong) IBOutlet UIView *settingTimesView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

//灵敏度设置
@property (weak, nonatomic) IBOutlet UISlider *sensorSlider;
@property (weak, nonatomic) IBOutlet UIButton *sensorDone;
@property (weak, nonatomic) IBOutlet UIButton *sensorDefault;

//频率设置
@property (weak, nonatomic) IBOutlet UISlider *timesSlider;
@property (weak, nonatomic) IBOutlet UIButton *timesDone;
@property (weak, nonatomic) IBOutlet UIButton *timesDefault;
@property (weak, nonatomic) IBOutlet UILabel *timesLabel;


-(instancetype)initWithSegmentIndex:(NSInteger)segmentIndex andCarID:(NSString *)carID;

//灵敏度设置
- (IBAction)sensorSliderValueChanged:(id)sender;
- (IBAction)sensorDoneTouched:(id)sender;
- (IBAction)sensorDefaultTouched:(id)sender;

//频率设置
- (IBAction)timesSliderValueChanged:(id)sender;
- (IBAction)timesDoneTouched:(id)sender;
- (IBAction)timesDefaultTouched:(id)sender;

@end
