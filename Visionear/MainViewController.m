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
    
    /*UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(viewTapped:)];
    tap.numberOfTapsRequired = 1;
    [self. addGestureRecognizer:tap];
    [tap release];
    */
    
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
@end
