//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import "SimpleRequestFactory.h"


@implementation SimpleRequestFactory

- (NSURLRequest *__nonnull)createReadRequestForUser:(NSString *__nonnull)user
										 withOffset:(NSNumber *__nullable)offset
											   size:(NSNumber *__nullable)size {

	NSMutableDictionary<NSString *, NSString *> *params = NSMutableDictionary.alloc.init;

	params[@"start"] = offset.stringValue;
	params[@"num"] = size.stringValue;

	NSMutableArray<NSString *> *queryParts = NSMutableArray.alloc.init;

	for (NSString *key in params.allKeys) {
		NSString *keyValue = [NSString stringWithFormat:@"%@=%@", key, params[key]];
		[queryParts addObject:keyValue];
	}

	NSString *query = [queryParts componentsJoinedByString:@"&"];

	NSString *urlString = [NSString stringWithFormat:@"https://%@.tumblr.com/api/read/json?%@", user, query];
	NSURL *url = [NSURL URLWithString:urlString];

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	request.HTTPMethod = @"GET";
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

	return request;
}

- (NSURLRequest *__nonnull)createKeyRequest {
	NSURL *url = [NSURL URLWithString:@"https://www.tumblr.com/privacy/consent"];

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	request.HTTPMethod = @"GET";

	return request;
}

- (NSURLRequest *__nonnull)createConsentRequestWithKey:(NSString *__nonnull)key {
	NSURL *url = [NSURL URLWithString:@"https://www.tumblr.com/svc/privacy/consent"];

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	request.HTTPMethod = @"POST";

	NSString *body = @"{\n"
					 "   \"eu_resident\":true,\n"
					 "   \"gdpr_is_acceptable_age\":true,\n"
					 "   \"gdpr_consent_core\":true,\n"
					 "   \"gdpr_consent_first_party_ads\":true,\n"
					 "   \"gdpr_consent_third_party_ads\":true,\n"
					 "   \"gdpr_consent_search_history\":true\n"
					 "}";
	request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];

	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"https://www.tumblr.com" forHTTPHeaderField:@"Referer"];
	[request setValue:key forHTTPHeaderField:@"X-tumblr-form-key"];

	return request;
}

@end
