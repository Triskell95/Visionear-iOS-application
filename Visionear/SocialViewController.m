//
//  SocialViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/27/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "SocialViewController.h"

@interface SocialViewController ()

@end

@implementation SocialViewController 

@synthesize socialLabel, imgSocial, buttonSocial;

UIActivityIndicatorView *socialIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    socialIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    socialIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:socialIndicator];
    
    socialLabel.hidden = YES;
    imgSocial.hidden = YES;
    buttonSocial.hidden = YES;
    
    socialIndicator.hidden = NO;
    [socialIndicator startAnimating];
    [socialIndicator stopAnimating];
    socialIndicator.hidden = YES;
    
    socialLabel.hidden = NO;
    imgSocial.hidden = NO;
    buttonSocial.hidden = NO;
       */
    UIAlertView  *waitAlert = [[UIAlertView alloc] initWithTitle:@"Please Wait...." message:@"\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    progress.color = [UIColor blackColor];
    [waitAlert addSubview: progress];
    [progress startAnimating];
    [waitAlert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
