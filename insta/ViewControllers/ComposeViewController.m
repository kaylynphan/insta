//
//  ComposeViewController.m
//  insta
//
//  Created by Kaylyn Phan on 6/27/22.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()
- (IBAction)didTapCancel:(id)sender;
- (IBAction)didTapShare:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapShare:(id)sender {
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
