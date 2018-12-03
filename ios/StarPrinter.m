//
//  RNStarPrinterBridge.m
//  RNStarPrinter
//
//  Created by Apptizer on 11/8/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

//#import <React/RCTBridgeModule.h>

#import "StarPrinter.h"
#import <React/RCTLog.h>
#import <StarIO/SMPort.h>
#import <StarIO_Extension/ISCBBuilder.h>
#import <StarIO_Extension/StarIoExt.h>
#import "PortInfo+Categories.m"
#import "CommandGenerator.h"
#import "UIImage+Categories.m"
#import "Communication.h"
#import "PrinterSetting.h"
#import "CommandQueueManager.h"

@implementation StarPrinter {
    RCTPromiseResolveBlock _resolveBlock;
    RCTPromiseRejectBlock _rejectBlock;
    UIWebView *_webView;
    NSString *_portName;
    NSString *_modelName;
    PaperSizeIndex _paperWidth;
    NSInteger _paperHeight;
    BOOL _printInProgress;
}

# pragma mark - Initialization

RCT_EXPORT_MODULE();

# pragma mark - Static Constants

- (NSDictionary *)constantsToExport
{
    NSDictionary *paperSizes = [PrinterSetting paperSizesToJsonDictionary];
    return @{ @"PaperSizes": paperSizes };
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

# pragma mark - Bridge Exposed Methods

RCT_EXPORT_METHOD(searchPrinter:(NSString *)target
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"Searching for printers with target %@", target);
    NSArray* portArray = [SMPort searchPrinter: target];
    
    NSMutableArray* portsInJson = [[NSMutableArray alloc] init];
    for (int i = 0; i < portArray.count; i++) {
        PortInfo *port = [portArray objectAtIndex:i];
        [portsInJson addObject:[port toJsonDictionary]];
    }
    resolve(portsInJson);
}

RCT_EXPORT_METHOD(printBase64Image:(NSString *)base64Image
                  portName:(NSString *)portName
                  modelName:(NSString *)modelName
                  paperSize:(PaperSizeIndex)paperSize
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    StarIoExtEmulation emulation = [PrinterSetting determineImageEmulationForModel:modelName];
    RCTLogInfo(@"Printing base64 image [%@] on port [%@] with paperSize [%ld] emulation [%ld]", base64Image, portName, (long)paperSize, (long)emulation);
    
    UIImage *image = [UIImage fromBase64Encoded:base64Image];
    NSData *commands = [CommandGenerator
                        generateCommandsForImage:image
                        emulation:emulation
                        paperSize:paperSize];
    
    dispatch_async(CommandQueueManager.sharedManager.serialQueue, ^{
        [Communication sendCommands:commands
                           portName:portName
                       portSettings:@""
                            timeout:10000
                  completionHandler:^(BOOL result, NSString *title, NSString *message) {
                      RCTLogInfo(@"Completed printing image on port [%@] with result [%d]", portName, (int)result);
                      if (result) {
                          resolve(title);
                      } else {
                          RCTLogWarn(@"Failed to print image with title [%@] and message [%@]", title, message);
                          reject(title, message, nil);
                      }
                  }];
    });
}

RCT_EXPORT_METHOD(printHtmlString:(NSString *)htmlString
                  portName:(NSString *)portName
                  modelName:(NSString *)modelName
                  paperSize:(PaperSizeIndex)paperSize
                  paperHeight:(NSInteger)paperHeight
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"Staring print with HTML string [%@]", htmlString);

    if (_printInProgress) {
        RCTLogError(@"Print job already in progress");
        reject(RCTErrorUnspecified, @"Print job already in progress", RCTErrorWithMessage(@"Print job already in progress"));
    } else {
        _printInProgress = YES;
        _portName = portName;
        _modelName = modelName;
        _paperWidth = paperSize;
        _paperHeight = paperHeight;
        _rejectBlock = reject;
        _resolveBlock = resolve;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createWebView];
            [self->_webView loadHTMLString:htmlString baseURL:nil];
        });
    }
}

# pragma mark - UIWebView Delegates

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    RCTLog(@"Called webview delegate with frameSize [%@]", NSStringFromCGSize(webView.frame.size));
    UIImage *image = UIImageFrom(webView);
    
    StarIoExtEmulation emulation = [PrinterSetting determineImageEmulationForModel:_modelName];
    NSData *commands = [CommandGenerator
                        generateCommandsForImage:image
                        emulation:emulation
                        paperSize:_paperWidth];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(CommandQueueManager.sharedManager.serialQueue, ^{
         __strong typeof(self) strongSelf = weakSelf;
        [Communication sendCommands:commands
                           portName:strongSelf->_portName
                       portSettings:@""
                            timeout:10000
                  completionHandler:^(BOOL result, NSString *title, NSString *message) {
                      RCTLogInfo(@"Completed printing image with result [%d]", (int)result);
                      __strong typeof(self) strongSelf = weakSelf;
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [strongSelf destroyWebView:webView];
                      });
                      if (result) {
                          strongSelf->_resolveBlock(title);
                      } else {
                          strongSelf->_rejectBlock(RCTErrorUnspecified, message, RCTErrorWithMessage(title));
                      }
                      strongSelf->_printInProgress = NO;
                  }];
    });
}

# pragma mark - Helper Methods

-(void) createWebView {
    CGRect webViewContainer = CGRectMake(-10000, 0, _paperWidth, _paperHeight);
    _webView = [[UIWebView alloc] initWithFrame:webViewContainer];
    _webView.delegate = self;
    [_webView scalesPageToFit];
    [self addSubview:_webView];
}

-(void) destroyWebView:(UIWebView *)webView {
    [_webView stopLoading];
    [_webView setDelegate:nil];
    [_webView removeFromSuperview];
    _webView = nil;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}

static UIImage *UIImageFrom(UIWebView * _Nonnull webView) {
    [webView sizeToFit];
    UIGraphicsBeginImageContext(webView.frame.size);
    [webView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
