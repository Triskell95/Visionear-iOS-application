//
//  SecondViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 4/30/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpCustomCell.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

@synthesize helpLabel;

int cmpt = 0;
NSString *testString;

- (void)viewDidLoad {
    [super viewDidLoad];
    /*[[HelpTableView layer] setBorderWidth:1.0f];
    [[HelpTableView layer] setBorderColor:[UIColor whiteColor].CGColor];
    */
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    //HelpCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // AFFECTATION DES CHAMPS NOM ET IMAGE DES CELLULES CATEGORIES
    /*testString = [NSMutableString stringWithFormat:@"Test #%d", cmpt];
    cmpt ++;
    NSLog(@"%@", testString);
    cell.labelHelpCell.text = testString;
    cell.imageHelpCell.image = [UIImage imageNamed:@"visionear_body.png"];
    //[data objectAtIndex:indexPath.row]
    */
      return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
