//
//  CommandQueueManager.m
//  RNStarPrinter
//
//  Created by Apptizer on 11/30/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "CommandQueueManager.h"

@implementation CommandQueueManager

static CommandQueueManager *sharedInstance = nil;

+ (CommandQueueManager *)sharedManager {
    if (sharedInstance == nil) {
        sharedInstance = [[CommandQueueManager alloc] init2];
    }
    
    return sharedInstance;
}

- (instancetype)init2 {
    self = [super init];
    if (self != nil) {
        _serialQueue = dispatch_queue_create("star-print-command-queue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    }
    
    return self;
}

@end



