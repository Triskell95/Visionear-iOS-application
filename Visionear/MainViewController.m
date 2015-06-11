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
    
    visionearImg.frame = CGRectMake(0, 0, 100, 100);
    visionearImg.center = visionearImg.superview.center;
    
    //Setting of the SSH connection
    hostIP = [NSString stringWithFormat:@"10.35.23.1"];
    username = [NSString  stringWithFormat:@"pi"];
    
    //Setting of the before the connection times out
    timeoutDelay = [[NSNumber alloc] initWithFloat:5.0];
    
    //Setting the alert
    alert2 = [[UIAlertView alloc] initWithTitle:@"Establishing Connection\rPlease wait..."message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
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
    
    //Display loading AlertView
    [alert2 show];
    
    [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:delay ];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

-(IBAction)handleSingleTap
{
    NSLog(@"Main Screen Tapped !");
    
    //Connection to the Raspberry
    [self connectToRasp];
    
    //If everuthing is OK with the SSH session
    if(flag){
        [alert2 dismissWithClickedButtonIndex:0 animated:YES];
        [self performSegueWithIdentifier:@"NextView" sender:self];
    }
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
            
            //If there's no new file (number of images on the RPi and in the imgMainArray), don't need to download again
            if(resultBash.integerValue == imgMainArray.count) {
                
                NSLog(@"\r\rNo new file !\r\r");
                
            }
            //Have to download new files
            else {
                nbRows = resultBash.integerValue;
            
                //Dismiss the loading alert
                NSLog(@"Connection authorized");
                [alert2 dismissWithClickedButtonIndex:0 animated:YES];
            
                //resultBash = [session.channel execute:@"ls Desktop/" error:&error];
                //NSLog(@"\r\rls Desktop/: \r%@\r\r", resultBash);
            
                fileMainArray = [[NSMutableArray alloc] initWithCapacity:nbRows];
                imgMainArray = [[NSMutableArray alloc] initWithCapacity:nbRows];
            
                //Loading the file and image arrays
                for(int i = nbRows; i > 0; i--){
                
                    //Default path to reach to download an image and its description file from the RPi
                    imgPathToDl = [NSString stringWithFormat:@"Desktop/visionearImg%i", i];
                    imgFile = [NSString stringWithFormat:@"Desktop/visionearFile%i", i];
            
                    //Command to execute to get the image file corresponding to 'imgFile' and display it in the label
                    cmd = [NSString stringWithFormat: @"cat %@", imgFile];
                    NSLog(@"Command to execute:\r%@", cmd);
                    resultBash = [session.channel execute:cmd error:&error];
                    NSLog(@"Result of the Command: %@\r\r", resultBash);
                    [fileMainArray addObject:resultBash];
                    //[imgMainArray addObject:imgPathToDl];
                
                    [self downloadImgFromRPi:[NSString stringWithFormat:@"Image%i.png", i]];
                }
            }
            NSLog(@"Tableau:\r%@\r\r", fileMainArray);
        }
        //Else => alert to inform it failed
        else {
            flag = NO;
            [alert2 dismissWithClickedButtonIndex:0 animated:YES];
            UIAlertView *alertFail = [[UIAlertView alloc] initWithTitle:@"Connection Rejected !\rSomething went wrong..."message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertFail show];
            
        }
    }
    //Else => alert to inform it failed
    else {
        flag = NO;
        [alert2 dismissWithClickedButtonIndex:0 animated:YES];
        UIAlertView *alertFail = [[UIAlertView alloc] initWithTitle:@"Connection timed out!\rPlease check\ryou are connected to\rRPi_CastLab"message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertFail show];
    }
    
    [session disconnect];
}

-(void)downloadImgFromRPi:(NSString *) name{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    
    flag = [session.channel downloadFile:imgPathToDl to:filePath];
    
    //If the download has been done successfully, display the image on the screen
    if(flag){
        
        UIImage *image;
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        [imgMainArray addObject:name];
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
