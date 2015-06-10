//
//  FirstViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 4/30/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *visionearLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIImageView *visionearImg;

-(void)downloadImgFromRPi:(int) index;

@end

