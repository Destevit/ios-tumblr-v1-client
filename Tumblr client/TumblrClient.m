//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "TumblrClient.h"
#import "Post.h"
#import "TumblrClientDelegate.h"
#import "APIRequester.h"
#import "APIFactory.h"
#import "ResponseParser.h"

@interface TumblrClient ()

@property(nonatomic, strong) id <APIRequester> requester;
@property(nonatomic, strong) id <ResponseParser> parser;
@property(nonatomic, strong) NSOperationQueue *clientQueue;

@end

@implementation TumblrClient {
	__weak id <TumblrClientDelegate> _delegate;
	NSObject *_lazyGettersSync;
}

- (instancetype)initWithDelegate:(id <TumblrClientDelegate>)delegate {
	self = super.init;

	if (self) {
		_delegate = delegate;
		_lazyGettersSync = NSObject.alloc.init;
	}

	return self;
}

- (void)requestPostsForUser:(NSString *)user
				 withOffset:(NSNumber *)offset
					   size:(NSNumber *)size {
	NSOperationQueue *invocationQueue = NSOperationQueue.currentQueue;

	CompletionSuccessBlock successBlock = ^(NSDictionary *responseBody, NSData *rawData, NSURLResponse *response) {
		NSArray<Post *> *posts = [self.parser postsFromDictionary:responseBody];

		[invocationQueue addOperationWithBlock:^{
			[_delegate tumblrClient:self gotPosts:posts withOffset:offset andSize:size];
		}];
	};

	CompletionFailureBlock failureBlock = ^(NSData *data, NSURLResponse *response, NSError *error) {
		[invocationQueue addOperationWithBlock:^{
			[_delegate tumblrClient:self didFailWithError:error];
		}];
	};

	[self.clientQueue addOperationWithBlock:^{
		[self.requester makeRequestForPostsForUser:user
										withOffset:offset
											  size:size
									  successBlock:successBlock
									  failureBlock:failureBlock];
	}];
}

- (id <APIRequester>)requester {
	@synchronized (_lazyGettersSync) {
		if (_requester == nil) {
			_requester = APIFactory.createRequester;
		}
	}
	return _requester;
}

- (id <ResponseParser>)parser {
	@synchronized (_lazyGettersSync) {
		if (_parser == nil) {
			_parser = APIFactory.createParser;
		}
	}
	return _parser;
}

- (NSOperationQueue *)clientQueue {
	@synchronized (_lazyGettersSync) {
		if (_clientQueue == nil) {
			_clientQueue = NSOperationQueue.alloc.init;
			[_clientQueue setMaxConcurrentOperationCount:1];
		}
	}
	return _clientQueue;
}

@end