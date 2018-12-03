//
//  CommandGenerator.m
//  RNStarPrinter
//
//  Created by Apptizer on 11/27/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "CommandGenerator.h"
#import <StarIO_Extension/StarIoExt.h>
#import <StarIO_Extension/ISCBBuilder.h>

@implementation CommandGenerator

+ (NSData *)generateCommandsForImage: (UIImage *)image
                           emulation: (StarIoExtEmulation)emulation
                           paperSize: (PaperSizeIndex)paperSize
{
    ISCBBuilder *builder = [StarIoExt createCommandBuilder: emulation];
    
    [builder beginDocument];
    [builder appendBitmap:image diffusion:NO width:paperSize bothScale:YES];
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    [builder endDocument];
    
    return [builder.commands copy];
}

@end
