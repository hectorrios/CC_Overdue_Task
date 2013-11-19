//
//  CCViewController.m
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import "CCViewController.h"
#import "CCDetailTaskViewController.h"

@interface CCViewController ()

@end

@implementation CCViewController

#pragma mark -- ViewController lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *storedTaskObjects = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY];
    if (storedTaskObjects) {
        for (NSDictionary *dictionary in storedTaskObjects) {
            [self.taskObjects addObject:[self returnTaskObject:dictionary]];
        }
    }
    
    //set the delegate property and the datasource property of the tableview to this controller
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[CCAddTaskViewController class]]) {
        CCAddTaskViewController *addTaskController = segue.destinationViewController;
        addTaskController.delegate = self;
    } else if ([segue.destinationViewController isKindOfClass:[CCDetailTaskViewController class]]) {
        CCDetailTaskViewController *detailController = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        detailController.task = self.taskObjects[indexPath.row];
    }
}

#pragma IBAction methods

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
}

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"modalToAddTaskController" sender:sender];
}

#pragma mark -- Getter and Setters

-(NSMutableArray *)taskObjects {
    if (_taskObjects == nil) {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    
    return _taskObjects;
}

#pragma mark -- CCAddTaskViewController Delegate
-(void)didCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddTask:(CCTask *)task {
    
    [self.taskObjects addObject:task];
    
    NSMutableArray *tasksFromUserDefaults = [[[NSUserDefaults standardUserDefaults]
                                              arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if (!tasksFromUserDefaults) {
        tasksFromUserDefaults = [[NSMutableArray alloc] init];
    }
    
    [tasksFromUserDefaults addObject:[self taskObjetAsAPropertyList:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:tasksFromUserDefaults forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark -- TableView DataSource methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Fetch the task corresponding to the row in IndexPath
    CCTask *task = self.taskObjects[indexPath.row];
    
    static NSString *cellIdentifier = @"taskCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //configure the cell
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    cell.detailTextLabel.text = [formatter stringFromDate:task.date];
    
    //Determine the color coding for the cell
    if (task.completion == YES) {
        cell.backgroundColor = [UIColor greenColor];
    } else if ([self isDateGreaterThan:task.date SecondDate:[NSDate date]]) {
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.taskObjects count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark -- TableView delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Get the task from taskObjects array
    CCTask *task = [self.taskObjects objectAtIndex:indexPath.row];
    task.completion = !task.completion;
    
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //remove the task from the taskObjects array
    [self.taskObjects removeObjectAtIndex:indexPath.row];
    
    NSMutableArray *storedTasks = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    [storedTasks removeObjectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:storedTasks forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"pushToDetailController" sender:indexPath];
}

#pragma mark -- Private Helper methods

-(NSDictionary *)taskObjetAsAPropertyList:(CCTask *)task {
    NSDictionary *dictionary = @{ TASK_TITLE: task.title, TASK_DESCRIPTION: task.description,
                                  TASK_DATE: task.date, TASK_COMPLETION: @(task.completion) };
    return dictionary;
}

-(CCTask *)returnTaskObject:(NSDictionary *)dictionary {
    return [[CCTask alloc] initWithData:dictionary];
}

-(BOOL)isDateGreaterThan:(NSDate *)date1 SecondDate:(NSDate *)date2 {
    NSTimeInterval dateOneInterval = [date1 timeIntervalSince1970];
    NSTimeInterval dateTwoInterval = [date2 timeIntervalSince1970];
    
    if (dateOneInterval > dateTwoInterval) {
        return YES;
    } else {
        return NO;
    }
}

-(void)updateCompletionOfTask:(CCTask *)task forIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    //Remove the dictionary entry object at the index specified by indexPath.row
    [tasksAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    //convert the passed in Task to an NSDictionary
    NSDictionary *dictionary = [self taskObjetAsAPropertyList:task];
    
    //insert this dictionary into the Array at the position specified by indexPath.row
    [tasksAsPropertyLists insertObject:dictionary atIndex:indexPath.row];
    
    //Save the array back into NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

@end

