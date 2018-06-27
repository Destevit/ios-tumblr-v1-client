//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompletionHandlerBlock.h"


@protocol APIRequester <NSObject>

- (void)makeRequestForPostsForUser:(NSString *__nonnull)user
						withOffset:(NSNumber *__nullable)offset
							  size:(NSNumber *__nullable)size
					  successBlock:(CompletionSuccessBlock __nullable)successBlock
					  failureBlock:(CompletionFailureBlock __nullable)failureBlock;

@end