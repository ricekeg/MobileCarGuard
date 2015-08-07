//
//  LeftMenuViewController.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "Public.h"
#import "CarDetailViewController.h"
#import "SlideNavigationController.h"
#import "BatteryViewController.h"
#import "UserZoneViewController.h"
#import "CityZoneViewController.h"
#import "AreaAlarmStateViewController.h"
#import "VSensorSettingViewController.h"
#import "CarSettingViewController.h"


static NSString *kheader = @"menuSectionHeader";
static NSString *ksubSection = @"menuSubSection";

@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_sections;
    NSArray *_arrImage;
    NSInteger _selectSection;
    
    XHCarInfo *_currentCar;
}
@end

@implementation LeftMenuViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nil bundle:nil])) {
        
        self.title = @"菜单";
        self.view.backgroundColor = TableCOLOR;
        
        [self initDataSource]; 
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 140, 310,SCREEN_HEIGHT-189) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = TableCOLOR;
    _tableView.showsVerticalScrollIndicator = NO;
    //不要分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIView *header = self.headerView;
    self.carNum.text = @"闽A00001";
    self.carNum.textColor = [UIColor whiteColor];
    self.carState.textColor = [UIColor whiteColor];
    self.carImage.image = [UIImage imageNamed:@"normalCar"];
    
    UIView *bottom = self.bottomView;
    bottom.frame = CGRectMake(0, SCREEN_HEIGHT-49, 260, 49);
    bottom.backgroundColor =[UIColor clearColor];

    [self.view addSubview:header];
    [self.view addSubview:_tableView];
    [self.view addSubview:bottom];
    
}

-(void)initDataSource
{
    _arrImage = [NSArray arrayWithObjects:@"Area", @"VSensor",@"Battery",@"CarSetting", nil];
    
    NSArray *sucSectionsA = @[@"区域报警", @"自定义区域",@"行政区域",@"当前状态"];
    NSArray *sucSectionsB = @[@"震动报警", @"灵敏度设置",@"频率设置"];
    NSArray *sucSectionsC = @[@"终端电量"];

    NSMutableDictionary *sectionA = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"NO",@"state",
                              sucSectionsA, ksubSection,
                              nil];
    NSMutableDictionary *sectionB = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"NO",@"state",
                              sucSectionsB, ksubSection,
                              nil];
    NSMutableDictionary *sectionC = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"NO",@"state",
                              sucSectionsC, ksubSection,
                              nil];
 
    _sections = @[sectionA,sectionB,sectionC];//,sectionD
    _selectSection = 4;
   
}

-(UIView *)headerView
{
    if(!_headerView){ 
        // 加载xib文件
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                                       owner:self
                                                     options:nil];
        
        _headerView = array[0];
    }
    return _headerView;
}

-(UIView *)bottomView
{
    if(!_bottomView){
        // 加载xib文件
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BottomView"
                                                       owner:self
                                                     options:nil];
        
        _bottomView = array[0];
    }
    return _bottomView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark----tableViewDelegate
//返回几个表头
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

//每一个表头下返回几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([[_sections objectAtIndex:section][@"state"] boolValue])
    {
        //未折叠 就返回项目个数
        return [[_sections objectAtIndex:section][ksubSection] count];
    }
    else{
        //如果折叠 就返回1
        return 1;
    }
}

//设置CELL的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 52;
    }
    else
        return 40;
}

//设置cell的背景色
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if(indexPath.row ==0){
        [cell setBackgroundColor:TableCOLOR];
    }else{
        [cell setBackgroundColor:CellCOLOR];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font =[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        cell.textLabel.textColor =FontCOLOR;
    }
    NSArray *subMenu = [_sections objectAtIndex:indexPath.section][ksubSection];
    cell.textLabel.text =[subMenu objectAtIndex:indexPath.row];
    if(indexPath.row == 0)
    {
        cell.imageView.image = [UIImage imageNamed:[_arrImage objectAtIndex:indexPath.section]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        cell.imageView.image =nil; //[UIImage imageNamed:@"Nothing"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    return cell;
}

//设置缩进级别
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
    {
        return 0;
    }
    return 4;
}


// 响应select 点击函数，根据哪个section，哪个row 自己做出响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc ;
    if(indexPath.row ==0)
    {
        if([[_sections objectAtIndex:indexPath.section][@"state"] boolValue]){
            [[_sections objectAtIndex:indexPath.section] setObject:@"NO" forKey:@"state"];
        }else{
            [[_sections objectAtIndex:indexPath.section] setObject:@"YES" forKey:@"state"];
        }
      
        if(indexPath.section == 2)
        {
            //显示 电池电量
            vc = [[BatteryViewController alloc] init];
        }
        else
        {
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
   
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 1:
                //显示 自定义区域
                vc = [[UserZoneViewController alloc] init];
                break;
            case 2:
                //显示 行政区域
                vc = [[CityZoneViewController alloc] init];
                break;
            case 3:
                //显示 当前状态
                vc = [[AreaAlarmStateViewController alloc] init];
                break;
            default:
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 1:
                //显示 灵敏度设置
                vc = [[VSensorSettingViewController alloc] initWithSegmentIndex:0 andCarID:_currentCar.carId];
                break;
            case 2:
                //显示 报警规则
                vc = [[VSensorSettingViewController alloc] initWithSegmentIndex:1 andCarID:_currentCar.carId];
                break;
            default:
                break;
        }
    }
    if(vc)
    {
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:YES
                                                                         andCompletion:nil];
    }
}

-(IBAction)toggleCarDetail:(id)sender
{
    CarDetailViewController *carDetail = [[CarDetailViewController alloc] initWithCar:_currentCar];
    // 跳转到车辆详情
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:carDetail
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
}

- (IBAction)toggleCarSetting:(id)sender {
    // 跳转到车辆设置
    CarSettingViewController *carSetting = [[CarSettingViewController alloc] initWithCar:_currentCar];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:carSetting
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
}
@end
