//
//  CommandGenerator.h
//  RNStarPrinter
//
//  Created by Apptizer on 11/27/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

@import Foundation;
#import <StarIO_Extension/StarIoExt.h>
#import "PrinterSetting.h"

@interface CommandGenerator : NSObject

+ (NSData *)generateCommandsForImage: (UIImage *)image
                           emulation: (StarIoExtEmulation)emulation
                           paperSize: (PaperSizeIndex)paperSize;

@end
