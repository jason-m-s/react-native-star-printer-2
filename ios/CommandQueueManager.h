//
//  CommandQueueManager.h
//  RNStarPrinter
//
//  Created by Apptizer on 11/30/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandQueueManager : NSObject

+ (nonnull CommandQueueManager *)sharedManager;

- (nonnull instancetype)init __attribute__((unavailable("init not available, call sharedManager instead")));

- (nonnull instancetype)copy __attribute__((unavailable("copy not available, call sharedManager instead")));

+ (nonnull instancetype)new NS_UNAVAILABLE;

@property(strong, readonly) dispatch_queue_t _Nonnull serialQueue;

@end
