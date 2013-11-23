//
//  CCDetailTaskViewController.h
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTask.h"

@protocol CCDetailTaskViewControllerDelegate <NSObject>

-(void)taskDidChange;

@end

@interface CCDetailTaskViewController : UIViewController 

@property (nonatomic, weak) id <CCDetailTaskViewControllerDelegate> delegate;

@property (nonatomic, strong) CCTask *task;

@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UISwitch *taskCompletionSwitch;

- (IBAction)editTaskButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)taskCompletionSwitchChanged:(UISwitch *)sender;

@end
