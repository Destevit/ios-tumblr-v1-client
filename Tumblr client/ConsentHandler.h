//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIRequester.h"

@protocol RequestFactory;
@protocol FormKeyProvider;
@protocol ConsentSender;


@interface ConsentHandler : NSObject <APIRequester>

- (instancetype __nullable)init NS_UNAVAILABLE;

- (instancetype __nullable)initWithAPIRequester:(id <APIRequester> __nonnull)requester
								 andKeyProvider:(id <FormKeyProvider> __nonnull)keyProvider
								  consentSender:(id <ConsentSender> __nonnull)consentSender;

@end