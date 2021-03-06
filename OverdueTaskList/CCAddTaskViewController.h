//
//  CCAddTaskViewController.h
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTask.h"

@protocol CCAddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(CCTask *)task;

@end

@interface CCAddTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *taskNameField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionField;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePickerField;

@property (nonatomic, weak) id <CCAddTaskViewControllerDelegate> delegate;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;


@end
