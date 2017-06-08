//
//  MJJudgementRule.h
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJConditionGroup.h"

@interface MJJudgementRule : NSObject

@property (nonatomic, strong) NSMutableArray<MJConditionGroup *> *whiteConditionGroupList;
@property (nonatomic, strong) NSMutableArray<MJConditionGroup *> *blackConditionGroupList;

- (BOOL)isUnwantedMessageForContent:(NSString *)content;

@end
