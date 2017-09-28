//
//  MJMenuViewController.m
//  MessageJudge
//
//  Created by GeXiao on 12/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJMenuViewController.h"
#import "GlobalDefine.h"
#import "MJJudgementRule.h"

NSString *const MJProjectHomeURL = @"https://github.com/Bynil/MessageJudge";
NSString *const MJProjectReadmeURL = @"https://github.com/Bynil/MessageJudge/blob/master/README.md#usage";
NSString *const MJMenuUsageURLTag = @"MJMenuUsageURLTag";
NSString *const MJMenuSourceCodeURLTag = @"MJMenuSourceCodeURLTag";
NSString *const MJMenuBackupTag = @"MJMenuBackupTag";
NSString *const MJMenuRecoverTag = @"MJMenuRecoverTag";

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
    
    XLFormSectionDescriptor *backupSection = [XLFormSectionDescriptor formSectionWithTitle:MJLocalize(@"iCloud")];
    
    XLFormRowDescriptor *backupRow = [XLFormRowDescriptor formRowDescriptorWithTag:MJMenuBackupTag rowType:XLFormRowDescriptorTypeButton title:MJLocalize(@"Backup rules to iCloud")];
    [backupRow.cellConfig setObject:@(NSTextAlignmentNatural) forKey:@"textLabel.textAlignment"];
    
    backupRow.action.formBlock = ^(XLFormRowDescriptor * sender){
        [weakSelf deselectFormRow:sender];
        [weakSelf showBackupAlert];
    };
    [backupSection addFormRow:backupRow];
    
    XLFormRowDescriptor *recoverRow = [XLFormRowDescriptor formRowDescriptorWithTag:MJMenuRecoverTag rowType:XLFormRowDescriptorTypeButton title:MJLocalize(@"Recover rules from iCloud")];
    [recoverRow.cellConfig setObject:@(NSTextAlignmentNatural) forKey:@"textLabel.textAlignment"];
    
    recoverRow.action.formBlock = ^(XLFormRowDescriptor * sender){
        [weakSelf deselectFormRow:sender];
        [weakSelf showRecoverAlert];
    };
    [backupSection addFormRow:recoverRow];
    [form addFormSection:backupSection];
    
    self.form = form;
}

- (void)showBackupAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MJLocalize(@"Warning") message:MJLocalize(@"This action will replace your rules existing on iCloud") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:MJLocalize(@"Continue") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MJGlobalRule backupRuleToIcloud];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:MJLocalize(@"Cancel") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self.tabBarController presentViewController:alertController animated:true completion:nil];
}

- (void)showRecoverAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MJLocalize(@"Warning") message:MJLocalize(@"This action will replace your local rules") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:MJLocalize(@"Continue") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([MJGlobalRule syncRuleFromIcloud]) {
            [MJJudgementRule regenerateShareInstance];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:MJLocalize(@"Cancel") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self.tabBarController presentViewController:alertController animated:true completion:nil];
}

@end
