//
//  Like.h
//  insta
//
//  Created by Kaylyn Phan on 6/29/22.
//

#import <Parse/Parse.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Like : PFObject<PFSubclassing>
@property (nonatomic, strong) Post *postLiked;
@property (nonatomic, strong) PFUser *likedByUser;

@end

NS_ASSUME_NONNULL_END
