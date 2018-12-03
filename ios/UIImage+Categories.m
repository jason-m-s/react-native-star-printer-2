//
//  UIImage+Categories.m
//  RNStarPrinter
//
//  Created by Apptizer on 11/27/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

@import UIKit;

@interface UIImage (Base64Handlable)
@end

@implementation UIImage (Base64Handlable)

+ (UIImage *)fromBase64Encoded: (NSString *)base64String {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end
