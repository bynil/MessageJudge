//
//  MJCondition.m
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJCondition.h"

@implementation MJCondition

- (BOOL)isMatchedForRequest:(MJQueryRequest *)request {
    NSString *target;
    switch (self.conditionTarget) {
        case MJConditionTargetSender:
            target = request.sender;
            break;
        case MJConditionTargetContent:
            target = request.messageBody;
            break;
        default:
            target = request.messageBody;
            break;
    }
    if (target.length < 1) {
        return NO;
    }
    BOOL result = NO;
    switch (self.conditionType) {
        case MJConditionTypeHasPrefix:
            result = [target hasPrefix:self.keyword];
            break;
        case MJConditionTypeHasSuffix:
            result = [target hasSuffix:self.keyword];
            break;
        case MJConditionTypeContains:
            result = [target containsString:self.keyword];
            break;
        case MJConditionTypeNotContains:
            result = ![target containsString:self.keyword];
            break;
        case MJConditionTypeContainsRegex:
            result = [target rangeOfString:self.keyword options:NSRegularExpressionSearch].location != NSNotFound;
            break;
        default:
            break;
    }
    return result;
}

@end
