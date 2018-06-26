//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionHandlerBlock)(
		NSData *__nullable data, NSURLResponse *__nullable response, NSError *__nullable error
);

typedef CompletionHandlerBlock CompletionFailureBlock;

typedef void (^CompletionSuccessBlock)(
		NSDictionary *__nullable responseBody, NSData *__nullable data, NSURLResponse *__nullable response
);