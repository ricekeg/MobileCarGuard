//
//  CarListViewController.m
//  带搜索功能的车辆列表
//  MobileCarGuard
//
//  Created by 曾智敏 on 15/7/9.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//

#import "CarListViewController.h"
#import "CarDetailViewController.h"

static NSString * const SearchCarCell = @"SearchCarCell";


@interface CarListViewController ()

@property(nonatomic, copy) NSArray *allCars;
@property(nonatomic, copy) NSArray *filteredCars;

@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation CarListViewController

#pragma mark - Initializer

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nil bundle:nil])) {
        
        self.title = @"选择车辆";
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AllCars" ofType:@"plist"];
        NSMutableDictionary *carList = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        //NSLog(@"%@",path);
        _allCars =[carList allValues];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (animated) {
        [self.tableView flashScrollIndicators];
    }
}

- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated
{
    [self.tableView scrollRectToVisible:self.searchController.searchBar.frame animated:animated];
}

#pragma mark - TableView Delegate and DataSource

//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchController.active) {
        return [self.filteredCars count];
    }else{
        return [self.allCars count];
    }
    
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SearchCarCell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchCarCell];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        
        cell.textLabel.font =[UIFont fontWithName:@"Helvetica" size:12.0];
    }
    if (self.searchController.active) {
        [cell.textLabel setText:self.filteredCars[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.allCars[indexPath.row]];
    }
    return cell;
}

//选择cell后返回
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectCar = @"";
    if (self.searchController.active) {
        selectCar = self.filteredCars[indexPath.row];
    }
    else{
        selectCar = self.allCars[indexPath.row];
    }
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:selectCar
                                                         forKey:@"currentCar"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisterCompletionNotification"
                                                        object:nil
                                                      userInfo:dataDict];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    return;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"reaching accessoryButtonTappedForRowWithIndexPath:");

    CarDetailViewController *carDetail = [[CarDetailViewController alloc] init];
    [self.navigationController pushViewController:carDetail animated:YES];
}

#pragma mark - Search Delegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    //过滤数据
    self.filteredCars= [NSMutableArray arrayWithArray:[self.allCars filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}

@end
