//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "HTTPConsentSender.h"
#import "RequestFactory.h"
#import "CompletionHandlerBlock.h"


@implementation HTTPConsentSender {
	id <RequestFactory> _requestFactory;
	NSURLSession *_session;
}

- (instancetype)initWithRequestFactory:(id <RequestFactory>)requestFactory
							andSession:(NSURLSession *)session {
	self = super.init;

	if (self) {
		_requestFactory = requestFactory;
		_session = session;
	}

	return self;
}

- (void)sendConsentForKey:(NSString *)key
			 successBlock:(void (^)(void))successBlock
			 failureBlock:(void (^)(void))failureBlock {
	successBlock = successBlock ?: ^{
	};
	failureBlock = failureBlock ?: ^{
	};

	NSURLRequest *request = [_requestFactory createConsentRequestWithKey:key];

	CompletionFailureBlock handler = ^(NSData *data, NSURLResponse *response, NSError *error) {
		if (![response isKindOfClass:NSHTTPURLResponse.class]) {
			failureBlock();
		}

		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

		if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
			failureBlock();
			return;
		}

		successBlock();
	};

	NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request
												 completionHandler:handler];

	[dataTask resume];
}

@end