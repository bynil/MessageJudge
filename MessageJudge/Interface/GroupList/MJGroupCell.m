//
//  MJGroupCell.m
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJGroupCell.h"
#import "GlobalDefine.h"

@implementation MJGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)renderCellWithGroup:(MJConditionGroup *)group {
    self.textLabel.text = group.alias;
    self.detailTextLabel.text = [NSString stringWithFormat:MJLocalize(@"%ld conditions"), (long)group.conditions.count];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.textLabel.text = @"";
    self.detailTextLabel.text = @"";
}

@end
