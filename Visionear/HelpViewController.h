//
//  HelpViewController.h
//  Visionear
//
//  Created by CPE KMUTT on 5/14/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpCustomCell.h"

@interface HelpViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray *cellImages;
@property (copy, nonatomic) NSArray *cellLabels;
@property (weak, nonatomic) IBOutlet UITableView *helpTableView;

@end
