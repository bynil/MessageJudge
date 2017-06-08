//
//  MessageJudgeTests.m
//  MessageJudgeTests
//
//  Created by GeXiao on 09/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MJJudgementRule.h"

@interface MessageJudgeTests : XCTestCase

@end

@implementation MessageJudgeTests

- (void)testConditionValidity {
//    MJConditionTypeHasPrefix = 1,
//    MJConditionTypeHasSuffix,
//    MJConditionTypeContains,
//    MJConditionTypeNotContains,
//    MJConditionTypeContainsRegex,
    MJCondition *prefixCondition = [MJCondition new];
    prefixCondition.keyword = @"a special prefix";
    prefixCondition.conditionType = MJConditionTypeHasPrefix;
    
    XCTAssertTrue([prefixCondition isMatchedForContent:@"a special prefix with xxx"], @"prefix true test");
    XCTAssertFalse([prefixCondition isMatchedForContent:@"xxx a special prefix with xxx"], @"prefix false test");
    
    MJCondition *suffixCondition = [MJCondition new];
    suffixCondition.keyword = @"a tiresome suffix";
    suffixCondition.conditionType = MJConditionTypeHasSuffix;
    
    XCTAssertTrue([suffixCondition isMatchedForContent:@"xxx with a tiresome suffix"], @"suffix true test");
    XCTAssertFalse([suffixCondition isMatchedForContent:@"a tiresome suffix ?"], @"suffix false test");
    
    MJCondition *containCondition = [MJCondition new];
    containCondition.keyword = @"nothing";
    containCondition.conditionType = MJConditionTypeContains;
    
    XCTAssertTrue([containCondition isMatchedForContent:@"xxx nothing yyy zzz"], @"contain true test");
    XCTAssertFalse([containCondition isMatchedForContent:@"xxx with a tiresome suffix"], @"contain false test");
    
    MJCondition *notContainCondition = [MJCondition new];
    notContainCondition.keyword = @"girlfriend";
    notContainCondition.conditionType = MJConditionTypeNotContains;
    
    XCTAssertTrue([notContainCondition isMatchedForContent:@"I am a single dog"], @"notcontain true test");
    XCTAssertFalse([notContainCondition isMatchedForContent:@"girlfriend is not nessasory"], @"notcontain true test");
    
    MJCondition *regexCondition1 = [MJCondition new];
    regexCondition1.keyword = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?"; // URL
    regexCondition1.conditionType = MJConditionTypeContainsRegex;
    
    XCTAssertTrue([regexCondition1 isMatchedForContent:@"http://www.google.com/news"], @"regex1 true test");
    XCTAssertFalse([regexCondition1 isMatchedForContent:@"www.twitter.com"], @"regex1 false test");
    
    MJCondition *regexCondition2 = [MJCondition new];
    regexCondition2.keyword = @"^1[3|4|5|7|8][0-9]\\d{8}$"; // Phone number
    regexCondition2.conditionType = MJConditionTypeContainsRegex;
    
    XCTAssertTrue([regexCondition2 isMatchedForContent:@"18812345678"], @"regex12 true test");
    XCTAssertFalse([regexCondition2 isMatchedForContent:@"021-987654321"], @"regex2 false test");
    
//    MJConditionGroup *blackGroup = [MJConditionGroup new];
//    blackGroup.conditions = [@[condition] mutableCopy];
    
//    MJJudgementRule *rule = [MJJudgementRule new];
//    rule.blackConditionGroupList = [@[blackGroup] mutableCopy];
}

@end
