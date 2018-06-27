//
// Created by Dominik Ostrowski on 27.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PostViewModel.h"

@class PhotoPost;


@interface PhotoPostViewModel : PostViewModel

- (instancetype)initWithPhotoPost:(PhotoPost *)post photoAvailableBlock:(void (^)(UIImage *image))block;

@property (nonatomic, strong) UIImage* photo;

@end