//
//  CarDetailViewController.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/14.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "CarDetailViewController.h"

@interface CarDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) XHCarInfo *currentCar;

@end

@implementation CarDetailViewController

#pragma mark - Initializer

-(instancetype)initWithCar:(XHCarInfo *)car
{
    self =[super init];
    if(self)
    {
        self.title =@"车辆详情";
        _currentCar =  car;
    }
    return  self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped]; 
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }

@end
