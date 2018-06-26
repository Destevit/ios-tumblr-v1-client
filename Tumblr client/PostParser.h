//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Post;

@protocol PostParser <NSObject>

- (Post *__nullable)postFromDictionary:(NSDictionary *__nonnull)dictionary;

- (Post *__nonnull)createPost;

@end