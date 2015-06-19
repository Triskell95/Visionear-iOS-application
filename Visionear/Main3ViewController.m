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
float ratio;
CGRect originalFrame;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //labelDesc.text = [fileMainArray objectAtIndex:indexFromSegue];
    imgView.image = img;
    ratio = img.size.height/img.size.width;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [scroll setMaximumZoomScale:5.0f];
    [scroll setClipsToBounds:YES];
    
    UILongPressGestureRecognizer *recoginzer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onPress:)];
    [self.view addGestureRecognizer:recoginzer];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:singleTap];
    
    [self.view sendSubviewToBack:scroll];
    [self.view sendSubviewToBack:imgView];
    
    originalFrame = self.tabBarController.tabBar.frame;
    
    /*
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGRect newFrame = CGRectMake(0, (screenBound.size.height - screenBound.size.width*ratio)/2 - self.navigationController.navigationBar.frame.size.height, screenBound.size.width, screenBound.size.width*ratio);
    imgView.frame = newFrame;
    scroll.frame = newFrame;
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return imgView;
}

- (void)onPress:(UILongPressGestureRecognizer*)longpress {
    
    if (longpress.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"Long press");
        [self showActionSheet:@"id"];
    }
    else if (longpress.state == UIGestureRecognizerStateEnded || longpress.state == UIGestureRecognizerStateCancelled || longpress.state == UIGestureRecognizerStateFailed) {
        
        NSLog(@"Long press done");
    }
}

-(void)tapDetected{
    NSLog(@"single Tap on imageview");
    if(flagHide){
        flagHide = NO;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    else {
        flagHide = YES;
        self.view.backgroundColor = [UIColor blackColor];
    }
    //NSLog(@"Flag state is: %hhd", flagHide);
    //backButton.hidden = flagHide;
    //titleLabel.hidden = flagHide;
    //backgroundLabel.hidden = flagHide;
    
    [self.navigationController setNavigationBarHidden:flagHide animated:NO];
    if (flagHide == YES) {

        [self hideTabBar:self.tabBarController];
    }
    else {
        
        [self showTabBar:self.tabBarController];
    }
}

- (void)hideTabBar:(UITabBarController *) tabbarcontroller
{
    //[UIView beginAnimations:nil context:NULL];
    //[UIView setAnimationDuration:0.5];
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, originalFrame.origin.y+50, view.frame.size.width, view.frame.size.height)];
        }
        /*else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, originalFrame.size.height)];
        }*/
    }
    
    //[UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *) tabbarcontroller
{
    //[UIView beginAnimations:nil context:NULL];
    //[UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        NSLog(@"%@", view);
        
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, originalFrame.origin.y, view.frame.size.width, view.frame.size.height)];
            
        }
        /*else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, originalFrame.size.height)];
        }*/
    }
    
    //[UIView commitAnimations];
}

-(IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"What do you want to do with this picture ?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Save", @"Share on Facebook", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self.view];
}

- (IBAction)backPressed:(id)sender {
    NSLog(@"Back Pressed !");
}

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

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *) error contextInfo:(void *)contextInfo
{
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"Back"]){
        NSLog(@"Go back to 2nd MainView\r");
        [segue destinationViewController];
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
