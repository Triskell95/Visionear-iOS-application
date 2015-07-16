//
//  Help2ViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSArray *labelArray;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIScrollView *scr;

- (void)setupScrollView:(UIScrollView*)scrMain;

@end
