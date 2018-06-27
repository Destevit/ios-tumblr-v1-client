//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConsentSender <NSObject>

- (void)sendConsentForKey:(NSString *)key
			 successBlock:(void (^)(void))successBlock
			 failureBlock:(void (^)(void))failureBlock;

@end