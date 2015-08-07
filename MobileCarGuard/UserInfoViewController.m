//
//  UserInfoViewController.m
//  多个Section的tableView
//  MobileCarGuard
//
//  Created by 曾智敏 on 15/7/9.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "UserInfoViewController.h"

//由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";

@interface UserInfoViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, copy) NSArray *functions;

@end

@implementation UserInfoViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.tabBarItem.title =@"我";
        self.tabBarItem.image =[UIImage imageNamed:@"Setting"];
         
        self.title =@"我";
    }
    return  self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
}

#pragma mark 加载数据
-(void)initData
{
    NSMutableArray *allFunctions = [[NSMutableArray alloc] initWithCapacity:2];
        
    NSMutableArray *loginGroup = [[NSMutableArray alloc] initWithArray:@[@"登录"]];
    [allFunctions addObject:loginGroup];
    
    NSMutableArray *sysGroup = [[NSMutableArray alloc] initWithArray:@[@"关于我们",@"软件评分",@"推荐给朋友"]];
    [allFunctions addObject:sysGroup];
    
    self.functions = allFunctions;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return _functions.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    NSMutableArray *group1=_functions[section];
    return group1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    //NSIndexPath是一个对象，记录了组和行信息
//    NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    NSMutableArray *group=_functions[indexPath.section];
    NSString *funcName=group[indexPath.row];
    
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font =[UIFont fontWithName:@"Helvetica" size:12.0];
        
    }
    
    cell.textLabel.text=funcName;
    return cell;
}


@end
