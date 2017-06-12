//
//  MJMenuViewController.m
//  MessageJudge
//
//  Created by GeXiao on 12/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJMenuViewController.h"
#import "GlobalDefine.h"

NSString *const MJProjectHomeURL = @"https://github.com/Bynil/MessageJudge";
NSString *const MJProjectReadmeURL = @"https://github.com/Bynil/MessageJudge/blob/master/README.md";
NSString *const MJMenuUsageURLTag = @"MJMenuUsageURLTag";
NSString *const MJMenuSourceCodeURLTag = @"MJMenuSourceCodeURLTag";

@interface MJMenuViewController ()

@end

@implementation MJMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    self.title = MJLocalize(@"Menu");
}

- (void)initUI {
    XLFormDescriptor *form = [XLFormDescriptor formDescriptorWithTitle:MJLocalize(@"Menu")];
    
    XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:MJLocalize(@"Project")];
    
    XLFormRowDescriptor *usageRow = [XLFormRowDescriptor formRowDescriptorWithTag:MJMenuSourceCodeURLTag rowType:XLFormRowDescriptorTypeButton title:MJLocalize(@"Usage")];
    [usageRow.cellConfig setObject:@(NSTextAlignmentNatural) forKey:@"textLabel.textAlignment"];
    
    __typeof(self) __weak weakSelf = self;
    usageRow.action.formBlock = ^(XLFormRowDescriptor * sender){
        [weakSelf deselectFormRow:sender];
        NSURL *url = [NSURL URLWithString:MJProjectReadmeURL];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    };
    [section addFormRow:usageRow];
    
    XLFormRowDescriptor *sourceCodeRow = [XLFormRowDescriptor formRowDescriptorWithTag:MJMenuSourceCodeURLTag rowType:XLFormRowDescriptorTypeButton title:MJLocalize(@"Source code")];
    [sourceCodeRow.cellConfig setObject:@(NSTextAlignmentNatural) forKey:@"textLabel.textAlignment"];
    sourceCodeRow.action.formBlock = ^(XLFormRowDescriptor * sender){
        [weakSelf deselectFormRow:sender];
        NSURL *url = [NSURL URLWithString:MJProjectHomeURL];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    };
    [section addFormRow:sourceCodeRow];
    [form addFormSection:section];
    self.form = form;
}

@end
