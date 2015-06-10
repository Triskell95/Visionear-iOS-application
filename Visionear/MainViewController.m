//
//  FirstViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 4/30/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "MainViewController.h"
#import "NMSSH/NMSSH.h"
#import "NMSSH/NMSSHChannel.h"
#import "Global.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize startButton;
@synthesize visionearLabel;
@synthesize visionearImg;

UIAlertView *alert2;
NMSSHSession *session;
NSNumber *timeoutDelay;
BOOL flagDelay, flag;
NSString *hostIP, *username;
NSString *imgPathToDl, *imgFile;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    //Start buttom customization
    [[startButton layer] setBorderWidth:1.0f];
    [[startButton layer] setBorderColor:[UIColor blackColor].CGColor];
    startButton.layer.cornerRadius = 20; // this value vary as per your desire
    startButton.clipsToBounds = YES;
    */
    visionearImg.frame = CGRectMake(0, 0, 100, 100);
    visionearImg.center = visionearImg.superview.center;
    
    
    
    //Visionear label customization THSarabunNew
    //[[self visionearLabel] setFont:[UIFont fontWithName:@"THSarabunNew" size:70]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"Main Screen Tapped !");
    
    //UIAlertView
    alert2 = [[UIAlertView alloc] initWithTitle:@"Establishing Connection\rPlease wait..."message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert2 show];
    
    //Setting of the SSH connection
    hostIP = [NSString stringWithFormat:@"10.35.23.1"];
    username = [NSString  stringWithFormat:@"pi"];
    
    //Setting of the before the connection times out
    timeoutDelay = [[NSNumber alloc] initWithFloat:5.0];

    [self performSegueWithIdentifier:@"NextView" sender:self];
}

-(void)handleDoubleTap
{
    NSLog(@"tapCount 2");
}

-(void)connectToRasp {
    
    NSString *resultBash = [NSString alloc];
    
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
            
            cmd = [NSString stringWithFormat: @"ls -1 Desktop/ | grep \"visionearImg\"| wc -l"];
            resultBash = [session.channel execute:cmd error:&error];
            nbRows = resultBash.integerValue;
            
            //Default path to reach to download an image and its description file from the RPi
            //imgPathToDl = [NSString stringWithFormat:@"Desktop/visionearImg%i", r];
            //imgFile = [NSString stringWithFormat:@"Desktop/visionearFile%i", r];
            
            
            //Dismiss the loading alert
            NSLog(@"Connection authorized");
            [alert2 dismissWithClickedButtonIndex:0 animated:YES];
            
            resultBash = [session.channel execute:@"ls Desktop/" error:&error];
            NSLog(@"\r\rls Desktop/: \r%@\r\r", resultBash);
            
            //Command to execute to get the image file corresponding to 'imgFile' and display it in the label
            cmd = [NSString stringWithFormat: @"cat %@", imgFile];
            NSLog(@"Command to execute:\r%@", cmd);
            resultBash = [session.channel execute:cmd error:&error];
            //labelMain2.text = [NSString stringWithFormat:@"%@",resultBash];
            
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
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat: @"Image%i.png", 1]];
    
    flag = [session.channel downloadFile:imgPathToDl to:filePath];
    
    //If the download has been done successfully, display the image on the screen
    if(flag){
        
        UIImage *image;
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        //imgMain2.image = [UIImage imageNamed:filePath];
    }
}

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MySegueName"])
    {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
    }
}*/

@end
