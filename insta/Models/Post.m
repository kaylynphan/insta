//
//  Post.m
//  insta
//
//  Created by Kaylyn Phan on 6/27/22.
//

#import "Post.h"

@implementation Post
    
    @dynamic postID;
    @dynamic userID;
    @dynamic caption;
    @dynamic image;

    + (nonnull NSString *)parseClassName {
        return @"Post";
    }
    
@end
