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
    self.cellImages = @[@"testImg1.png", @"testImg2.png", @"testImg3.png"];
    // Do any additional setup after loading the view.
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.cellImages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    UIImage *img = [UIImage imageNamed:self.cellImages[indexPath.row]];
    
    return (img.size.height*(screenWidth/img.size.width) + 100.0);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    
    HelpCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    if(cell == nil) {
        cell = [[HelpCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    
    
    cell.imgView.image = [UIImage imageNamed:self.cellImages[indexPath.row]];

    //[[cell layer] setBorderWidth:1.0f];
    //[[cell layer] setBorderColor:[UIColor blackColor].CGColor];
    
    cell.cellLabel.text = self.cellImages[indexPath.row];
    
    return cell;
}


@end
