//
//  PaperSizes.m
//  RNStarPrinter
//
//  Created by Apptizer on 11/27/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTConvert.h>
#import "PrinterSetting.h"

@implementation RCTConvert (PaperSize)
    RCT_ENUM_CONVERTER(PaperSizeIndex,
                       (@{ @"None": @(PaperSizeIndexNone),
                           @"TwoInch": @(PaperSizeIndexTwoInch),
                           @"ThreeInch": @(PaperSizeIndexThreeInch),
                           @"FourInch": @(PaperSizeIndexFourInch),
                           @"EscPosThreeInch": @(PaperSizeIndexEscPosThreeInch),
                           @"DotImpactThreeInch": @(PaperSizeIndexDotImpactThreeInch)}),
                       PaperSizeIndexNone,
                       integerValue)
@end

