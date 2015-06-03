//
//  SocialViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 5/27/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *socialLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgSocial;
@property (weak, nonatomic) IBOutlet UIButton *buttonSocial;

@end
