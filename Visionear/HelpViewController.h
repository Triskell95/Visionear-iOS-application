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

/*
    READ ME !!!
 
    /!\This file and its associate .m are outdated !!!
    
    These files were associated to a 1st draft view for the Help Section but have been replaced by HelpSection2.h & .m
    They haven't been deleted because they contain some models for TableView management that could useful for the project after
*/

@property (copy, nonatomic) NSArray *cellImages;
@property (copy, nonatomic) NSArray *cellLabels;
@property (weak, nonatomic) IBOutlet UITableView *helpTableView;

@end
