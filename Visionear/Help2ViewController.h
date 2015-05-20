//
//  Help2ViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Help2ViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSArray *labelArray;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
