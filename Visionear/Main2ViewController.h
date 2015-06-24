//
//  Main2ViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Main2ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)TakePhoto:(id)sender;

@end
