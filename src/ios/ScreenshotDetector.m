#import "ScreenshotDetector.h"

@implementation ScreenshotDetector

- (void)pluginInitialize {
    [super pluginInitialize];
    
    // Registrar observer para screenshots
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification
                                               object:nil];
    
    // Registrar observer para grabación de pantalla (iOS 11+)
    if (@available(iOS 11.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(screenCaptureDidChange:)
                                                     name:UIScreenCapturedDidChangeNotification
                                                   object:nil];
        
        // Inicializar el estado de captura
        self.wasCapturing = [UIScreen mainScreen].isCaptured;
        
        NSLog(@"[ScreenshotDetector] Plugin inicializado - Observers registrados (screenshot + recording)");
    } else {
        NSLog(@"[ScreenshotDetector] Plugin inicializado - Solo screenshot (iOS < 11)");
    }
}

- (void)userDidTakeScreenshot:(NSNotification *)notification {
    NSLog(@"[ScreenshotDetector] ¡SCREENSHOT DETECTADO!");
    
    // Enviar evento a JavaScript
    NSString* js = @"cordova.fireDocumentEvent('screenshotDetected', {timestamp: Date.now()});";
    [self.commandDelegate evalJs:js];
}

- (void)screenCaptureDidChange:(NSNotification *)notification {
    if (@available(iOS 11.0, *)) {
        BOOL isCapturing = [UIScreen mainScreen].isCaptured;
        
        if (isCapturing && !self.wasCapturing) {
            // Inicio de grabación
            NSLog(@"[ScreenshotDetector] ¡GRABACIÓN DE PANTALLA INICIADA!");
            NSString* js = @"cordova.fireDocumentEvent('screenRecordingStarted', {timestamp: Date.now()});";
            [self.commandDelegate evalJs:js];
        } 
        else if (!isCapturing && self.wasCapturing) {
            // Fin de grabación
            NSLog(@"[ScreenshotDetector] ¡GRABACIÓN DE PANTALLA FINALIZADA!");
            NSString* js = @"cordova.fireDocumentEvent('screenRecordingStopped', {timestamp: Date.now()});";
            [self.commandDelegate evalJs:js];
        }
        
        self.wasCapturing = isCapturing;
    }
}

- (void)startDetection:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:@"Screenshot and recording detection active"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
