//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "BasePostParser.h"
#import "Post.h"


@implementation BasePostParser

- (Post *__nullable)postFromDictionary:(NSDictionary *__nonnull)dictionary {
	Post *post = [self createPost];

	NSTimeInterval unixTimestamp = [dictionary[@"unix-timestamp"] doubleValue];
	post.date = [NSDate dateWithTimeIntervalSince1970:unixTimestamp];

	NSArray<NSString *> *tagsArray = dictionary[@"tags"];
	post.tags = [NSSet setWithArray:tagsArray];

	return post;
}

- (Post *)createPost {
	return Post.alloc.init;
}


@end