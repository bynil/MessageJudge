//
//  MJConditionCell.m
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJConditionCell.h"
#import "Masonry.h"
#import "MJCondition.h"
#import "GlobalDefine.h"

static CGFloat MJConditionCellTargetLabelFontSize = 17.f;
static CGFloat MJConditionCellTypeLabelFontSize = 17.f;
static CGFloat MJConditionCellKeywordLabelFontSize = 17.f;

static CGFloat MJConditionCellLabelLeftPadding = 16.f;
static CGFloat MJConditionCellLabelSpace = 8.f;
static CGFloat MJConditionCellLabelRadius = 3.f;

@interface MJConditionCell ()

@property (nonatomic, strong) UILabel *targeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *keywordLabel;

@end

@implementation MJConditionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        [self makeConstranits];
    }
    return self;
}

- (void)initUI {
    self.targeLabel = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 1;
        label.font = [UIFont systemFontOfSize:MJConditionCellTargetLabelFontSize];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = RGBColor(102, 204, 102);
        label.layer.masksToBounds = true;
        label.layer.cornerRadius = MJConditionCellLabelRadius;
        label;
    });
    [self.contentView addSubview:self.targeLabel];
    
    self.typeLabel = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 1;
        label.font = [UIFont systemFontOfSize:MJConditionCellTypeLabelFontSize];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = RGBColor(255, 204, 153);
        label.layer.masksToBounds = true;
        label.layer.cornerRadius = MJConditionCellLabelRadius;
        label;
    });
    [self.contentView addSubview:self.typeLabel];
    
    self.keywordLabel = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 1;
        label.font = [UIFont systemFontOfSize:MJConditionCellKeywordLabelFontSize];
        label;
    });
    [self.contentView addSubview:self.keywordLabel];
}

- (void)makeConstranits {
    [self.targeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MJConditionCellLabelLeftPadding);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.targeLabel.mas_right).offset(MJConditionCellLabelSpace);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.keywordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(MJConditionCellLabelSpace);
        make.centerY.equalTo(self.contentView);
        make.right.lessThanOrEqualTo(self.contentView);
    }];
    [self.keywordLabel setContentCompressionResistancePriority:(UILayoutPriorityDefaultLow) forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)renderCellWithCondition:(MJCondition *)condition {
    switch (condition.conditionTarget) {
        case MJConditionTargetSender:
            self.targeLabel.text = MJLocalize(@"Sender");
            break;
        case MJConditionTargetContent:
            self.targeLabel.text = MJLocalize(@"Content");
            break;
        default:
            self.targeLabel.text = MJLocalize(@"Invalid target");
            break;
    }
    
    switch (condition.conditionType) {
        case MJConditionTypeHasPrefix:
            self.typeLabel.text = MJLocalize(@"has prefix");
            break;
        case MJConditionTypeHasSuffix:
            self.typeLabel.text = MJLocalize(@"has suffix");
            break;
        case MJConditionTypeContains:
            self.typeLabel.text = MJLocalize(@"contains");
            break;
        case MJConditionTypeNotContains:
            self.typeLabel.text = MJLocalize(@"doesn't contain");
            break;
        case MJConditionTypeContainsRegex:
            self.typeLabel.text = MJLocalize(@"matches regex");
            break;
        default:
            break;
    }
    
    self.keywordLabel.text = condition.keyword;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.targeLabel.text = @"";
    self.typeLabel.text = @"";
    self.keywordLabel.text = @"";
}
@end
