//
// Created by Dominik Ostrowski on 25.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FormKeyProvider <NSObject>

- (void)provideKeyToBlock:(void (^ __nonnull)(NSString *__nullable key))block;

@end