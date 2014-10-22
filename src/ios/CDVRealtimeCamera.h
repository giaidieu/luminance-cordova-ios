
#import <Cordova/CDVPlugin.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreVideo/CoreVideo.h>
#import <AVFoundation/AVFoundation.h>

@interface CDVRealtimeCamera : CDVPlugin

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) NSMutableData *frame_buffer;
@property (nonatomic, strong) NSString *frame_callback;
//@property (nonatomic, strong) NSNumber *brightness;


- (void)startCapture:(CDVInvokedUrlCommand*)command;
- (void)endCapture:(CDVInvokedUrlCommand*)command;
- (void)changeResolution:(CDVInvokedUrlCommand*)command;

@end