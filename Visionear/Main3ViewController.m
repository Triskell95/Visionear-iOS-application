//
//  Main3ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 6/10/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Main3ViewController.h"
#import "Global.h"

@interface Main3ViewController ()

@end

@implementation Main3ViewController

@synthesize indexFromSegue;
@synthesize imgView, labelDesc;
@synthesize img;
@synthesize scroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    labelDesc.text = [fileMainArray objectAtIndex:indexFromSegue];
    imgView.image = img;
    
    [scroll setMaximumZoomScale:5.0f];
    [scroll setClipsToBounds:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return imgView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Delete:(id)sender {
    
    UIAlertView *delRequest = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to remove this image from Visionear System ?"message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [delRequest show];
    
}
@end
