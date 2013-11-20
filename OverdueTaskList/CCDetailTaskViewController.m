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
    [self initTaskFields];
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
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.taskDateLabel.text = [formatter stringFromDate:self.task.date];
}
@end
