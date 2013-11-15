//
//  CCTask.h
//  OverdueTaskList
//
//  Created by Hector Rios on 11/15/13.
//  Copyright (c) 2013 Hector Rios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCTask : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) BOOL completion;

#pragma mark -- Designated Initializer

-(id)initWithData:(NSDictionary *)data;

@end
