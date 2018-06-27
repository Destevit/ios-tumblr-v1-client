//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "RequestFormKeyProvider.h"
#import "RequestFactory.h"
#import "CompletionHandlerBlock.h"


@implementation RequestFormKeyProvider {
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

- (void)provideKeyToBlock:(void (^)(NSString *__nullable key))block {

	NSURLRequest *request = [_requestFactory createKeyRequest];

	CompletionHandlerBlock handler = ^(NSData *data, NSURLResponse *response, NSError *error) {
		NSString *responseString = [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
		if (responseString == nil) {
			block(nil);
			return;
		}

		NSRange searchRange = NSMakeRange(0, responseString.length);
		NSString *keySearchPattern = @"<meta name=\"tumblr-form-key\"[^>]+content=\"([^\"]+)\">";
		NSRegularExpression *keySearchRegex = [NSRegularExpression regularExpressionWithPattern:keySearchPattern
																						options:0
																						  error:nil];
		NSTextCheckingResult *keyResult = [keySearchRegex firstMatchInString:responseString options:0 range:searchRange];
		NSRange rangeWithKey = [keyResult rangeAtIndex:1];
		NSString *key = [responseString substringWithRange:rangeWithKey];

		block(key);
	};

	NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request
																   completionHandler:handler];

	[dataTask resume];
}


@end