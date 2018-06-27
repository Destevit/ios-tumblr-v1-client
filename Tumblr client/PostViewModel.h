//
// Created by Dominik Ostrowski on 27.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Post;


@interface PostViewModel : NSObject

- (instancetype)initWithPost:(Post *)post;

@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSAttributedString *titleText;

@end