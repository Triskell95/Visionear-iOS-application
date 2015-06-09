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
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;


//Download the image passed in 'imgPathToDl' from the RPi and set it in the ImageView
-(void)downloadImgFromRPi;


//When 'Back' button is pressed, end of the SSH connection before going back to main screen
- (IBAction)backPressed:(id)sender;

@end
