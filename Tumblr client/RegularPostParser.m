//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "RegularPostParser.h"
#import "RegularPost.h"


@implementation RegularPostParser

- (RegularPost *__nullable)postFromDictionary:(NSDictionary *__nonnull)dictionary {
	if (![dictionary[@"type"] isEqual:@"regular"]) {
		return nil;
	}

	RegularPost *post = (RegularPost *) [super postFromDictionary:dictionary];

	post.title = dictionary[@"regular-title"];
	post.text = dictionary[@"regular-body"];

	return post;
}

- (RegularPost *__nonnull)createPost {
	return RegularPost.alloc.init;
}


@end