//
//  PrinterSetting.m
//  RNStarPrinter
//
//  Created by Apptizer on 11/27/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrinterSetting.h"

@implementation PrinterSetting

+ (NSDictionary *)paperSizesToJsonDictionary {
    return @{@"None": @(PaperSizeIndexNone),
             @"TwoInch": @(PaperSizeIndexTwoInch),
             @"ThreeInch": @(PaperSizeIndexThreeInch),
             @"FourInch": @(PaperSizeIndexFourInch),
             @"EscPosThreeInch": @(PaperSizeIndexEscPosThreeInch),
             @"DotImpactThreeInch": @(PaperSizeIndexDotImpactThreeInch)};
}

+ (StarIoExtEmulation)determineImageEmulationForModel:(NSString *)modelName
{
    if ([modelName containsString:@"MCP31"]) {
        return StarIoExtEmulationStarPRNT;
    } else if ([modelName containsString:@"TSP143IIIW"]) {
        return StarIoExtEmulationStarGraphic;
    } else {
        return StarIoExtEmulationStarGraphic;
    }
}

@end
