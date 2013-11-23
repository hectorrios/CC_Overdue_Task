//
//  CCAddTaskViewController.m
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import "CCAddTaskViewController.h"

@interface CCAddTaskViewController () <UITextViewDelegate, UITextFieldDelegate>

@end

@implementation CCAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //set the view controller as the delegate for the UITextView class
    self.taskDescriptionField.delegate = self;
    self.taskNameField.delegate = self;
    
    //Set the background image
    UIImage *backImage = [UIImage imageNamed:BACKGROUND_IMAGE];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    //Make sure that every bit of info for this new task has been filled in
    if (self.taskNameField.text.length != 0 &&
        self.taskDescriptionField.text.length != 0 && self.taskDatePickerField.date != nil) {
        CCTask *task = [self createTask];
        [self.delegate didAddTask:task];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"A Task title, description and date must be provided in order to add a new task" delegate:nil
                                                  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate didCancel];
}


#pragma mark -- UITextView Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.taskDescriptionField resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
    
}

#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -- Helper Methods
-(CCTask *)createTask {
    CCTask *newTask = [[CCTask alloc] init];
    newTask.title = self.taskNameField.text;
    newTask.description = self.taskDescriptionField.text;
    
    newTask.date = self.taskDatePickerField.date;
    newTask.completion = NO;
    
    return newTask;
}

@end
