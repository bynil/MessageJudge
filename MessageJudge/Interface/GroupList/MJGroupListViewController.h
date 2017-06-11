//
//  MJGroupListViewController.h
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MJGroupListType) {
    MJGroupListTypeWhiteList = 0,
    MJGroupListTypeBlackList,
};

@class MJConditionGroup;

@interface MJGroupListViewController : UITableViewController

@property (nonatomic, assign) MJGroupListType type;
@property (nonatomic, strong, readonly) NSMutableArray<MJConditionGroup *> *groupList;

- (instancetype)initWithListType:(MJGroupListType)type;

@end
