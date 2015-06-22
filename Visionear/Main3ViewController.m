//
//  Main3ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 6/10/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Main3ViewController.h"
#import "Global.h"
#import "Main2ViewController.h"

@interface Main3ViewController ()

@end

@implementation Main3ViewController

@synthesize indexFromSegue;
@synthesize imgView, labelDesc;
@synthesize img;
@synthesize scroll;
@synthesize navBar3;
@synthesize tabBar3;

BOOL flagHide = NO;
//float ratio;
CGRect originalFrame;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Settings of the NavigationBar (2nd line permits not to push all the element of the view down)
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //Settings of the imageView
    imgView.image = img;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.userInteractionEnabled = YES;
    [self.view sendSubviewToBack:imgView];
    
    //Settings of the scrollView
    [scroll setMaximumZoomScale:5.0f];
    [scroll setClipsToBounds:YES];
    [self.view sendSubviewToBack:scroll];
    
    //Settings of the LongPressGestureRecognition
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onPress:)];
    [self.view addGestureRecognizer:recognizer];
    
    //Settings of the SingleTapGestureRecognition
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [imgView addGestureRecognizer:singleTap];
    
    //Save the size and position of the tabBar because the only way to "hide" it is to send it far away
    originalFrame = self.tabBarController.tabBar.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Permits to zoom on the imageview
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return imgView;
}

//When there is a long press gesture done by the user
- (void)onPress:(UILongPressGestureRecognizer*)longpress {
    
    if (longpress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Long press");
        [self showActionSheet:@"id"];
    }
    else if (longpress.state == UIGestureRecognizerStateEnded || longpress.state == UIGestureRecognizerStateCancelled || longpress.state == UIGestureRecognizerStateFailed) {
        NSLog(@"Long press finished/failed");
    }
}

//When a single tap is performed by the user
-(void)tapDetected{
    
    NSLog(@"single Tap on imageview");
    
    //Settings of the view depending on the actual state of it
    if(flagHide){
        flagHide = NO;
        self.view.backgroundColor = [UIColor whiteColor];
        [self showTabBar:self.tabBarController];
    }
    else {
        flagHide = YES;
        self.view.backgroundColor = [UIColor blackColor];
        [self hideTabBar:self.tabBarController];
    }
    
    //Display or dismiss the navigationBar following the actual state
    [self.navigationController setNavigationBarHidden:flagHide animated:NO];
}

//"Hide" the TabBar
- (void)hideTabBar:(UITabBarController *) tabbarcontroller {
    //[UIView beginAnimations:nil context:NULL];
    //[UIView setAnimationDuration:0.5];
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        //Send the TabBar far away to "hide it"
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, originalFrame.origin.y+500, view.frame.size.width, view.frame.size.height)];
        }
    }
    //[UIView commitAnimations];
}

//"Show" the TabBar
- (void)showTabBar:(UITabBarController *) tabbarcontroller {
    //[UIView beginAnimations:nil context:NULL];
    //[UIView setAnimationDuration:0.5];
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        //Send back the TabBar to its original position
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, originalFrame.origin.y, view.frame.size.width, view.frame.size.height)];
        }
    }
    //[UIView commitAnimations];
}

//If the user click on the Action Button on the right of the Navigation Bar
- (IBAction)ActionButton:(id)sender {
   [self showActionSheet:@"id"];
}

//Show a sheet menu from the bottom of the view to perform more actions
-(IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"What do you want to do with this picture ?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Save", @"Share on Facebook", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self.view];
}

//Manage all the actions possible with the sheet menu
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:{
            NSLog(@"Delete Button Clicked");
            NSString *cmd;
            NSString *resultBash;
            NSError *error;
            
            //Counting the number of images on the RPi
            cmd = [NSString stringWithFormat: @"rm %@", [fileMainArray objectAtIndex:indexFromSegue]];
            resultBash = [session.channel execute:cmd error:&error];
            [fileMainArray removeObjectAtIndex:indexFromSegue];
            [imgMainArray removeObjectAtIndex:indexFromSegue];
            nbRows --;
            [self performSegueWithIdentifier:@"Back" sender:self.view];
            break;
        }
        case 1:{
            NSLog(@"Save Button Clicked");
            UIImageWriteToSavedPhotosAlbum(img, self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
            break;
        }
        case 2:{
            /*if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller setInitialText:@"Add a comment"];
                [self presentViewController:controller animated:YES completion:Nil];
            }*/
            mySLComposerSheet = [[SLComposeViewController alloc] init];
            mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [mySLComposerSheet setInitialText:@"Toto"];
            [self presentViewController:mySLComposerSheet animated:YES completion:NULL];
        }
        case 3:{
            NSLog(@"Cancel Button Clicked");
            break;
        }
    }
}

//Verify the image has been saved correctly in the Photo Gallery
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *) error contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image/video"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
