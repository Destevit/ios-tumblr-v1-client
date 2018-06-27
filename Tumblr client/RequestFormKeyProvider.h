//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormKeyProvider.h"

@protocol RequestFactory;


@interface RequestFormKeyProvider : NSObject <FormKeyProvider>


- (instancetype)initWithRequestFactory:(id <RequestFactory>)requestFactory
							andSession:(NSURLSession *)session;

@end