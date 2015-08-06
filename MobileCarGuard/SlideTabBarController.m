//
//  SlideTabBarController.m
//  MobileCarGuard
//
//  Created by tyz on 15/7/16.
//  Copyright (c) 2015年 郑旭. All rights reserved.
//


#define CURRENT_SYSTEM_COLOR [UIColor colorWithRed:52.0/255.0 green:170.0/255.0 blue:220.0/255.0 alpha:1.0]

#import "SlideTabBarController.h"

#import "CarListViewController.h"
#import "LeftMenuViewController.h"

@interface SlideTabBarController ()

@property (nonatomic,strong) NSString *selectCar;

- (IBAction)showMenu:(id)sender;
- (IBAction)searchCar:(id)sender;

@end

@implementation SlideTabBarController

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.view.tintColor = CURRENT_SYSTEM_COLOR;
        UINavigationItem *navItem = self.navigationItem;
        _selectCar = @"闽A12345";
        navItem.title = _selectCar;
        
        UIBarButtonItem *lbbi = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(showMenu:)];
        UIBarButtonItem *rbbi =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                             target:self
                                                                             action:@selector(searchCar:)];
        navItem.leftBarButtonItem = lbbi;
        navItem.rightBarButtonItem = rbbi;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerCompletion:)
                                                 name:@"RegisterCompletionNotification"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)registerCompletion:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    _selectCar = [theData objectForKey:@"currentCar"];
    
    self.navigationItem.title = _selectCar;
}


- (IBAction)showMenu:(id)sender {
    
    if ([[SlideNavigationController sharedInstance] isMenuOpen])
        [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
    else
        [[SlideNavigationController sharedInstance] openMenu:MenuLeft withCompletion:nil];
}

- (IBAction)searchCar:(id)sender {
    CarListViewController *carVC = [[CarListViewController alloc] init];
    [self.navigationController pushViewController:carVC animated:YES];
    
}


#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

-(BOOL)avoidSwitchingToSameClassViewController
{
    return NO;
}

#pragma mark - UITabBarController Methods -
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 0) {
        UIBarButtonItem *lbbi = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(showMenu:)];
        UIBarButtonItem *rbbi =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                             target:self
                                                                             action:@selector(searchCar:)];
        self.navigationItem.leftBarButtonItem = lbbi;
        self.navigationItem.rightBarButtonItem = rbbi;
        
        self.navigationItem.title = _selectCar;
    } else if (tabBarController.selectedIndex == 1) {
        self.navigationItem.title = @"轨迹回放";
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        
    } else if (tabBarController.selectedIndex == 2){
        self.navigationItem.title =@"我";
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
    }
}

@end
