//
//  MJGroupListViewController.m
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJGroupListViewController.h"
#import "MJGroupCell.h"
#import "MJGroupViewController.h"
#import "GlobalDefine.h"
#import "MJJudgementRule.h"

@interface MJGroupListViewController ()

@end

@implementation MJGroupListViewController

- (instancetype)initWithListType:(MJGroupListType)type {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSMutableArray<MJConditionGroup *> *)groupList {
    switch (self.type) {
        case MJGroupListTypeWhiteList:
            return MJGlobalRule.whiteConditionGroupList;
            break;
        case MJGroupListTypeBlackList:
            return MJGlobalRule.blackConditionGroupList;
            break;
        default:
            return MJGlobalRule.blackConditionGroupList;
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewConditionGroup)];
    [self.tableView registerClass:MJGroupCell.class forCellReuseIdentifier:MJGroupCellReuseIdentifier];
    switch (self.type) {
        case MJGroupListTypeWhiteList:
            self.title = MJLocalize(@"Whitelist Groups");
            break;
        case MJGroupListTypeBlackList:
            self.title = MJLocalize(@"Blacklist Groups");
            break;
    }
}

#pragma mark - Action

- (void)addNewConditionGroup {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:MJLocalize(@"New Group") message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:MJLocalize(@"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *groupAlias = alert.textFields[0].text;
        MJConditionGroup *newGroup = [MJConditionGroup new];
        newGroup.alias = groupAlias;
        [self.groupList addObject:newGroup];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.groupList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [MJGlobalRule save];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:MJLocalize(@"Cancel") style:UIAlertActionStyleCancel
                                                         handler:nil]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = MJLocalize(@"Group Alias (Optional)");
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:MJGroupCellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row < self.groupList.count) {
        [cell renderCellWithGroup:self.groupList[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.groupList.count) {
        MJConditionGroup *group = self.groupList[indexPath.row];
        MJGroupViewController *groupViewController = [[MJGroupViewController alloc] initWithConditionGroup:group];
        [self.navigationController pushViewController:groupViewController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.groupList removeObjectAtIndex:indexPath.row];
        [MJGlobalRule save];
    }
}

@end
