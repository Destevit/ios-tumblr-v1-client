//
// Created by Dominik Ostrowski on 26.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"


@interface PhotoPost : Post

@property(nonatomic, strong) NSURL *url;
@property(nonatomic, strong) NSSet<NSURL *> *set;
@property(nonatomic, strong) NSNumber *width;
@property(nonatomic, strong) NSNumber *height;

@end