//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Post;

@protocol ResponseParser <NSObject>

- (NSArray <Post *> *__nullable)postsFromDictionary:(NSDictionary *__nonnull)dictionary;

@end