//
//  HelpViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/14/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

CGFloat screenWidth;
CGFloat screenHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialization of the data in the arrays for the help section
    self.cellImages = @[@"testImg1.png",
                        @"testImg2.png",
                        @"testImg3.png"];
    
    self.cellLabels = @[@"Description for the 1st test image",
                        @"Description for the 2nd test image",
                        @"Description for the 3rd test image"];
    
    
    //Getting the size of the screen and saving the height and the width values
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Setting the number of rows in the tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.cellImages count];
}

//Setting the height of each row in the tableView, depending on the size of the image by calculating a ratio
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    UIImage *img = [UIImage imageNamed:self.cellImages[indexPath.row]];
    
    return (img.size.height*(screenWidth/img.size.width) + 100.0);
    
}

//Setting the content of each row in the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    
    HelpCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    //Initializing the cell, when doesn't already exists
    if(cell == nil) {
        cell = [[HelpCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    
    //Setting of the image
    cell.imgView.image = [UIImage imageNamed:self.cellImages[indexPath.row]];

    //Setting of the label
    cell.cellLabel.text = self.cellLabels[indexPath.row];
    
    return cell;
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
