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

- (void)setPost:(Post *)post {
    _post = post;
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
    self.userLabel.text = post.author.username;
    self.captionLabel.text = post[@"caption"];
    self.profileImageView.file = post.author[@"profileImage"];
    [self.profileImageView loadInBackground];
    
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
    // if the post was not liked already...
    Like *newLike = [Like new];
    newLike.likedByUser = user;
    newLike.postLiked = post;
    
    
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    [newPost saveInBackgroundWithBlock: completion];
    
}
@end
