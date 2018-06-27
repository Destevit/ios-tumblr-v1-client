//
//  ChooseUserViewController.m
//  Tumblr client
//
//  Created by Dominik Ostrowski on 26.06.2018.
//  Copyright © 2018 Dominik Ostrowski. All rights reserved.
//

#import "ChooseUserViewController.h"
#import "ChooseUserView.h"
#import "PostsTableViewController.h"

@interface ChooseUserViewController ()

@end

@implementation ChooseUserViewController {
	ChooseUserView *_chooseUserView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	_chooseUserView = ChooseUserView.alloc.init;

	self.view.backgroundColor = UIColor.whiteColor;

	[self.view addSubview:_chooseUserView];
	[[_chooseUserView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor] setActive:YES];
	[[_chooseUserView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor] setActive:YES];
	[[_chooseUserView.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor] setActive:YES];

	[_chooseUserView.button addTarget:self action:@selector(didTouchUp:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTouchUp:(UIButton *)button {
	PostsTableViewController *postsViewController = [PostsTableViewController.alloc initWithUsername:_chooseUserView.input.text];
	[self.navigationController pushViewController:postsViewController animated:YES];
}


@end
