//
//  MJQueryRequest.m
//  MessageJudge
//
//  Created by GeXiao on 09/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MJQueryRequest.h"

@implementation MJQueryRequest

- (instancetype)initWithSystemQueryRequest:(ILMessageFilterQueryRequest *)request {
    self = [super init];
    if (self) {
        _sender = request.sender;
        _messageBody = request.messageBody;
    }
    return self;
}

@end
