//
//  FirstViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 4/30/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize startButton;
@synthesize visionearLabel;
@synthesize visionearImg;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Start buttom customization
    [[startButton layer] setBorderWidth:1.0f];
    [[startButton layer] setBorderColor:[UIColor blackColor].CGColor];
    startButton.layer.cornerRadius = 20; // this value vary as per your desire
    startButton.clipsToBounds = YES;
    
    visionearImg.frame = CGRectMake(0, 0, 100, 100);
    visionearImg.center = visionearImg.superview.center;
    
    
    
    //Visionear label customization THSarabunNew
    //[[self visionearLabel] setFont:[UIFont fontWithName:@"THSarabunNew" size:70]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewTapped:(UITapGestureRecognizer *)recognizer {
    //Add in your picker dismissal code here
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    //CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
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
    NSLog(@"Screen Tapped !");
    [self performSegueWithIdentifier:@"NextView" sender:self];
}

-(void)handleDoubleTap
{
    NSLog(@"tapCount 2");
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
