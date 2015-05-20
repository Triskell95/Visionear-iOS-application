//
//  Help2ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Help2ViewController.h"

NSInteger cmpt = 1;
NSInteger cmpt2;

@interface Help2ViewController ()
{
    UISwipeGestureRecognizer *SwipeRight, *SwipeLeft;
    
}
@end

@implementation Help2ViewController

@synthesize pageControl;
@synthesize label;
@synthesize imgArray;
@synthesize labelArray;
@synthesize imgView;

CGFloat screenWidth2;
CGFloat screenHeight2;
NSInteger nbFrames[5] = {18, 38, 20, 15, 16};

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Getting the size of the screen and saving the height and the width values
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth2 = screenSize.width;
    screenHeight2 = screenSize.height;
    
    NSLog(@"\rCmpt = %d\rCmpt2 = %d", cmpt, cmpt2);
    
    //Initialization of the different arrays
    imgArray = [[NSMutableArray alloc] initWithCapacity:5];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:nbFrames[0]];
    
    //Loading all the pictures in for animated gif
    for(int i = 0; i < 5; i++){
        for(cmpt2=0; cmpt2 < nbFrames[i]; cmpt2++){
            //NSLog(@"scene%d-frames/frame_%03d.gif added", i+1, cmpt2);
            [tempArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"scene%d-frames/frame_%03d.gif", i+1, cmpt2]]];
        }
        
        [imgArray addObject:[[NSMutableArray alloc] initWithArray:tempArray]];
        [tempArray removeAllObjects];
    }
    
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
    
    NSLog(@"%@", imgArray);
    NSLog(@"Current Page :%d", pageControl.currentPage);
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    
    //Initialization of the elements of the current page
    imgView.animationImages = [imgArray objectAtIndex:0];
    [[imgView layer] setBorderWidth:1.0f];
    [[imgView layer] setBorderColor:[UIColor blackColor].CGColor];
    imgView.animationDuration = [[imgArray objectAtIndex:0] count]*0.1;
    [imgView startAnimating];
    label.text = [labelArray objectAtIndex:0];
    
    //Initialization of the elements of the current page
    imgView.animationImages = [imgArray objectAtIndex:0];
    [[imgView layer] setBorderWidth:1.0f];
    [[imgView layer] setBorderColor:[UIColor blackColor].CGColor];
    imgView.animationDuration = [[imgArray objectAtIndex:0] count]*0.1;
    [imgView startAnimating];
    label.text = [labelArray objectAtIndex:0];
}
/*
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
}
*/

-(void)Right: (UIGestureRecognizer *)sender
{
    cmpt -= 1;
    
    pageControl.currentPage = cmpt-1;
    NSLog(@"Current Page :%d", pageControl.currentPage);
    
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
    imgView.animationDuration = [[imgArray objectAtIndex:cmpt-1] count]*0.1;
    [imgView startAnimating];
    label.text = [labelArray objectAtIndex:cmpt-1];
    
}

-(void)Left: (UIGestureRecognizer *)sender
{
    cmpt+= 1;
    
    pageControl.currentPage = cmpt-1;
    NSLog(@"Current Page :%d", pageControl.currentPage);
    
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
    imgView.animationDuration = [[imgArray objectAtIndex:cmpt-1] count]*0.1;
    [imgView startAnimating];
    label.text = [labelArray objectAtIndex:cmpt-1];
    
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
/*
- (IBAction)changeScreen:(id)sender {
    for (int i = 0; i < [imgArray count]; i++) {
        
        imgView.image = [UIImage imageNamed:[imgArray objectAtIndex:pageControl.currentPage]];
        imgView.frame = CGRectMake(screenHeight2/4, screenWidth2/2, 50, 50);
        [self.scrollView addSubview:imgView];
    }
    //Set the content size of our scrollview according to the total width of our imageView objects.
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imgArray count], scrollView.frame.size.height);
}*/
@end
