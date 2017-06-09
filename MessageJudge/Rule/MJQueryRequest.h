//
//  MJQueryRequest.h
//  MessageJudge
//
//  Created by GeXiao on 09/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IdentityLookup/IdentityLookup.h>

// A container for system request to avoid API breaking
@interface MJQueryRequest : NSObject

@property (nonatomic, readonly, nullable) NSString *sender;
@property (nonatomic, readonly, nullable) NSString *messageBody;

- (instancetype _Nonnull)initWithSystemQueryRequest:(ILMessageFilterQueryRequest *_Nonnull)request;

- (instancetype _Nonnull)initWithSender:(NSString *_Nullable)sender messageBody:(NSString *_Nullable)messageBody;

@end
