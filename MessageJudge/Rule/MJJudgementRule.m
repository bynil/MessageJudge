//
//  MJJudgementRule.m
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJJudgementRule.h"
#import "YYModel.h"

@implementation MJJudgementRule

+ (instancetype)globalRule {
    static MJJudgementRule *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSUserDefaults *extDefaults = [[NSUserDefaults alloc] initWithSuiteName:MJExtentsionAppGroupName];
        NSString *ruleString = [extDefaults objectForKey:MJExtentsionRuleKey];
        sharedInstance = [MJJudgementRule yy_modelWithJSON:ruleString];
        if (!sharedInstance) {
            sharedInstance = [self new];
        }
    });
    return sharedInstance;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"whiteConditionGroupList" : [MJConditionGroup class],
             @"blackConditionGroupList" : [MJConditionGroup class]
             };
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _whiteConditionGroupList = [@[] mutableCopy];
        _blackConditionGroupList = [@[] mutableCopy];
    }
    return self;
}

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

- (BOOL)save {
    NSUserDefaults *extDefaults = [[NSUserDefaults alloc] initWithSuiteName:MJExtentsionAppGroupName];
    NSString *ruleString = [extDefaults objectForKey:MJExtentsionRuleKey];
    ruleString = [self yy_modelToJSONString];
    if (ruleString) {
        [extDefaults setObject:ruleString forKey:MJExtentsionRuleKey];
    }
    return ruleString != nil;
}

@end
