//
//  DictionaryMappable.m
//  RNStarPrinter
//
//  Created by Apptizer on 11/21/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DictionaryMappable
- (NSDictionary*) toJsonDictionary;
@end
