//
//  ChooseUserView.m
//  Tumblr client
//
//  Created by Dominik Ostrowski on 26.06.2018.
//  Copyright © 2018 Dominik Ostrowski. All rights reserved.
//

#import "ChooseUserView.h"


@implementation ChooseUserView

- (instancetype)init {
	self = super.init;

	if (self) {
		_label = UILabel.alloc.init;
		_input = UITextField.alloc.init;
		_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];

		[self setupViews];
		[self setupConstraints];
	}

	return self;
}

- (void)setupConstraints {
	_label.translatesAutoresizingMaskIntoConstraints = NO;
	[[_label.topAnchor constraintEqualToAnchor:self.topAnchor constant:20] setActive:YES];
	[[_label.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:20] setActive:YES];
	[[_label.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-20] setActive:YES];

	_input.translatesAutoresizingMaskIntoConstraints = NO;
	[[_input.topAnchor constraintEqualToAnchor:_label.bottomAnchor constant:20] setActive:YES];
	[[_input.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:20] setActive:YES];
	[[_input.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-20] setActive:YES];

	_button	.translatesAutoresizingMaskIntoConstraints = NO;
	[[_button.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:20] setActive:YES];
	[[_button.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-20] setActive:YES];
	[[_button.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20] setActive:YES];

	[[_button.topAnchor constraintEqualToAnchor:_input.bottomAnchor constant:20] setActive:YES];
}

- (void)setupViews {
	self.translatesAutoresizingMaskIntoConstraints = NO;

	[_label setText:@"Username:"];

	_input.backgroundColor = UIColor.whiteColor;
	_input.borderStyle = UITextBorderStyleRoundedRect;

	[_button setTitle:@"Show" forState:UIControlStateNormal];
	_button.translatesAutoresizingMaskIntoConstraints = false;

	[self addSubview:_input];
	[self addSubview:_button];
	[self addSubview:_label];
}


@end
