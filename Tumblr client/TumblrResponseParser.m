//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "TumblrResponseParser.h"
#import "PostParser.h"


@implementation TumblrResponseParser {
	NSDictionary<NSString *, id <PostParser>> *_parsers;
}

- (instancetype)initWithParsers:(NSDictionary<NSString *, id <PostParser>> *)parsers {
	self = super.init;

	if (self) {
		_parsers = parsers.copy;
	}

	return self;
}

- (NSArray <Post *> *)postsFromDictionary:(NSDictionary *)dictionary {
	NSArray *dictPosts = dictionary[@"posts"];

	if (dictPosts == nil) {
		return nil;
	}

	NSMutableArray<Post *> *posts = NSMutableArray.alloc.init;

	for (NSDictionary *dictPost in dictPosts) {
		id <PostParser> parser = _parsers[dictPost[@"type"]];
		Post *post = [parser postFromDictionary:dictPost];
		if (post != nil) {
			[posts addObject:post];
		}
	}

	return posts;
}

@end