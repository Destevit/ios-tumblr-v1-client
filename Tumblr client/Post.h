//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Post : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSSet<NSString *> *tags;
@property(nonatomic, strong) NSDate *date;

@end