//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIRequester;
@protocol ResponseParser;


@interface APIFactory : NSObject

+ (id <APIRequester>)createRequester;

+ (id <ResponseParser>)createParser;

@end