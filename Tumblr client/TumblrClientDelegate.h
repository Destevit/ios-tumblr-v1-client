//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TumblrClient;
@class Post;

@protocol TumblrClientDelegate <NSObject>

@optional
- (void)tumblrClient:(TumblrClient *)client didFailWithError:(NSError *)error;

- (void)tumblrClient:(TumblrClient *)client gotPosts:(NSArray<Post *> *)posts
		  withOffset:(NSNumber *)offset andSize:(NSNumber *)size;
@end