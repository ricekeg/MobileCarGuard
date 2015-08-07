//
//  VSensorSettingViewController.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/27.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//
#import "VSensorSettingViewController.h" 
#import "Public.h"

@interface VSensorSettingViewController ()

@end

@implementation VSensorSettingViewController

-(instancetype)initWithSegmentIndex:(NSInteger)segmentIndex andCarID:(NSString *)carID
{
    self = [super init];
    if(self)
    {
        self.navigationItem.title = @"震动报警";
        
        //设置默认选择项索引
        self.segmentedControl.selectedSegmentIndex = segmentIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //分段控件的颜色，只有样式为UISegmentedControlStyleBar的时候才有效果
    self.segmentedControl.tintColor = CURRENT_SYSTEM_COLOR;
    
    //设置指定索引的题目
    [self.segmentedControl setTitle:@"灵敏度设置" forSegmentAtIndex:0];
    [self.segmentedControl setTitle:@"频率设置" forSegmentAtIndex:1];
    [self.segmentedControl addTarget:self
                             action:@selector(segmentAction:)
                   forControlEvents:UIControlEventValueChanged];
    
    UIView *settingView =  self.settingSensorView;
    settingView.frame = CGRectMake(0, 120, 320, 480);
    [self.view addSubview:settingView];
    
    settingView =  self.settingTimesView;
    settingView.frame = CGRectMake(0, 120, 320, 480);
    [self.view addSubview:settingView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)segmentAction:(UISegmentedControl *)Seg
{
    switch (Seg.selectedSegmentIndex) {
        case 0:
            [self.view bringSubviewToFront:_settingSensorView];
            break;
        case 1:
            [self.view bringSubviewToFront:_settingTimesView];
            break;
    }
  
}

-(UIView *)settingSensorView
{
    if(!_settingSensorView){
        // 加载xib文件
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"subSettingSensorView"
                                                       owner:self
                                                     options:nil];
        
        _settingSensorView = array[0];
    }
    return _settingSensorView;
}

-(UIView *)settingTimesView
{
    if(!_settingTimesView){
        // 加载xib文件
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"subSettingTimesView"
                                                       owner:self
                                                     options:nil];
        
        _settingTimesView = array[0];
    }
    return _settingTimesView;
}

#pragma -mark 灵敏度设置
- (IBAction)sensorSliderValueChanged:(id)sender {
}

- (IBAction)sensorDoneTouched:(id)sender {
}

- (IBAction)sensorDefaultTouched:(id)sender {
}

#pragma -mark 频率设置

- (IBAction)timesSliderValueChanged:(id)sender {
}

- (IBAction)timesDoneTouched:(id)sender {
}

- (IBAction)timesDefaultTouched:(id)sender {
    
    self.timesSlider.value=(int)((UISlider *)sender).value;
    self.timesLabel.text=[NSString stringWithFormat:@"%d",(int)_timesSlider.value];
}

@end
