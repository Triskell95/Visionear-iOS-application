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

int cmpt_test;
UIAlertView *alert;
UIActivityIndicatorView *indicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    alert = [[UIAlertView alloc] initWithTitle:@"Update in progress\nPlease wait ..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    [alert addSubview:indicator];
    [alert bringSubviewToFront:indicator];
    indicator.hidden = NO;
    
    cmpt_test = 0;
    
}

//To detect if the screen is tapped or not
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    float delay = 0.1;
    [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:delay ];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

//Action if the screen is tapped
-(IBAction)handleSingleTap
{
    NSLog(@"Update Screen Tapped !");
   
    [indicator startAnimating];
    [alert show];
    [self performSelector:@selector(dismissAlertView:) withObject:alert afterDelay:3];

}

//Dismiss the 1st alert, test if the update has been correctly done and display the next alert
-(void)dismissAlertView:(UIAlertView *)alertView{
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [indicator stopAnimating];
    
    UIAlertView *alert2;
    
    //Test of the 2 possible cases after trying to update (CONDITIONS TO CHANGE when the loading and the connection will be established)
    if(cmpt_test %2 == 0){
        //Popup: Everything is OK !
        alert2 = [[UIAlertView alloc] initWithTitle:@"Updated succefully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    else {
        //Popup: Update failled !
        alert2 = [[UIAlertView alloc] initWithTitle:@"Update failled" message:@"Check your internet connection please !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    cmpt_test ++;
    [alert2 show];
    
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
