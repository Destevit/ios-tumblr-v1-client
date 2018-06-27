//
// Created by Dominik Ostrowski on 27.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "PhotoPostViewModel.h"
#import "PhotoPost.h"


@implementation PhotoPostViewModel

- (instancetype)initWithPhotoPost:(PhotoPost *)post photoAvailableBlock:(void (^)(UIImage *image))block {
	self = [super initWithPost:post];

	if (self) {
		NSURL *url = post.url;

		if (url != nil) {
			NSOperationQueue *currentQueue = NSOperationQueue.currentQueue;
			NSOperationQueue *networkQueue = NSOperationQueue.alloc.init;

			_photo = [self createDefaultImageWithWidth:post.width.intValue andHeight:post.height.intValue];
			[networkQueue addOperationWithBlock:^{
				NSData *imageData = [NSData dataWithContentsOfURL:url];
				UIImage *image = [UIImage imageWithData:imageData];
				if (image == nil) {
					return;
				}
				_photo = image;
				[currentQueue addOperationWithBlock:^{
					block(image);
				}];
			}];
		}
	}

	return self;
}

- (UIImage *)createDefaultImageWithWidth:(int)width andHeight:(int)height {
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(width,height), NO, 0);
	UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(0,0,width,height)];
	[[UIColor blackColor] setFill];
	[path fill];
	UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}


@end