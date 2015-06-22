//
//  Main3ViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 6/10/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface Main3ViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate> {
    
    SLComposeViewController *mySLComposerSheet;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar3;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabBar3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property int indexFromSegue;
@property UIImage *img;

-(IBAction)ActionButton:(id)sender;
-(IBAction)showActionSheet:(id)sender;

@end
