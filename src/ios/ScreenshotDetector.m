#import "ScreenshotDetector.h"

@implementation ScreenshotDetector

- (void)pluginInitialize {
    [super pluginInitialize];
    
    // Registrar el observer para detectar screenshots automáticamente
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification
                                               object:nil];
    
    NSLog(@"[ScreenshotDetector] Plugin inicializado - Observer registrado");
}

- (void)userDidTakeScreenshot:(NSNotification *)notification {
    NSLog(@"[ScreenshotDetector] ¡SCREENSHOT DETECTADO!");
    
    // Enviar evento a JavaScript
    NSString* js = @"cordova.fireDocumentEvent('screenshotDetected', {timestamp: Date.now()});";
    [self.commandDelegate evalJs:js];
}

- (void)startDetection:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:@"Screenshot detection active"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
