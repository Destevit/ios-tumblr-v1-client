//
// Created by Dominik Ostrowski on 27.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostViewModel.h"

@class RegularPost;


@interface RegularPostViewModel : PostViewModel

- (instancetype)initWithRegularPost:(RegularPost *)post;

@property (nonatomic, strong) NSAttributedString *contentText;

@end