//
//  MJConditionGroup.h
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJCondition.h"

@interface MJConditionGroup : NSObject

@property (nonatomic, strong) NSMutableArray<MJCondition *> *conditions;

- (BOOL)isMatchedForRequest:(MJQueryRequest *)request;

@end
