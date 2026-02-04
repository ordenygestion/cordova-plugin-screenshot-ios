#import <Cordova/CDV.h>

@interface ScreenshotDetector : CDVPlugin

- (void)pluginInitialize;
- (void)userDidTakeScreenshot:(NSNotification *)notification;
- (void)screenCaptureDidChange:(NSNotification *)notification;
- (void)startDetection:(CDVInvokedUrlCommand*)command;

@property (nonatomic) BOOL wasCapturing;

@end
