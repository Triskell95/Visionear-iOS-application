//
//  Help2ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Help2ViewController.h"

@interface Help2ViewController ()

@end

@implementation Help2ViewController

@synthesize pageControl;
@synthesize scrollView;
@synthesize imgArray;
@synthesize imgView;

CGFloat screenWidth2;
CGFloat screenHeight2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Getting the size of the screen and saving the height and the width values
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth2 = screenSize.width;
    screenHeight2 = screenSize.height;
    
    //Put the names of our image files in our array.
    imgArray = [[NSArray alloc] initWithObjects:@"scene1.gif",
                                                @"scene2.gif",
                                                @"scene3.gif",
                                                @"scene4.gif",
                                                @"scene5.gif", nil];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
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

- (IBAction)changeScreen:(id)sender {
    for (int i = 0; i < [imgArray count]; i++) {
        
        imgView.image = [UIImage imageNamed:[imgArray objectAtIndex:[pageControl currentPage]]];
        imgView.frame = CGRectMake(screenHeight2/4, screenWidth2/2, 50, 50);
        [self.scrollView addSubview:imgView];
    }
    //Set the content size of our scrollview according to the total width of our imageView objects.
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imgArray count], scrollView.frame.size.height);
}
@end
