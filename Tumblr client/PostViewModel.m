//
// Created by Dominik Ostrowski on 27.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "PostViewModel.h"
#import "Post.h"
#import <UIKit/UIKit.h>


@implementation PostViewModel

- (instancetype)initWithPost:(Post *)post {
	self = super.init;

	if (self) {
		NSString *title = [post.title isEqual:NSNull.null] ? @"" : post.title;
		_titleText = [NSAttributedString.alloc initWithData:[title dataUsingEncoding:NSUTF16StringEncoding]
													options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
										 documentAttributes:nil
													  error:nil];
		_dateString = [NSDateFormatter localizedStringFromDate:post.date
													 dateStyle:NSDateFormatterShortStyle
													 timeStyle:NSDateFormatterShortStyle];
		_tags = [post.tags.allObjects componentsJoinedByString:@", "];

	}

	return self;
}

@end