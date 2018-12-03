//
//  PortInfo+Categories.m
//  RNStarPrinter
//
//  Created by Apptizer on 11/21/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <StarIO/SMPort.h>
#import "DictionaryMappable.m"

@interface PortInfo (JsonMappablePortInfo) <DictionaryMappable>
@end

@implementation PortInfo (JsonMappablePortInfo)

- (NSDictionary *)toJsonDictionary {
    id objects[] = { self.portName, self.macAddress, self.modelName };
    id keys[] = { @"portName", @"macAddress", @"modelName" };
    NSUInteger count = sizeof(objects) / sizeof(id);
    return [NSDictionary dictionaryWithObjects:objects
                                       forKeys:keys
                                         count:count];
}

@end

