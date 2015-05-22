//
//  UpdateViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/22/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "UpdateViewController.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController

UIAlertView *alert;
UIActivityIndicatorView *indicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    alert = [[UIAlertView alloc] initWithTitle:@"Update in progress\nPlease wait ..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //[indicator initWithFrame:CGRectMake(0, 0, alert.bounds.size.width / 2, alert.bounds.size.height)];
    //indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);

    [alert addSubview:indicator];
    [alert bringSubviewToFront:indicator];
    indicator.hidden = NO;
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    
}

//To detect if the screen is tapped or not
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSUInteger numTaps = [[touches anyObject] tapCount];
    float delay = 0.1;
    
    //If the screen is single tapped
    //if (numTaps < 2)
    //{
    [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:delay ];
    [self.nextResponder touchesEnded:touches withEvent:event];
    //}
    /*else if(numTaps == 2)
     {
     [NSObject cancelPreviousPerformRequestsWithTarget:self];
     [self performSelector:@selector(handleDoubleTap) withObject:nil afterDelay:delay ];
     }*/
}

-(IBAction)handleSingleTap
{
    NSLog(@"Update Screen Tapped !");
   
    [indicator startAnimating];
    [alert show];
    
    //To activate after a while loop when we will have something to update/load
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    
    //For the moment, we don't have something to load, so the alert will stay for a few seconds
    [self performSelector:@selector(dismissAlertView:) withObject:alert afterDelay:3];

}

-(void)dismissAlertView:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [indicator stopAnimating];
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
