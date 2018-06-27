//
//  PostCell.h
//  Tumblr client
//
//  Created by Dominik Ostrowski on 26.06.2018.
//  Copyright © 2018 Dominik Ostrowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCell : UITableViewCell

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *tagsLabel;

- (void)setupViews;

- (void)setupConstraints;
@end
