//
//  PostsTableViewController.m
//  Tumblr client
//
//  Created by Dominik Ostrowski on 26.06.2018.
//  Copyright © 2018 Dominik Ostrowski. All rights reserved.
//

#import "PostsTableViewController.h"
#import "TumblrClient.h"
#import "Post.h"
#import "PostCell.h"
#import "RegularPostCell.h"
#import "RegularPost.h"
#import "PhotoPostCell.h"
#import "PhotoPost.h"
#import "PhotoPostViewModel.h"
#import "RegularPostViewModel.h"

@interface PostsTableViewController ()

@end

@implementation PostsTableViewController {
	NSString *_username;
	TumblrClient *_tumblrClient;
	NSArray<Post *> *_posts;
	NSMapTable<Post *, PostViewModel *> *_viewModelCache;
}

- (instancetype)initWithUsername:(NSString *)username {
	self = super.init;

	if (self) {
		_username = username;
		_tumblrClient = [TumblrClient.alloc initWithDelegate:self];
		_viewModelCache = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory
												valueOptions:NSMapTableStrongMemory];
	}

	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.estimatedRowHeight = 150;
    self.tableView.dataSource = self;
	[self.tableView registerClass:PhotoPostCell.class forCellReuseIdentifier:@"photoPostCell"];
	[self.tableView registerClass:RegularPostCell.class forCellReuseIdentifier:@"regularPostCell"];
	[_tumblrClient requestPostsForUser:_username
							withOffset:@0
								  size:@50];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _posts.count;
}

- (void)tumblrClient:(TumblrClient *)client didFailWithError:(NSError *)error {

	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
																   message:error.localizedDescription
															preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
														  handler:^(UIAlertAction * action) {}];

	[alert addAction:defaultAction];

	[self presentViewController:alert animated:YES completion:nil];
}

- (void)tumblrClient:(TumblrClient *)client
			gotPosts:(NSArray<Post *> *)posts
		  withOffset:(NSNumber *)offset
			 andSize:(NSNumber *)size {
	[_viewModelCache removeAllObjects];
	_posts = posts;
	[self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Post *post = _posts[(NSUInteger) indexPath.row];

	PostViewModel *viewModel;
	PostCell *cell;

	if ([post isKindOfClass:PhotoPost.class]) {
		PhotoPost *photoPost = (PhotoPost *) post;
		PhotoPostCell *photoCell  = [tableView dequeueReusableCellWithIdentifier:@"photoPostCell" forIndexPath:indexPath];
		void (^photoUpdateBlock)(UIImage *) = ^(UIImage *image){
			//[tableView beginUpdates];
			photoCell.photoView.image = image;
			//[tableView endUpdates];
		};

		PhotoPostViewModel *photoViewModel = (PhotoPostViewModel *) [_viewModelCache objectForKey:post];
		if (photoViewModel == nil) {
			photoViewModel = [PhotoPostViewModel.alloc initWithPhotoPost:photoPost
													 photoAvailableBlock:photoUpdateBlock];
			[_viewModelCache setObject:photoViewModel forKey:post];
		}
		photoUpdateBlock(photoViewModel.photo);

		cell = photoCell;
		viewModel = photoViewModel;
	} else if ([post isKindOfClass:RegularPost.class]) {
		RegularPost *regularPost = (RegularPost *) post;
		RegularPostCell *regularCell = [tableView dequeueReusableCellWithIdentifier:@"regularPostCell" forIndexPath:indexPath];
		RegularPostViewModel *regularViewModel = (RegularPostViewModel *) [_viewModelCache objectForKey:post];
		if (regularViewModel == nil) {
			regularViewModel = [RegularPostViewModel.alloc initWithRegularPost:regularPost];
			[_viewModelCache setObject:regularViewModel forKey:post];
		}
		regularCell.contentLabel.attributedText = regularViewModel.contentText;

		cell = regularCell;
		viewModel = regularViewModel;
	} else {
		viewModel = [PostViewModel.alloc initWithPost:post];
		cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
	}

	cell.tagsLabel.text = viewModel.tags;
	cell.titleView.attributedText = viewModel.titleText;
	cell.dateLabel.text = viewModel.dateString;

	return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
