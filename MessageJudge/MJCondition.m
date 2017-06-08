//
//  MJCondition.m
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJCondition.h"

@implementation MJCondition

- (BOOL)isMatchedForContent:(NSString *)content {
    if (content.length < 1) {
        return NO;
    }
    BOOL result = NO;
    switch (self.conditionType) {
        case MJConditionTypeHasPrefix:
            result = [content hasPrefix:self.keyword];
            break;
        case MJConditionTypeHasSuffix:
            result = [content hasSuffix:self.keyword];
            break;
        case MJConditionTypeContains:
            result = [content containsString:self.keyword];
            break;
        case MJConditionTypeNotContains:
            result = ![content containsString:self.keyword];
            break;
        case MJConditionTypeContainsRegex:
            result = [content rangeOfString:self.keyword options:NSRegularExpressionSearch].location != NSNotFound;
            break;
        default:
            break;
    }
    return result;
}

@end
