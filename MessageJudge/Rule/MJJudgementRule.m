//
//  MJJudgementRule.m
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJJudgementRule.h"

@implementation MJJudgementRule

- (BOOL)isUnwantedMessageForSystemQueryRequest:(ILMessageFilterQueryRequest *)systemRequest {
    MJQueryRequest *request = [[MJQueryRequest alloc] initWithSystemQueryRequest:systemRequest];
    
    // White list has higher priority
    if (self.whiteConditionGroupList) {
        for (MJConditionGroup *conditionGroup in self.whiteConditionGroupList) {
            if ([conditionGroup isMatchedForRequest:request]) {
                return NO;
            }
        }
    }
    if (self.blackConditionGroupList) {
        for (MJConditionGroup *conditionGroup in self.blackConditionGroupList) {
            if ([conditionGroup isMatchedForRequest:request]) {
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
