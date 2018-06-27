//
//  PostsTableViewController.h
//  Tumblr client
//
//  Created by Dominik Ostrowski on 26.06.2018.
//  Copyright © 2018 Dominik Ostrowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TumblrClientDelegate.h"

@interface PostsTableViewController : UITableViewController <TumblrClientDelegate>

- (instancetype)initWithUsername:(NSString *)username;

@end
