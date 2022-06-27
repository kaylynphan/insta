//
//  HomeFeedViewController.m
//  insta
//
//  Created by Kaylyn Phan on 6/27/22.
//

#import "HomeFeedViewController.h"
#import "../AppDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "../Models/Post.h"

@interface HomeFeedViewController ()
- (IBAction)didTapLogout:(id)sender;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // try uploading a Post
    /*
    Post *post = [Post new];
    post.postID = @"00000001";
    post.userID = @"kaylynphan";
    post.caption = @"trying to upload a post";
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"The test Post has been saved.");
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
     */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    self.view.window.rootViewController = loginViewController;
    // logout user
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}

@end
