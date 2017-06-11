//
//  MJGroupViewController.h
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJConditionGroup;

@interface MJGroupViewController : UITableViewController

- (instancetype)initWithConditionGroup:(MJConditionGroup *)group;

@end
