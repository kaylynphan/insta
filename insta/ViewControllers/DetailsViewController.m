//
//  DetailsViewController.m
//  insta
//
//  Created by Kaylyn Phan on 6/28/22.
//

#import "DetailsViewController.h"
#import <Parse/Parse.h>
#import "PFImageView.h"
#import "DateTools.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property PFFileObject *photoFile;
@property (weak, nonatomic) IBOutlet PFImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
- (IBAction)didTapLikeButton:(id)sender;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillView:self.post];
}

- (void)fillView:(Post *)post {
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
    self.userLabel.text = [NSString stringWithFormat:@"@%@", post.author.username];
    self.captionLabel.text = [NSString stringWithFormat:@"@%@: %@", post.author.username, post[@"caption"]];
    
    //NSLog(@"Created at: %@", post[@"createdAt"]);
    
    NSDate *date = post.createdAt;
    NSString *dateSince = date.shortTimeAgoSinceNow;
            
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/yyyy";
    NSLog(@"dateSince: %@", dateSince);
    
    if (([dateSince containsString:@"d"] ||
         [dateSince containsString:@"w"] ||
         [dateSince containsString:@"M"] ||
         [dateSince containsString:@"y"])) {
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        self.timestampLabel.text = [formatter stringFromDate:date];
    } else {
        self.timestampLabel.text = [NSString stringWithFormat:@"%@ ago", dateSince];
    }
    self.likesLabel.text = [NSString stringWithFormat:@"%@ likes", post[@"likeCount"]];
    self.commentsLabel.text = [NSString stringWithFormat:@"%@ comments", post[@"commentCount"]];
    
    if (self.likedByCurrentUser) {
        [self.likeButton setImage:[UIImage imageNamed:@"heart-red"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapLikeButton:(id)sender {
}
@end
