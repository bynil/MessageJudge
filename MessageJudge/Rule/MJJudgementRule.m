//
//  MJJudgementRule.m
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJJudgementRule.h"

@implementation MJJudgementRule

- (BOOL)isUnwantedMessageForContent:(NSString *)content {
    // White list has higher priority
    if (self.whiteConditionGroupList) {
        for (MJConditionGroup *conditionGroup in self.whiteConditionGroupList) {
            if ([conditionGroup isMatchedForContent:content]) {
                return NO;
            }
        }
    }
    if (self.blackConditionGroupList) {
        for (MJConditionGroup *conditionGroup in self.blackConditionGroupList) {
            if ([conditionGroup isMatchedForContent:content]) {
                return YES;
            }
        }
    }
    return NO;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"whiteConditionGroupList" : [MJConditionGroup class],
             @"blackConditionGroupList" : [MJConditionGroup class]
             };
}

@end
