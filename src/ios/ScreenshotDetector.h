#import <Cordova/CDV.h>

@interface ScreenshotDetector : CDVPlugin

- (void)pluginInitialize;
- (void)userDidTakeScreenshot:(NSNotification *)notification;
- (void)startDetection:(CDVInvokedUrlCommand*)command;

@end
