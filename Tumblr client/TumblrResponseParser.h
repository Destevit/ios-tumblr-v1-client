//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParser.h"

@protocol PostParser;


@interface TumblrResponseParser : NSObject <ResponseParser>

- (instancetype __nullable)init NS_UNAVAILABLE;

- (instancetype __nullable)initWithParsers:(NSDictionary<NSString *, id <PostParser>> *__nonnull)parser;

@end