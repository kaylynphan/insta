//
//  DetailsViewController.h
//  insta
//
//  Created by Kaylyn Phan on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) Post *post;
@property (assign, nonatomic) BOOL likedByCurrentUser;

- (void)fillView:(Post *)post;

@end

NS_ASSUME_NONNULL_END
