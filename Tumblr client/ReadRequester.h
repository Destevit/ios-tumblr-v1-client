//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIRequester.h"

@protocol RequestFactory;


@interface ReadRequester : NSObject <APIRequester>

- (instancetype __nullable)init NS_UNAVAILABLE;

- (instancetype __nullable)initWithRequestFactory:(id <RequestFactory> __nonnull)requestFactory
									   andSession:(NSURLSession *__nonnull)session;

@end