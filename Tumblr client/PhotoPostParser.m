//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "PhotoPostParser.h"
#import "PhotoPost.h"


@implementation PhotoPostParser

- (PhotoPost *__nullable)postFromDictionary:(NSDictionary *__nonnull)dictionary {
	if (![dictionary[@"type"] isEqual:@"photo"]) {
		return nil;
	}

	PhotoPost *post = (PhotoPost *) [super postFromDictionary:dictionary];

	post.title = dictionary[@"photo-caption"];
	post.width = dictionary[@"width"];
	post.height = dictionary[@"height"];
	post.url = [NSURL URLWithString:dictionary[@"photo-url-1280"]];

	NSArray <NSDictionary *> *photos = dictionary[@"photos"];

	NSMutableSet <NSURL *> *photosUrlSet = [NSMutableSet.alloc initWithCapacity:photos.count];

	for (NSDictionary *photo in photos) {
		[photosUrlSet addObject:photo[@"photo-url-1280"]];
	}

	post.set = photosUrlSet;

	return post;
}

- (PhotoPost *__nonnull)createPost {
	return PhotoPost.alloc.init;
}


@end