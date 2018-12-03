//
//  PrinterSetting.h
//  RNStarPrinter
//
//  Created by Apptizer on 11/27/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

@import Foundation;
#import <StarIO_Extension/StarIoExt.h>

typedef NS_ENUM(NSInteger, PaperSizeIndex) {
    PaperSizeIndexNone = 0,
    PaperSizeIndexTwoInch = 384,
    PaperSizeIndexThreeInch = 576,
    PaperSizeIndexFourInch = 832,
    PaperSizeIndexEscPosThreeInch = 512,
    PaperSizeIndexDotImpactThreeInch = 210
};

@interface PrinterSetting : NSObject

+ (NSDictionary *)paperSizesToJsonDictionary;

+ (StarIoExtEmulation)determineImageEmulationForModel:(NSString *)modelName;

@end
