//
//  MessageJudgeTests.m
//  MessageJudgeTests
//
//  Created by GeXiao on 09/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MJJudgementRule.h"

#define MJRequest(sender, content) [[MJQueryRequest alloc] initWithSender:sender messageBody:content]

@interface MessageJudgeTests : XCTestCase

@end

@implementation MessageJudgeTests

- (BOOL)isCondition:(MJCondition *)condition matchedWithSender:(NSString *)sender content:(NSString *)content {
    MJQueryRequest *request = MJRequest(sender, content);
    return [condition isMatchedForRequest:request];
}

- (void)testConditionValidity {
    MJCondition *prefixCondition = [MJCondition new];
    prefixCondition.keyword = @"a special prefix";
    prefixCondition.conditionType = MJConditionTypeHasPrefix;
    
    
    XCTAssertTrue([prefixCondition isMatchedForRequest:MJRequest(@"12345678", @"a special prefix with xxx")], @"prefix true test");
    XCTAssertFalse([prefixCondition isMatchedForRequest:MJRequest(@"12345678", @"xxx a special prefix with xxx")], @"prefix false test");
    
    MJCondition *suffixCondition = [MJCondition new];
    suffixCondition.keyword = @"a tiresome suffix";
    suffixCondition.conditionType = MJConditionTypeHasSuffix;
    
    XCTAssertTrue([suffixCondition isMatchedForRequest:MJRequest(@"12345678", @"xxx with a tiresome suffix")], @"suffix true test");
    XCTAssertFalse([suffixCondition isMatchedForRequest:MJRequest(@"12345678", @"a tiresome suffix ?")], @"suffix false test");
    
    MJCondition *containCondition = [MJCondition new];
    containCondition.keyword = @"nothing";
    containCondition.conditionType = MJConditionTypeContains;
    
    XCTAssertTrue([containCondition isMatchedForRequest:MJRequest(@"12345678", @"xxx nothing yyy zzz")], @"contain true test");
    XCTAssertFalse([containCondition isMatchedForRequest:MJRequest(@"12345678", @"xxx with a tiresome suffix")], @"contain false test");
    
    MJCondition *notContainCondition = [MJCondition new];
    notContainCondition.keyword = @"girlfriend";
    notContainCondition.conditionType = MJConditionTypeNotContains;
    
    XCTAssertTrue([notContainCondition isMatchedForRequest:MJRequest(@"12345678", @"I am a single dog")], @"notcontain true test");
    XCTAssertFalse([notContainCondition isMatchedForRequest:MJRequest(@"12345678", @"girlfriend is not nessasory")], @"notcontain true test");
    
    MJCondition *regexCondition1 = [MJCondition new];
    regexCondition1.keyword = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?"; // URL
    regexCondition1.conditionType = MJConditionTypeContainsRegex;
    
    XCTAssertTrue([regexCondition1 isMatchedForRequest:MJRequest(@"12345678", @"http://www.google.com/news")], @"regex1 true test");
    XCTAssertFalse([regexCondition1 isMatchedForRequest:MJRequest(@"12345678", @"www.twitter.com")], @"regex1 false test");
    
    MJCondition *regexCondition2 = [MJCondition new];
    regexCondition2.keyword = @"1[3|4|5|7|8][0-9]\\d{8}"; // Phone number
    regexCondition2.conditionType = MJConditionTypeContainsRegex;
    regexCondition2.conditionTarget = MJConditionTargetSender;
    
    XCTAssertTrue([regexCondition2 isMatchedForRequest:MJRequest(@"18812345678", @"aaa 18812345678 bbb")], @"regex12 true test");
    XCTAssertFalse([regexCondition2 isMatchedForRequest:MJRequest(@"12345678", @"aaa 021-987654321  bbb")], @"regex2 false test");
    
    MJConditionGroup *conditionGroup1 = [MJConditionGroup new];
    conditionGroup1.conditions = [@[prefixCondition, containCondition, regexCondition2] mutableCopy];
    
    XCTAssertTrue([conditionGroup1 isMatchedForRequest:MJRequest(@"18812345678", @"a special prefix with xxx xxx nothing yyy zzz nothing 18812345678")]);
    XCTAssertFalse([conditionGroup1 isMatchedForRequest:MJRequest(@"12345678", @"xxx nothing yyy zzz 18812345678")]);
    
    MJConditionGroup *conditionGroup2 = [MJConditionGroup new];
    conditionGroup2.conditions = [@[notContainCondition, regexCondition1] mutableCopy];
    
    XCTAssertTrue([conditionGroup2 isMatchedForRequest:MJRequest(@"12345678", @"xxx nothing yyy zzz nothing http://www.facebook.com/")]);
    XCTAssertFalse([conditionGroup2 isMatchedForRequest:MJRequest(@"12345678", @"xxx nothing girlfriend zzz nothing http://www.facebook.com/")]);
    
    
    MJJudgementRule *rule = [MJJudgementRule new];
    rule.whiteConditionGroupList = [@[conditionGroup2] mutableCopy];
    rule.blackConditionGroupList = [@[conditionGroup1] mutableCopy];
    
    NSString *unwantedString = @"a special prefix with xxx nothing girlfriend zzz nothing 18812345678";
    XCTAssertFalse([conditionGroup2 isMatchedForRequest:MJRequest(@"1881234", unwantedString)]);
    XCTAssertTrue([conditionGroup1 isMatchedForRequest:MJRequest(@"18812345678", unwantedString)]);
    
    ILMessageFilterQueryRequest *systemRequest = [ILMessageFilterQueryRequest new];
    [systemRequest setValue: MJRequest(@"18812345678", unwantedString).sender forKey:@"sender"];
    [systemRequest setValue: MJRequest(@"18812345678", unwantedString).messageBody forKey:@"messageBody"];
    XCTAssertTrue([rule isUnwantedMessageForSystemQueryRequest:systemRequest]);
    
    NSString *wantedString = @"xxx nothing yyy zzz nothing http://www.facebook.com/";
    XCTAssertTrue([conditionGroup2 isMatchedForRequest:MJRequest(@"18812345678", wantedString)]);
    XCTAssertFalse([conditionGroup1 isMatchedForRequest:MJRequest(@"12345678", wantedString)]);
    
    [systemRequest setValue: MJRequest(@"1881234", wantedString).sender forKey:@"sender"];
    [systemRequest setValue: MJRequest(@"1881234", wantedString).messageBody forKey:@"messageBody"];
    XCTAssertFalse([rule isUnwantedMessageForSystemQueryRequest:systemRequest]);
    
    [systemRequest setValue: MJRequest(@"12345678", @"aaabbb").sender forKey:@"sender"];
    [systemRequest setValue: MJRequest(@"12345678", @"aaabbb").messageBody forKey:@"messageBody"];
    XCTAssertFalse([rule isUnwantedMessageForSystemQueryRequest:systemRequest]);
}

@end
