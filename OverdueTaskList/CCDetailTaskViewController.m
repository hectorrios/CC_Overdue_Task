//
//  CCDetailTaskViewController.m
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import "CCDetailTaskViewController.h"
#import "CCEditTaskViewController.h"

@interface CCDetailTaskViewController () <CCEditTaskViewControllerDelegate>

@end

@implementation CCDetailTaskViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark ViewController Lifecyle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Initialize the task related fields
    
    [self initTaskFields];
    
    //Set the background image
    UIImage *backImage = [UIImage imageNamed:BACKGROUND_IMAGE];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[CCEditTaskViewController class]]) {
        CCEditTaskViewController *editViewController = segue.destinationViewController;
        editViewController.delegate = self;
        editViewController.task = self.task;
    }
}

#pragma mark -- IBAction methods

- (IBAction)editTaskButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"pushToEditController" sender:sender];
}

- (IBAction)taskCompletionSwitchChanged:(UISwitch *)sender {
    //Set the completion status to whatever the status of the switch is
    self.task.completion = self.taskCompletionSwitch.on;
    
    //Call the delegate to save the task
    [self.delegate taskDidChange];
}


#pragma mark -- CCEditTaskViewController Delegate
-(void)updateTaskPressed {
    [self initTaskFields];
    [self.delegate taskDidChange];
}

#pragma mark -- Helper methods
-(void)initTaskFields {
    
    self.taskDescriptionLabel.text = self.task.description;
    self.taskNameLabel.text = self.task.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    self.taskDateLabel.text = [formatter stringFromDate:self.task.date];
    
    //check the completion status of the task and sets the UISwitch appropriately
    [self.taskCompletionSwitch setOn:self.task.completion animated:YES];

}
@end
