//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsentSender.h"

@protocol RequestFactory;


@interface HTTPConsentSender : NSObject <ConsentSender>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithRequestFactory:(id <RequestFactory>)requestFactory
							andSession:(NSURLSession *)session;

@end