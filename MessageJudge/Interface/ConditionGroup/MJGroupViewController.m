//
//  MJGroupViewController.m
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJGroupViewController.h"
#import "MJConditionGroup.h"
#import "MJConditionCell.h"
#import "MJConditionViewController.h"
#import "MJJudgementRule.h"

@interface MJGroupViewController ()

@property (nonatomic, strong) MJConditionGroup *conditionGroup;

@end

@implementation MJGroupViewController

- (instancetype)initWithConditionGroup:(MJConditionGroup *)group {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _conditionGroup = group;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = self.conditionGroup.alias;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewCondition)];
    [self.tableView registerClass:MJConditionCell.class forCellReuseIdentifier:MJConditionCellReuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Action
- (void)addNewCondition {
    MJCondition *newCondition = [MJCondition new];
    newCondition.conditionTarget = MJConditionTargetContent;
    newCondition.conditionType = MJConditionTypeContains;
    [self.conditionGroup.conditions addObject:newCondition];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.conditionGroup.conditions.count-1 inSection:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    [self tableView:self.tableView didSelectRowAtIndexPath:newIndexPath];
    [MJGlobalRule save];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conditionGroup.conditions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:MJConditionCellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row < self.conditionGroup.conditions.count) {
        [cell renderCellWithCondition:self.conditionGroup.conditions[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];\
    if (indexPath.row < self.conditionGroup.conditions.count) {
        MJCondition *condition = self.conditionGroup.conditions[indexPath.row];
        MJConditionViewController *controller = [[MJConditionViewController alloc] initWithCondition:condition];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.conditionGroup.conditions removeObjectAtIndex:indexPath.row];
        [MJGlobalRule save];
    }
}

@end
