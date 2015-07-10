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
@synthesize scr;

CGFloat screenWidth2;
CGFloat screenHeight2;
NSInteger nbFrames[5] = {18, 38, 20, 15, 16};
CGFloat TimeConst = 0.1;
int nextPage = 0;

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
    
    scr.pagingEnabled = YES;
    [scr setBackgroundColor:[UIColor blackColor]];
    [self setupScrollView:scr];
    
    //NSLog(@"Current Page :%i", (int) pageControl.currentPage);
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    
    //Initialization of the elements of the current page
    //[self loadArrayWithImages:0 :imgView];
    
    label.text = [labelArray objectAtIndex:0];
    NSLog(@"Current Page :%ld", (long)pageControl.currentPage);
}

-(void) loadArrayWithImages: (int) index :(UIImageView *) imageView{
    
    imageView.animationImages = [imgArray objectAtIndex:index];
    //imgView.image = [UIImage imageNamed:[imgArray objectAtIndex:cmpt-1]];
    [[imageView layer] setBorderWidth:1.0f];
    [[imageView layer] setBorderColor:[UIColor blackColor].CGColor];
    imageView.animationDuration = [[imgArray objectAtIndex:index] count]*TimeConst;
    [imageView startAnimating];
    
}

- (void)setupScrollView:(UIScrollView*)scrMain {
    // we have 10 images here.
    // we will add all images into a scrollView &amp; set the appropriate size.
    
    for (int i=0; i<5; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((i)*self.view.frame.size.width, 0, self.view.frame.size.width, scrMain.frame.size.height)];
        
        imgV.contentMode=UIViewContentModeScaleToFill;
        
        [self loadArrayWithImages:i :imgV];
        
        NSLog(@"Loading scene nb %d", i);
        // set image
        //[imgV setImage:image];
        // apply tag to access in future
        imgV.tag=i+1;
        // add to scrollView
        [scrMain addSubview:imgV];
    }
    // set the content size to 10 image width
    [scrMain setContentSize:CGSizeMake(self.view.frame.size.width*5, scr.frame.size.height)];
    // enable timer after each 2 seconds for scrolling.
    //[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
}

- (void)scrolling: (int) nb {
    
    // get the current offset ( which page is being displayed )
    CGFloat contentOffset = scr.contentOffset.x;
    CGPoint cg = {nb, 0};
    
    //[scr scrollViewWillEndDragging:withVelocity:targetContentOffset:];
    //[self scrollViewWillEndDragging:scr withVelocity:cg targetContentOffset:&cg];
    [self scrollViewWillEndDragging:scr withVelocity:cg targetContentOffset:&cg];
    // calculate next page to display
    nextPage = (int)(contentOffset/scr.frame.size.width) + nb ;
    // if page is not 10, display it
    if( nextPage!=5 )  {
        [scr scrollRectToVisible:CGRectMake(nextPage*scr.frame.size.width, 0, scr.frame.size.width, scr.frame.size.height) animated:YES];
        pageControl.currentPage+=nb;
        // else start sliding form 1 :)
    } else {
        [scr scrollRectToVisible:CGRectMake(0, 0, scr.frame.size.width, scr.frame.size.height) animated:YES];
        pageControl.currentPage=0;
    }
    label.text = [labelArray objectAtIndex:pageControl.currentPage];
    NSLog(@"Current Page is %ld", (long)pageControl.currentPage);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    targetContentOffset->x = scrollView.contentOffset.x;
}

- (IBAction)changePage:(id)sender{
    CGFloat x = pageControl.currentPage * scr.frame.size.width;
    [scr setContentOffset:CGPointMake(x, 0) animated:YES];
    /*CGRect frame = scr.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    [scr scrollRectToVisible:frame animated:YES];
     */
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.isDragging || scrollView.isDecelerating){
        pageControl.currentPage = lround(scr.contentOffset.x / (scr.contentSize.width / pageControl.numberOfPages));
    }
}

//When a through the right gesture is perform (previous page)
-(void)Right: (UIGestureRecognizer *)sender {
    
    NSLog(@"Current Page :%i", (int)pageControl.currentPage);
    [self scrolling:-1];
}

//When a through the left is performed (next page)
-(void)Left: (UIGestureRecognizer *)sender {
    
    NSLog(@"Current Page :%ld", (long)pageControl.currentPage);
    [self scrolling:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
