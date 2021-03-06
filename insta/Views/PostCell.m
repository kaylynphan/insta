//
//  PostCell.m
//  insta
//
//  Created by Kaylyn Phan on 6/27/22.
//

#import "PostCell.h"
#import "Post.h"
#import <Parse/Parse.h>
#import "Like.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];    
    // Configure the view for the selected state
}

- (void)setPost:(Post *)post withLike:(BOOL)like {
    _post = post;
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
    self.userLabel.text = [NSString stringWithFormat:@"@%@", post.author.username];
    self.captionLabel.text = [NSString stringWithFormat:@"@%@: %@", post.author.username, post[@"caption"]];
    //self.captionLabel.text = post[@"caption"];
    self.profileImageView.file = post.author[@"profileImage"];
    [self.profileImageView loadInBackground];
    self.likedByCurrentUser = like;
    
    if (like) {
        [self.likeButton setImage:[UIImage imageNamed:@"heart-red"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    }
    
    // get all the people who have liked this post
    /*
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Like"];
    [query whereKey:@"postLiked" equalTo:_post.objectId];
     */
    
    // crop into circle frame
    self.profileImageView.layer.cornerRadius = CGRectGetHeight(self.profileImageView.frame) / 2;
        self.profileImageView.clipsToBounds = YES;
}

- (IBAction)didTapLikeButton:(id)sender {
    PFUser *user = [PFUser currentUser];
    PFObject *post = _post;
    /*
     // if the post was not liked already...
     
     
     */
    Like *newLike = [Like new];
    newLike.likedByUser = user;
    newLike.postLiked = post;
    [newLike saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"Post Liked!");
            [self.likeButton setImage:[UIImage imageNamed:@"heart-red"] forState:UIControlStateNormal];
        }
    }];
    
}
@end
