//
//  Main2ViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Main2ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//When 'Back' button is pressed, end of the SSH connection before going back to main screen
- (IBAction)backPressed:(id)sender;

@end
