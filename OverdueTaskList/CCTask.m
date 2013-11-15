//
//  CCTask.m
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import "CCTask.h"

@implementation CCTask

#pragma mark -- Initializers

//Designated Initializer
-(id)initWithData:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.title = data[TASK_TITLE];
        self.description = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        NSNumber *completion = data[TASK_COMPLETION];
        self.completion = completion.boolValue;
    }    
    
    return self;
}

-(id)init {
    //call the Designated initializer with nil for the Dictionary
    return [self initWithData:nil];
}
@end
