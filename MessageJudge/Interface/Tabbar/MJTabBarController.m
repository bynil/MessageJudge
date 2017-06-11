//
//  MJTabBarController.m
//  MessageJudge
//
//  Created by GeXiao on 09/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJTabBarController.h"
#import "MJGroupListViewController.h"

@interface MJTabBarController ()

@end

@implementation MJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    MJGroupListViewController *whiteListViewController = [[MJGroupListViewController alloc] initWithListType:MJGroupListTypeWhiteList];
    MJGroupListViewController *blackListViewController = [[MJGroupListViewController alloc] initWithListType:MJGroupListTypeBlackList];
    
    UINavigationController *whiteListNav = [[UINavigationController alloc] initWithRootViewController:whiteListViewController];
    whiteListNav.tabBarItem.title = @"Whitelist";
    whiteListNav.tabBarItem.image = [UIImage imageNamed:@"whitelist-tab"];
    
    UINavigationController *blackListNav = [[UINavigationController alloc] initWithRootViewController:blackListViewController];
    blackListNav.tabBarItem.title = @"Blacklist";
    blackListNav.tabBarItem.image = [UIImage imageNamed:@"blacklist-tab"];
    
    UIViewController *menuViewController = [UITableViewController new];
    UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    menuViewController.tabBarItem.title = @"Menu";
    menuViewController.tabBarItem.image = [UIImage imageNamed:@"menu-tab"];
    self.viewControllers = @[whiteListNav, blackListNav, menuNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
