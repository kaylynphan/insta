//
//  HomeFeedViewController.m
//  insta
//
//  Created by Kaylyn Phan on 6/27/22.
//

#import "HomeFeedViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "../Models/Post.h"
#import "../Views/PostCell.h"

@interface HomeFeedViewController ()
- (IBAction)didTapLogout:(id)sender;
@property (strong, nonatomic) NSArray *arrayOfPosts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 2;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            NSLog(@"%@", posts);
            self.arrayOfPosts = posts;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    // set up table
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.arrayOfPosts = [[NSArray alloc] init];
    
    // reload feed data
    [self.tableView reloadData];
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    self.view.window.rootViewController = loginViewController;
    // logout user
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"Logout Successful");
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    PFObject *post = self.arrayOfPosts[indexPath.row];
    cell.userLabel.text = @"Fill this in later"; //change to post[@"userID"]
    cell.captionLabel.text = post[@"caption"];
    PFFileObject *imageFile = post[@"image"];
    NSData *imageData = [imageFile getDataInBackground];
    cell.postImage.image = [UIImage imageWithData:imageData];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}


@end
