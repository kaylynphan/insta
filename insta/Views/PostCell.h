//
//  PostCell.h
//  insta
//
//  Created by Kaylyn Phan on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;
@property (strong, nonatomic) Post *post;

- (void)setPost:(Post *)post;

@end

NS_ASSUME_NONNULL_END
