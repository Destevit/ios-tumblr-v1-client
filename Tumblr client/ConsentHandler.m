//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "ConsentHandler.h"
#import "FormKeyProvider.h"
#import "ConsentSender.h"


@implementation ConsentHandler {
	id <APIRequester> _requester;
	id <FormKeyProvider> _keyProvider;
	id <ConsentSender> _consentSender;
}

- (instancetype)initWithAPIRequester:(id <APIRequester>__nonnull)requester
					  andKeyProvider:(id <FormKeyProvider>__nonnull)keyProvider
					   consentSender:(id <ConsentSender>__nonnull)consentSender {
	self = super.init;

	if (self) {
		_requester = requester;
		_keyProvider = keyProvider;
		_consentSender = consentSender;
	}

	return self;
}

- (void)makeRequestForPostsForUser:(NSString *__nonnull)user
						withOffset:(NSNumber *__nullable)offset
							  size:(NSNumber *__nullable)size
					  successBlock:(CompletionSuccessBlock)successBlock
					  failureBlock:(CompletionFailureBlock)failureBlock {
	failureBlock = failureBlock ?: (CompletionFailureBlock) ^{
	};

	CompletionHandlerBlock failureBlockOverride = ^(
			NSData *__nullable data, NSURLResponse *__nullable response, NSError *__nullable error
	) {
		if (data == nil) {
			failureBlock(data, response, error);
			return;
		}

		// json requests without a consent cookie are empty
		if (error == nil || data.length > 0) {
			failureBlock(data, response, error);
			return;
		}

		[_keyProvider provideKeyToBlock:^(NSString *key) {
			// it will obtain a cookie which will make a next request proper
			[_consentSender sendConsentForKey:key successBlock:^{
				[_requester makeRequestForPostsForUser:user
											withOffset:offset
												  size:size
										  successBlock:successBlock
										  failureBlock:failureBlock];
			}                    failureBlock:^{
				failureBlock(data, response, error);
			}];
		}];
	};

	[_requester makeRequestForPostsForUser:user
								withOffset:offset
									  size:size
							  successBlock:successBlock
							  failureBlock:failureBlockOverride];
}


@end