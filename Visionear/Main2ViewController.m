//
//  Main2ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Main2ViewController.h"
#import "NMSSH/NMSSH.h"

@interface Main2ViewController ()

@end

@implementation Main2ViewController

@synthesize backButton;

UIAlertView *alert2;
NMSSHSession *session;
NSNumber *timeoutDelay;
BOOL flagDelay;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIAlertView
    alert2 = [[UIAlertView alloc] initWithTitle:@"Establishing Connection\rPlease wait..."message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert2 show];
    
    timeoutDelay = [[NSNumber alloc] initWithFloat:5.0];
    
    //[self connectToRasp];
    
}

-(void)viewDidAppear:(BOOL)animated {

    [self connectToRasp];

}

-(void)connectToRasp {
    
    session = [[NMSSHSession alloc] initWithHost:@"10.35.23.1:22" andUsername:@"pi"];
    flagDelay = [session connectWithTimeout:timeoutDelay];
    
    if (session.isConnected) {
        [session authenticateByPassword:@"raspberry"];
        
        if (session.isAuthorized) {
           
            
            
            NSLog(@"Connection authorized");
            [alert2 dismissWithClickedButtonIndex:0 animated:YES];
            
        }
        else {
            [alert2 dismissWithClickedButtonIndex:0 animated:YES];
            UIAlertView *alertFail = [[UIAlertView alloc] initWithTitle:@"Connection Rejected ! Something went wrong..."message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertFail show];
            
        }
    }
    else {
        [alert2 dismissWithClickedButtonIndex:0 animated:YES];
        
        UIAlertView *alertFail = [[UIAlertView alloc] initWithTitle:@"Connection timed out!\rPlease check\ryou are connected to\rRPi_CastLab"message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertFail show];
    }
}

- (IBAction)backPressed:(id)sender {
    
    NSLog(@"Back pressed, you'll be disconnected !");
    [session disconnect];

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
