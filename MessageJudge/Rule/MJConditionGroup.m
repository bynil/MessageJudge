//
//  MJConditionGroup.m
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJConditionGroup.h"

@implementation MJConditionGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        _conditions = [@[] mutableCopy];
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"conditions" : [MJCondition class]};
}

- (BOOL)isMatchedForRequest:(MJQueryRequest *)request {
    if (self.conditions) {
        for (MJCondition *condition in self.conditions) {
            if (![condition isMatchedForRequest:request]) {
                return NO;
            }
        }
    }
    return YES;
}
@end
