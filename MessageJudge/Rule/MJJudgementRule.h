//
//  MJJudgementRule.h
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJConditionGroup.h"

#define MJGlobalRule [MJJudgementRule globalRule]

// MJExtentsionAppGroupName must be same with your App Group's name
// (Project -> Compabilities -> App Groups)
static NSString *MJExtentsionAppGroupName = @"group.me.gexiao.messagejudge";
static NSString *MJExtentsionRuleKey = @"MJExtentsionRuleKey";

@interface MJJudgementRule : NSObject

@property (nonatomic, strong) NSMutableArray<MJConditionGroup *> *whiteConditionGroupList;
@property (nonatomic, strong) NSMutableArray<MJConditionGroup *> *blackConditionGroupList;

+ (instancetype)globalRule;
+ (void)regenerateShareInstance;

- (BOOL)isUnwantedMessageForSystemQueryRequest:(ILMessageFilterQueryRequest *)systemRequest;
- (BOOL)save;

- (BOOL)backupRuleToIcloud;
- (BOOL)syncRuleFromIcloud;

@end
