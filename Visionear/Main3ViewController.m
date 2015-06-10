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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    labelDesc.text = [fileMainArray objectAtIndex:indexFromSegue];
    imgView.image = [self loadImage:[imgMainArray objectAtIndex:indexFromSegue]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)loadImage:(NSString *) string{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:string];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
