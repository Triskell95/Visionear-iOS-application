//
//  FirstViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 4/30/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "MainViewController.h"
#import "Global.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize startButton;
@synthesize visionearLabel;
@synthesize visionearImg;
@synthesize navBar;

UIAlertView *alert2;
NSNumber *timeoutDelay;
BOOL flagDelay, flag;
NSString *imgPathToDl, *imgFile;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set size and position of the Visionear Image 
    visionearImg.frame = CGRectMake(0, 0, 100, 100);
    visionearImg.center = visionearImg.superview.center;
    
    //Setting of the before the connection times out
    timeoutDelay = [[NSNumber alloc] initWithFloat:5.0];
    
    //Setting the alert
    alert2 = [[UIAlertView alloc] initWithTitle:@"Establishing Connection\rPlease wait..."message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Just before the view appears, to set the navigationBar hidden
- (void)viewWillAppear:(BOOL)animated {
    //Hide the NavigationBar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

//To detect if the screen is tapped or not
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //NSUInteger numTaps = [[touches anyObject] tapCount];
    float delay = 0.1;
    
    //Display loading AlertView
    [alert2 show];
    
    [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:delay ];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

//When the event is a single tap
-(IBAction)handleSingleTap {
    NSLog(@"Main Screen Tapped !");
    
    //Connection to the Raspberry
    [self connectToRasp];
    
    //If everything is OK with the SSH session
    if(flag){
        [alert2 dismissWithClickedButtonIndex:0 animated:YES];
        [self performSegueWithIdentifier:@"NextView" sender:self];
    }
    else {
        flag = YES;
    }
}

//Check the connection with the RPi and download the new images
-(void)connectToRasp {
    
    NSString *resultBash = [NSString alloc];
    
    flagDelay = [session connectWithTimeout:timeoutDelay];
    
    //When the connection is established
    if (session.isConnected) {
        [session authenticateByPassword:pwd];
        
        //If the logging step is done
        if (session.isAuthorized) {
            
            NSError *error;
            NSString *cmd;
            
            //Counting the number of images on the RPi
            cmd = [NSString stringWithFormat: @"ls -1 %@ | grep %@ | wc -l", defaultImgPathToDl, defaultImgName];
            
            resultBash = [session.channel execute:cmd error:&error];
            NSLog(@"Number of images: %@\r\r", resultBash);
            
            //If there's no new file (number of images on the RPi and in the imgMainArray), don't need to download again
            if(resultBash.integerValue == imgMainArray.count) {
                
                NSLog(@"\r\rNo new file !\r\r");
                
            }
            //Have to download new files
            else {
                nbRows = resultBash.integerValue;
            
                //Dismiss the loading alert
                NSLog(@"Connection authorized\r\r");
                [alert2 dismissWithClickedButtonIndex:0 animated:YES];
            
                //resultBash = [session.channel execute:@"ls Desktop/" error:&error];
                //NSLog(@"\r\rls Desktop/: \r%@\r\r", resultBash);
            
                fileMainArray = [[NSMutableArray alloc] initWithCapacity:nbRows];
                imgMainArray = [[NSMutableArray alloc] initWithCapacity:nbRows];
            
                //Loading the file and image arrays
                for(int i = nbRows; i > 0; i--){
                
                    //Counting the number of images on the RPi
                    cmd = [NSString stringWithFormat: @"ls -1 %@ | grep %@ | head -n +%i | tail -n -1 | head -c -1", defaultImgPathToDl, defaultImgName, i];
                    resultBash = [session.channel execute:cmd error:&error];
                    
                    if(i == nbRows) {
                        NSString *cmd2;
                        cmd2 = [NSString stringWithFormat: @"ls -1 %@ | grep %@ | head -n +%i | tail -n -1 | head -c -1 | tail -c +%i", defaultImgPathToDl, defaultImgName, i, defaultImgName.length+1];
                        maxIndex = [session.channel execute:cmd2 error:&error].intValue;
                        //NSLog(@"\r\rMax number: %i\r\r", maxIndex);
                    }
                    
                    //Default path to reach to download an image and its description file from the RPi
                    imgPathToDl = [NSString stringWithFormat:@"%@%@",defaultImgPathToDl, resultBash];
                    NSLog(@"imgPathToDl[%i] = %@", i, imgPathToDl);
                    
                    //To set the name of the image in the next view label
                    [fileMainArray addObject:imgPathToDl];
                    
                    [self downloadImgFromRPi:[NSString stringWithFormat:@"%@.png", resultBash] file:imgPathToDl];
                }
            }
            
            //NSLog(@"Tableau:\r%@\r\r", fileMainArray);
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

}

//Download an image from the RPi
-(void)downloadImgFromRPi:(NSString *) name file:(NSString *)fileName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        flag = [session.channel downloadFile:fileName to:filePath];
        if(flag){
            //If the download has been done successfully, save the image locally
            UIImage *image;
            [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        }
        NSLog(@"%@ downloaded !", name);
    }
    NSLog(@"Name: %@ with flag: %hhd\r", name, flag);
    
    
    [imgMainArray addObject:name];
}

@end
