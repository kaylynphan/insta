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
#import "Post.h"
#import "DetailsViewController.h"
#import "ComposeViewController.h"
#import "InfiniteScrollActivityView.h"

@interface HomeFeedViewController ()
- (IBAction)didTapLogout:(id)sender;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (weak, nonatomic) InfiniteScrollActivityView* loadingMoreView;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 5;
    
    // set up refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];


    // set up table
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.arrayOfPosts = [[NSArray alloc] init];
    [self queryPosts:query];
    
    // set up infinite scroll
    self.isMoreDataLoading = false;
    // Set up Infinite Scroll loading indicator
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.tableView addSubview:self.loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableView.contentInset = insets;
}

- (void)queryPosts:(PFQuery *)query {
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // append the posts to the array of posts
            self.arrayOfPosts = [self.arrayOfPosts arrayByAddingObjectsFromArray:posts];
            //self.arrayOfPosts = posts; // this is being replaced
            NSLog(@"%@", self.arrayOfPosts);
            
            // do these actions just in case we are performing infinite scroll
            // Update flag
            self.isMoreDataLoading = false;
            // Stop the loading indicator
            [self.loadingMoreView stopAnimating];
            
            // reload data
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}



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
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.post = post;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            
            // Update position of loadingMoreView, and start loading indicator
            CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
            self.loadingMoreView.frame = frame;
            [self.loadingMoreView startAnimating];
            
            // ... Code to load more results ...
            PFQuery *query = [PFQuery queryWithClassName:@"Post"];
            [query orderByDescending:@"createdAt"];
            [query includeKey:@"author"];
            query.limit = 5;
            query.skip = self.arrayOfPosts.count;
            [self queryPosts:query];
        }
    }
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 5;
    // re-query posts and update table view
    [self queryPosts:query];
    [refreshControl endRefreshing];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetails"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:cell];
        // Get the new view controller using [segue destinationViewController].
        Post *postToPass = self.arrayOfPosts[myIndexPath.row];
        // Pass the selected object to the new view controller.
        DetailsViewController *detailVC = [segue destinationViewController];
        detailVC.post = postToPass;
    } else if ([[segue identifier] isEqualToString:@"composePost"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    }
    
}


@end
