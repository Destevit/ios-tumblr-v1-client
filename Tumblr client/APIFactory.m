//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "APIFactory.h"
#import "APIRequester.h"
#import "ResponseParser.h"
#import "ConsentHandler.h"
#import "ReadRequester.h"
#import "SimpleRequestFactory.h"
#import "RequestFormKeyProvider.h"
#import "HTTPConsentSender.h"
#import "TumblrResponseParser.h"
#import "PhotoPostParser.h"
#import "RegularPostParser.h"


@implementation APIFactory

+ (id <APIRequester>)createRequester {

	NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];

	id <RequestFactory> requestFactory = SimpleRequestFactory.alloc.init;

	id <APIRequester> readRequester = [ReadRequester.alloc initWithRequestFactory:requestFactory
																	   andSession:session];

	id <FormKeyProvider> keyProvider = [RequestFormKeyProvider.alloc initWithRequestFactory:requestFactory
																				 andSession:session];

	id <ConsentSender> consentSender = [HTTPConsentSender.alloc initWithRequestFactory:requestFactory
																			andSession:session];


	id <APIRequester> requester = [ConsentHandler.alloc initWithAPIRequester:readRequester
															  andKeyProvider:keyProvider
															   consentSender:consentSender];

	return requester;
}

+ (id <ResponseParser>)createParser {

	id <ResponseParser> responseParser = [TumblrResponseParser.alloc initWithParsers:@{
			@"photo": PhotoPostParser.alloc.init,
			@"regular": RegularPostParser.alloc.init
	}];

	return responseParser;
}
@end