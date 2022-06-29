//
//  PostCell.m
//  insta
//
//  Created by Kaylyn Phan on 6/27/22.
//

#import "PostCell.h"
#import "Post.h"

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
    
    // crop into circle frame
    self.profileImageView.layer.cornerRadius = CGRectGetHeight(self.profileImageView.frame) / 2;
        self.profileImageView.clipsToBounds = YES;
}
@end
