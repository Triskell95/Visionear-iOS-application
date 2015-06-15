//
//  Main3ViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 6/10/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Main3ViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property int indexFromSegue;
@property UIImage *img;

- (IBAction)Delete:(id)sender;

@end
