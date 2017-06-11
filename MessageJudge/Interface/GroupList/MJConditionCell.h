//
//  MJConditionCell.h
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *MJConditionCellReuseIdentifier = @"MJConditionCellReuseIdentifier";

@class MJCondition;

@interface MJConditionCell : UITableViewCell

- (void)renderCellWithCondition:(MJCondition *)condition;

@end
