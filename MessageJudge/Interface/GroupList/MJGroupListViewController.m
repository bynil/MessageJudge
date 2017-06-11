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
    [self.tableView registerClass:MJGroupCell.class forCellReuseIdentifier:MJGroupCellReuseIdentifier];
    switch (self.type) {
        case MJGroupListTypeWhiteList:
            self.title = MJLocalize(@"Whitelist Groups");
            break;
        case MJGroupListTypeBlackList:
            self.title = MJLocalize(@"Blacklist Groups");
            break;
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
