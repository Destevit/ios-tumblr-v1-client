//
// Created by Dominik Ostrowski on 27.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegularPostViewModel.h"
#import "RegularPost.h"


@implementation RegularPostViewModel

- (instancetype)initWithRegularPost:(RegularPost *)post {
	self = [super initWithPost:post];

	if (self) {
		NSString *content = [post.text isEqual:NSNull.null] ? @"" : post.text;
		_contentText = [NSAttributedString.alloc initWithData:[content dataUsingEncoding:NSUTF16StringEncoding]
													  options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
										   documentAttributes:nil
														error:nil];
	}

	return self;
}

@end