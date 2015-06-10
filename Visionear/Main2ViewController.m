//
//  Main2ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Main2ViewController.h"
#import "NMSSH/NMSSH.h"
#import "NMSSH/NMSSHChannel.h"
#import "MainCustomCell.h"
#import "Global.h"

@interface Main2ViewController () <NMSSHChannelDelegate, NMSSHSessionDelegate>

@end

@implementation Main2ViewController

@synthesize backButton;
@synthesize tableView;
@synthesize labelTitle;

int r;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    r = nbRows;
    
    [self.view bringSubviewToFront:backButton];
    
}

//When the view is loaded
-(void)viewDidAppear:(BOOL)animated {

    //Connection to the Raspberry
    [self connectToRasp];

}

- (IBAction)backPressed:(id)sender {
    
    NSLog(@"Back pressed, you'll be disconnected !");
    //[session disconnect];

}

//Setting the number of rows in the tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"Number of rows\r%i\r\r", r);
    return r;
}

//Setting the content of each row in the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *SimpleIdentifier = @"Cell";
    
    MainCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    //Initializing the cell, when doesn't already exists
    if(cell == nil) {
        cell = [[MainCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    
    //Setting of the label
    cell.cellLabel.text = [NSString stringWithFormat:@"Toto"];
    
    /*
     
     if(cell.cellLabel.text.length > 60) { //Adaptive Font Size
     fontSize = screenWidth/((cell.cellLabel.text.length/30)*8);
     } else {
     fontSize = screenWidth/12.5;
     }
     
     [cell.cellLabel setFont:[UIFont fontWithName:@"THSarabunNew" size:fontSize]];
     NSLog(@"The size of the font of cell %ld is %d\rLength of the label: %ld", (long)indexPath.row, fontSize, (long)cell.cellLabel.text.length);
     */
    
    //Setting of the image
    //cell.imgView.image = [UIImage imageNamed:self.cellImages[indexPath.row]];
    
    
    //cell.cellLabel.frame = CGRectMake(0, -1, screenWidth, 20*fontSize);
    
    //Setting border of the cell
    [[cell layer] setBorderWidth:1.0f];
    [[cell layer] setBorderColor:[UIColor blackColor].CGColor];
    
    return cell;
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

@end
