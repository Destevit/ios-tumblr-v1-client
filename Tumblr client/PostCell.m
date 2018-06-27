//
//  PostCell.m
//  Tumblr client
//
//  Created by Dominik Ostrowski on 26.06.2018.
//  Copyright © 2018 Dominik Ostrowski. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

	if (self) {
		_dateLabel = UILabel.alloc.init;
		_titleView = UILabel.alloc.init;
		_tagsLabel = UILabel.alloc.init;

		[self setupViews];
		[self setupConstraints];
	}

	return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupViews {
	//[_titleView setEditable:NO];

	[self addSubview:_dateLabel];
	[self addSubview:_tagsLabel];
	[self addSubview:_titleView];

	_titleView.numberOfLines = 0;
}

- (void)setupConstraints {
	_dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[[_dateLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:8] setActive:YES];
	[[_dateLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8] setActive:YES];
	[[_dateLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8] setActive:YES];

	_tagsLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[[_tagsLabel.topAnchor constraintEqualToAnchor:_dateLabel.bottomAnchor constant:8] setActive:YES];
	[[_tagsLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8] setActive:YES];
	[[_tagsLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8] setActive:YES];

	_titleView.translatesAutoresizingMaskIntoConstraints = NO;
	[[_titleView.topAnchor constraintEqualToAnchor:_tagsLabel.bottomAnchor constant:8] setActive:YES];
	[[_titleView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8] setActive:YES];
	[[_titleView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8] setActive:YES];
	[[_titleView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8] setActive:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
