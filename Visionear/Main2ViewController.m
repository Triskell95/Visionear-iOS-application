//
//  Main2ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Main2ViewController.h"
#import "NMSSH/NMSSH.h"
#import "NMSSH/NMSSHChannel.h"

@interface Main2ViewController () <NMSSHChannelDelegate, NMSSHSessionDelegate>

@end

@implementation Main2ViewController

@synthesize backButton, labelMain2, imgMain2;

UIAlertView *alert2;
NMSSHSession *session;
NSNumber *timeoutDelay;
BOOL flagDelay, flag;
int r;
NSString *hostIP, *username;
NSString *imgPathToDl, *imgFile;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIAlertView
    alert2 = [[UIAlertView alloc] initWithTitle:@"Establishing Connection\rPlease wait..."message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert2 show];
    
    //Setting of the SSH connection
    hostIP = [NSString stringWithFormat:@"10.35.23.1"];
    username = [NSString  stringWithFormat:@"pi"];
    
    //Setting of the before the connection times out
    timeoutDelay = [[NSNumber alloc] initWithFloat:5.0];

    labelMain2.hidden = YES;
    imgMain2.hidden = YES;
}

//When the view is loaded
-(void)viewDidAppear:(BOOL)animated {

    //Connection to the Raspberry
    [self connectToRasp];

}

-(void)connectToRasp {
    
    NSString *resultBash = [NSString alloc];
    labelMain2.hidden = NO;
    
    //Setting the SSH connection
    session = [[NMSSHSession alloc] initWithHost:hostIP andUsername:username];
    flagDelay = [session connectWithTimeout:timeoutDelay];
    
    //When the connection is established
    if (session.isConnected) {
        [session authenticateByPassword:@"raspberry"];
        
        //If the logging step is done
        if (session.isAuthorized) {
 
            NSError *error;
            NSString *cmd;
            
            //TO DELETE !!! Random number generated to switch between to photos to test everything is OK
            //WATCH OUT ! There are references to 'r' variable in imgPathToDl, imgFile and filePath (connectToRasp method)
            //DON'T FORGET TO DELETE ALL THESE REFERENCES WHEN THE HARDWARE WILL BE OK !!!
           
            cmd = [NSString stringWithFormat: @"ls -1 Desktop/ | grep \"visionearImg\"| wc -l"];
            resultBash = [session.channel execute:cmd error:&error];
            r = arc4random() % resultBash.integerValue;
            r += 1;
            NSLog(@"Random number generated: %i", r);
            //Seriously, DON'T FORGET !!!
            
            //Default path to reach to download an image and its description file from the RPi
            imgPathToDl = [NSString stringWithFormat:@"Desktop/visionearImg%i", r];
            imgFile = [NSString stringWithFormat:@"Desktop/visionearFile%i", r];

            
            //Dismiss the loading alert
            NSLog(@"Connection authorized");
            [alert2 dismissWithClickedButtonIndex:0 animated:YES];
            resultBash = [session.channel execute:@"ls Desktop/" error:&error];
            NSLog(@"\r\rls Desktop/: \r%@\r\r", resultBash);

            //Command to execute to get the image file corresponding to 'imgFile' and display it in the label
            cmd = [NSString stringWithFormat: @"cat %@", imgFile];
            NSLog(@"Command to execute:\r%@", cmd);
            resultBash = [session.channel execute:cmd error:&error];
            labelMain2.text = [NSString stringWithFormat:@"%@",resultBash];
            
            [self downloadImgFromRPi];
            
        }
        //Else => alert to inform it failed
        else {
            [alert2 dismissWithClickedButtonIndex:0 animated:YES];
            UIAlertView *alertFail = [[UIAlertView alloc] initWithTitle:@"Connection Rejected !\rSomething went wrong..."message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertFail show];
            
        }
    }
    //Else => alert to inform it failed
    else {
        [alert2 dismissWithClickedButtonIndex:0 animated:YES];
        
        UIAlertView *alertFail = [[UIAlertView alloc] initWithTitle:@"Connection timed out!\rPlease check\ryou are connected to\rRPi_CastLab"message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertFail show];
    }
}

-(void)downloadImgFromRPi{
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat: @"Image%i.png", r]];
    
    flag = [session.channel downloadFile:imgPathToDl to:filePath];
    
    //If the download has been done successfully, display the image on the screen
    if(flag){
        
        UIImage *image;
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        imgMain2.hidden = NO;
        imgMain2.image = [UIImage imageNamed:filePath];
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
