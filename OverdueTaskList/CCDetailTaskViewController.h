//
//  CCDetailTaskViewController.h
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDetailTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;

- (IBAction)editTaskButtonPressed:(UIBarButtonItem *)sender;

@end
