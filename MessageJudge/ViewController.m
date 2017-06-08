//
//  ViewController.m
//  MessageJudge
//
//  Created by GeXiao on 08/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "ViewController.h"
#import "MJJudgementRule.h"
#import "YYModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MJCondition *condition = [MJCondition new];
    condition.keyword = @"屏蔽";
    condition.conditionType = MJConditionTypeHasPrefix;
    
    MJConditionGroup *blackGroup = [MJConditionGroup new];
    blackGroup.conditions = [@[condition] mutableCopy];
    
    MJJudgementRule *rule = [MJJudgementRule new];
    rule.blackConditionGroupList = [@[blackGroup] mutableCopy];
    
    NSUserDefaults *extDefaults = [[NSUserDefaults alloc] initWithSuiteName:MJExtentsionAppGroupName];
    //[extDefaults removeObjectForKey:MJExtentsionRuleKey];
    NSString *ruleString = [extDefaults objectForKey:MJExtentsionRuleKey];
    ruleString = [rule yy_modelToJSONString];
    if (ruleString) {
        [extDefaults setObject:ruleString forKey:MJExtentsionRuleKey];
    }
    rule = [MJJudgementRule yy_modelWithJSON:ruleString];
    BOOL result = [rule isUnwantedMessageForContent:@"屏蔽短信"];
    NSLog(result ? @"屏蔽" : @"不屏蔽");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
