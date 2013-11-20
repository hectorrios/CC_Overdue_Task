//
//  CCViewController.h
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCAddTaskViewController.h"
#import "CCDetailTaskViewController.h"

@interface CCViewController : UIViewController <CCAddTaskViewControllerDelegate, UITableViewDataSource,
UITableViewDelegate, CCDetailTaskViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *taskObjects;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;

@end
