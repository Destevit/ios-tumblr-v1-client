//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestFactory <NSObject>

- (NSURLRequest *__nonnull)createReadRequestForUser:(NSString *__nonnull)user
										 withOffset:(NSNumber *__nullable)offset
											   size:(NSNumber *__nullable)size;

- (NSURLRequest *__nonnull)createConsentRequestWithKey:(NSString *__nonnull)key;


- (NSURLRequest *__nonnull)createKeyRequest;

@end