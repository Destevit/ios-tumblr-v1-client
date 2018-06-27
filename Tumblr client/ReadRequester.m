//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "ReadRequester.h"
#import "RequestFactory.h"


@implementation ReadRequester {
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

- (void)makeRequestForPostsForUser:(NSString *__nonnull)user
						withOffset:(NSNumber *__nullable)offset
							  size:(NSNumber *__nullable)size
					  successBlock:(CompletionSuccessBlock)successBlock
					  failureBlock:(CompletionFailureBlock)failureBlock {
	successBlock = successBlock ?: (CompletionSuccessBlock) ^{
	};
	failureBlock = failureBlock ?: (CompletionFailureBlock) ^{
	};

	NSURLRequest *request = [_requestFactory createReadRequestForUser:user
														   withOffset:offset
																 size:size];

	CompletionFailureBlock handlerBlock = ^(NSData *data, NSURLResponse *response, NSError *error) {
		if (error) {
			failureBlock(data, response, error);
			return;
		}

		if (![response isKindOfClass:NSHTTPURLResponse.class]) {
			failureBlock(data, response, error);
			return;
		}

		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

		if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
			failureBlock(data, response, error);
			return;
		}


		if (data.length >= 25) {
			// there is some data
			// to extract pure json from the response we need to rid of the JavaScript instance assignment
			NSMutableData *mutableData = data.mutableCopy;
			// stripping "var tumblr_api_read = " at the beginning
			[mutableData replaceBytesInRange:NSMakeRange(0, 22) withBytes:NULL length:0];
			// stripping ";\n" at the end
			[mutableData replaceBytesInRange:NSMakeRange(mutableData.length - 2, 2) withBytes:NULL length:0];
			data = mutableData;
		}

		NSDictionary *parsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

		if (error) {
			failureBlock(data, response, error);
		} else {
			successBlock(parsed, data, response);
		}
	};

	NSURLSessionDataTask *sessionTask = [_session dataTaskWithRequest:request
													completionHandler:handlerBlock];

	[sessionTask resume];
}

@end
