//
//  MJGroupCell.h
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJConditionGroup.h"

static NSString *MJGroupCellReuseIdentifier = @"MJGroupCellReuseIdentifier";

@interface MJGroupCell : UITableViewCell

- (void)renderCellWithGroup:(MJConditionGroup *)group;

@end
