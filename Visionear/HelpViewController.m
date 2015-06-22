//
//  Help2ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "HelpViewController.h"
#import "Global.h"//;

NSInteger cmpt = 1;

@interface HelpViewController ()
{
    UISwipeGestureRecognizer *SwipeRight, *SwipeLeft;
}
@end

@implementation HelpViewController

@synthesize pageControl;
@synthesize label;
@synthesize imgArray;
@synthesize labelArray;
@synthesize imgView;

CGFloat screenWidth2;
CGFloat screenHeight2;
NSInteger nbFrames[5] = {18, 38, 20, 15, 16};
CGFloat TimeConst = 0.1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Getting the size of the screen and saving the height and the width values
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth2 = screenSize.width;
    screenHeight2 = screenSize.height;
    
    imgArray = imgLoadArray;
    
    //Initialization of the label array
    labelArray = [[NSArray alloc] initWithObjects:
                  @"Step #1:\rPut the headphone \r on your ear",
                  @"Step #2:\rTurn on \r the Visionear Controller",
                  @"Step #3:\rPut an object \r in front of your eyes",
                  @"Step #4:\rScan objects and ask\rsome information about it",
                  @"Step #5:\rRotate the object for \r a more efficient detection", nil];
    
    
    //Initialization of the gesture recognition
    SwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Right:)];
    SwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:SwipeRight];
    SwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Left:)];
    SwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:SwipeLeft];
    
    //NSLog(@"Current Page :%i", (int) pageControl.currentPage);
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    
    //Initialization of the elements of the current page
    imgView.animationImages = [imgArray objectAtIndex:0];
    [[imgView layer] setBorderWidth:1.0f];
    [[imgView layer] setBorderColor:[UIColor blackColor].CGColor];
    imgView.animationDuration = [[imgArray objectAtIndex:0] count]*TimeConst;
    [imgView startAnimating];
    label.text = [labelArray objectAtIndex:0];
    
    NSLog(@"Current Page :%ld", (long)pageControl.currentPage);
}

//When a through the right gesture is perform (previous page)
-(void)Right: (UIGestureRecognizer *)sender {
    cmpt -= 1;
    
    pageControl.currentPage = cmpt-1;
    NSLog(@"Current Page :%i", (int)pageControl.currentPage);
    
    [imgView stopAnimating];
    
    if(cmpt > pageControl.numberOfPages){
        cmpt = pageControl.numberOfPages;
    }
    else if(cmpt < 1){
        cmpt = 1;
    }
    
    imgView.animationImages = [imgArray objectAtIndex:cmpt-1];
    //imgView.image = [UIImage imageNamed:[imgArray objectAtIndex:cmpt-1]];
    [[imgView layer] setBorderWidth:1.0f];
    [[imgView layer] setBorderColor:[UIColor blackColor].CGColor];
    imgView.animationDuration = [[imgArray objectAtIndex:cmpt-1] count]*TimeConst;
    [imgView startAnimating];
    label.text = [labelArray objectAtIndex:cmpt-1];
 
}

//When a through the left is performed (next page)
-(void)Left: (UIGestureRecognizer *)sender {
    cmpt+= 1;
    
    pageControl.currentPage = cmpt-1;
    NSLog(@"Current Page :%ld", (long)pageControl.currentPage);
    
    [imgView stopAnimating];
    
    if(cmpt > pageControl.numberOfPages){
        cmpt = pageControl.numberOfPages;
    }
    else if(cmpt < 1){
        cmpt = 1;
    }
    
    imgView.animationImages = [imgArray objectAtIndex:cmpt-1];
    //imgView.image = [UIImage imageNamed:[imgArray objectAtIndex:cmpt-1]];
    [[imgView layer] setBorderWidth:1.0f];
    [[imgView layer] setBorderColor:[UIColor blackColor].CGColor];
    imgView.animationDuration = [[imgArray objectAtIndex:cmpt-1] count]*TimeConst;
    [imgView startAnimating];
    label.text = [labelArray objectAtIndex:cmpt-1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
