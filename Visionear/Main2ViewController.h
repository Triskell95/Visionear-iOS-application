//
//  Main2ViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Main2ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelMain2;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain2;

- (IBAction)backPressed:(id)sender;

@end
