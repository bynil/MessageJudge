//
//  MJConditionViewController.h
//  MessageJudge
//
//  Created by GeXiao on 12/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <XLForm/XLForm.h>

@class MJCondition;

@interface MJConditionViewController : XLFormViewController

@property (nonatomic, strong, readonly) MJCondition *condition;

- (instancetype)initWithCondition:(MJCondition *)condition;

@end
