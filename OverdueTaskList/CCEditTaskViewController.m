//
//  CCEditTaskViewController.m
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import "CCEditTaskViewController.h"

@interface CCEditTaskViewController ()

@end

@implementation CCEditTaskViewController

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
    
    NSLog(@"Edit task controller. View Did Load");
    //Initialize Task related fields
    self.taskNameField.text = self.task.title;
    self.taskDescription.text = self.task.description;
    self.taskDatePickerField.date = self.task.date;
    [self.taskCompletionSwitchField setOn:self.task.completion animated:YES];
    
    //assign protocol delegates
    self.taskNameField.delegate = self;
    self.taskDescription.delegate = self;
    
    //Set the background image
    UIImage *backImage = [UIImage imageNamed:BACKGROUND_IMAGE];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- IBAction methods

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    
    self.task.title = self.taskNameField.text;
    self.task.description = self.taskDescription.text;
    self.task.date = self.taskDatePickerField.date;
    self.task.completion = self.taskCompletionSwitchField.on;
    
    [self.delegate updateTaskPressed];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UITextView Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.taskDescription resignFirstResponder];
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

@end
