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
int fontSize;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialization of the data in the arrays for the help section
    self.cellImages = @[@"scene1.gif",
                        @"scene2.gif",
                        @"scene3.gif",
                        @"scene4.gif",
                        @"scene5.gif"];
    
    self.cellLabels = @[@"Step #1: Put the headphone \r on your ear",
                        @"Step #2: Turn on \r the Visionear Controller",
                        @"Step #3: Put an object \r in front of your eyes",
                        @"Step #4: You can now scan several \r types of objects and ask \r what colour they are",
                        @"Step #5: Rotate the object for \r a more efficient detection"];
    
    
    //Getting the size of the screen and saving the height and the width values
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    /*UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    animatedImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"scene4.gif"], nil];
    animatedImageView.animationDuration = 1.0f;
    animatedImageView.animationRepeatCount = 0;
    [animatedImageView startAnimating];
    [self.view addSubview: animatedImageView];*/
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
    
    return (img.size.height*(screenWidth/img.size.width) + 100);
    
}

//Setting the content of each row in the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    
    HelpCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    //Initializing the cell, when doesn't already exists
    if(cell == nil) {
        cell = [[HelpCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    
    //Setting of the label
    cell.cellLabel.text = self.cellLabels[indexPath.row];
    
    if(cell.cellLabel.text.length > 60) { //Adaptive Font Size
        fontSize = screenWidth/((cell.cellLabel.text.length/30)*8);
    } else {
        fontSize = screenWidth/12.5;
    }
    [cell.cellLabel setFont:[UIFont fontWithName:@"THSarabunNew" size:fontSize]];
    NSLog(@"The size of the font of cell %ld is %d\rLength of the label: %ld", (long)indexPath.row, fontSize, (long)cell.cellLabel.text.length);
    
    //Setting of the image
    cell.imgView.image = [UIImage imageNamed:self.cellImages[indexPath.row]];
    
    
    //cell.cellLabel.frame = CGRectMake(0, -1, screenWidth, 20*fontSize);
    
    //Setting border of the cell
    [[cell layer] setBorderWidth:1.0f];
    [[cell layer] setBorderColor:[UIColor blackColor].CGColor];
    
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
