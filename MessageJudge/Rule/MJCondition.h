//
//  MJCondition.h
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MJConditionType) {
    MJConditionTypeHasPrefix = 1,
    MJConditionTypeHasSuffix,
    MJConditionTypeContains,
    MJConditionTypeNotContains,
    MJConditionTypeContainsRegex,
};

@interface MJCondition : NSObject

@property (nonatomic, assign) MJConditionType conditionType;
@property (nonatomic, copy) NSString *keyword;

- (BOOL)isMatchedForContent:(NSString *)content;

@end
