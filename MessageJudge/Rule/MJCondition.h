//
//  MJCondition.h
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJQueryRequest.h"

typedef NS_ENUM(NSInteger, MJConditionTarget) {
    MJConditionTargetSender = 0,
    MJConditionTargetContent,
    MJConditionTargetCount
};

typedef NS_ENUM(NSInteger, MJConditionType) {
    MJConditionTypeHasPrefix = 0,
    MJConditionTypeHasSuffix,
    MJConditionTypeContains,
    MJConditionTypeNotContains,
    MJConditionTypeContainsRegex,
    MJConditionTypeCount
};

@interface MJCondition : NSObject

@property (nonatomic, assign) MJConditionTarget conditionTarget;
@property (nonatomic, assign) MJConditionType conditionType;
@property (nonatomic, copy) NSString *keyword;

- (BOOL)isMatchedForRequest:(MJQueryRequest *)request;

@end
