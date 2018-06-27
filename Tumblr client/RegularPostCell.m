//
//  RegularPostCell.m
//  Tumblr client
//
//  Created by Dominik Ostrowski on 26.06.2018.
//  Copyright © 2018 Dominik Ostrowski. All rights reserved.
//

#import "RegularPostCell.h"

@implementation RegularPostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

	if (self) {
		_contentLabel = UILabel.alloc.init;

		[self setupViews];
		[self setupConstraints];
	}

	return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
	[super setupViews];

	[self addSubview:_contentLabel];

	_contentLabel.numberOfLines = 0;
}

- (void)setupConstraints {
	self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[[self.dateLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:8] setActive:YES];
	[[self.dateLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8] setActive:YES];
	[[self.dateLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8] setActive:YES];

	self.tagsLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[[self.tagsLabel.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor constant:8] setActive:YES];
	[[self.tagsLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8] setActive:YES];
	[[self.tagsLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8] setActive:YES];

	self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
	[[self.titleView.topAnchor constraintEqualToAnchor:self.tagsLabel.bottomAnchor constant:8] setActive:YES];
	[[self.titleView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8] setActive:YES];
	[[self.titleView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8] setActive:YES];

	self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[[self.contentLabel.topAnchor constraintEqualToAnchor:self.titleView.bottomAnchor constant:8] setActive:YES];
	[[self.contentLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8] setActive:YES];
	[[self.contentLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8] setActive:YES];
	[[self.contentLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8] setActive:YES];

}

@end
