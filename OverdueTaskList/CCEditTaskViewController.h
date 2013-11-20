//
//  CCEditTaskViewController.h
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTask.h"

@protocol CCEditTaskViewControllerDelegate <NSObject>

-(void)updateTaskPressed;

@end

@interface CCEditTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) id <CCEditTaskViewControllerDelegate> delegate;

@property (nonatomic, strong) CCTask *task;

@property (strong, nonatomic) IBOutlet UITextField *taskNameField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescription;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePickerField;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@end
