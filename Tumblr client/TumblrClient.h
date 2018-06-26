//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Post;
@protocol TumblrClientDelegate;


@interface TumblrClient : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDelegate:(id <TumblrClientDelegate>)delegate;

- (void)requestPostsForUser:(NSString *)user withOffset:(NSNumber *)offset size:(NSNumber *)size;

@end