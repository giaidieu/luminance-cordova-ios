
#import <Cordova/CDVPlugin.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreVideo/CoreVideo.h>
#import <AVFoundation/AVFoundation.h>

@interface Luminance : CDVPlugin

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) NSMutableData *frame_buffer;
@property (nonatomic, strong) NSString *frame_callback;

- (void)startCapture:(CDVInvokedUrlCommand*)command;
- (void)endCapture:(CDVInvokedUrlCommand*)command;

@end