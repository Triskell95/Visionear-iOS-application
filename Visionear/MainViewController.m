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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Start buttom customization
    [[startButton layer] setBorderWidth:1.0f];
    [[startButton layer] setBorderColor:[UIColor blackColor].CGColor];
    startButton.layer.cornerRadius = 20; // this value vary as per your desire
    startButton.clipsToBounds = YES;
    
    //Visionear label customization THSarabunNew
    //[[self visionearLabel] setFont:[UIFont fontWithName:@"THSarabunNew" size:70]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
