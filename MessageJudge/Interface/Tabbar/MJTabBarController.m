//
//  MJTabBarController.m
//  MessageJudge
//
//  Created by GeXiao on 09/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJTabBarController.h"
#import "MJGroupListViewController.h"
#import "GlobalDefine.h"
#import "MJJudgementRule.h"
#import "YYModel.h"

@interface MJTabBarController ()

@end

@implementation MJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MJGroupListViewController *whiteListViewController = [[MJGroupListViewController alloc] initWithListType:MJGroupListTypeWhiteList];
    MJGroupListViewController *blackListViewController = [[MJGroupListViewController alloc] initWithListType:MJGroupListTypeBlackList];
    
    UINavigationController *whiteListNav = [[UINavigationController alloc] initWithRootViewController:whiteListViewController];
    whiteListNav.tabBarItem.title = MJLocalize(@"Whitelist");
    whiteListNav.tabBarItem.image = [UIImage imageNamed:@"whitelist-tab"];
    
    UINavigationController *blackListNav = [[UINavigationController alloc] initWithRootViewController:blackListViewController];
    blackListNav.tabBarItem.title = MJLocalize(@"Blacklist");
    blackListNav.tabBarItem.image = [UIImage imageNamed:@"blacklist-tab"];
    
    UIViewController *menuViewController = [UITableViewController new];
    UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    menuViewController.tabBarItem.title = MJLocalize(@"Menu");
    menuViewController.tabBarItem.image = [UIImage imageNamed:@"menu-tab"];
    self.viewControllers = @[whiteListNav, blackListNav, menuNav];
}

@end
