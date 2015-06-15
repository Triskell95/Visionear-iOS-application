//
//  Main3ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 6/10/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Main3ViewController.h"
#import "Global.h"

@interface Main3ViewController ()

@end

@implementation Main3ViewController

@synthesize backButton, titleLabel, backgroundLabel;
@synthesize indexFromSegue;
@synthesize imgView, labelDesc;
@synthesize img;
@synthesize scroll;

BOOL flagHide = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //labelDesc.text = [fileMainArray objectAtIndex:indexFromSegue];
    imgView.image = img;
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
    }
    else {
        flagHide = YES;
    }
    backButton.hidden = flagHide;
    titleLabel.hidden = flagHide;
    backgroundLabel.hidden = flagHide;
}

-(IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"What do you want to do with this picture ?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Save", @"Copy", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
     switch (buttonIndex) {
     case 0:
     //self.label.text = @"Destructive Button Clicked";
     break;
     case 1:
     //self.label.text = @"Other Button 1 Clicked";
     break;
     case 2:
     //self.label.text = @"Other Button 2 Clicked";
     break;
     case 3:
     //self.label.text = @"Cancel Button Clicked";
     break;
     }
    
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
