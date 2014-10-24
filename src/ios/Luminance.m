
#import "CDVRealtimeCamera.h"
#import <Cordova/CDV.h>
#import <JavaScriptCore/JavaScriptCore.h>

@implementation Luminance

- (void)startCapture:(CDVInvokedUrlCommand*)command
{
	// Session already started
	if (self.session != nil)
	{
		CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Capture session is already running."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		return;
	}
	
    self.session = [[AVCaptureSession alloc] init];

	// Resolution
    id resolutionParam = [command.arguments objectAtIndex:0];
	self.session.sessionPreset = AVCaptureSessionPreset352x288;

	//TODO - Get front camera
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];

    AVCaptureVideoDataOutput* output = [[AVCaptureVideoDataOutput alloc] init];
    output.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];

    dispatch_queue_t queue = dispatch_get_main_queue();
    [output setSampleBufferDelegate:(id)self queue:queue];

	self.frame_callback = command.callbackId;
	self.frame_buffer = [NSMutableData data];

    [self.session addInput:input];
    [self.session addOutput:output];
	[self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);

    float brightness = 0;
 	int bufferWidth = CVPixelBufferGetWidth(imageBuffer);
    int bufferHeight = CVPixelBufferGetHeight(imageBuffer);
    unsigned char *pixel = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);

    for( int row = 0; row < bufferHeight; row++ ) {     
        float rowBrightness= 0;
        for( int column = 0; column < bufferWidth; column++ ) {
            float luma = 0.2126*pixel[0]+0.7152*pixel[1]+0.0722*pixel[2];
            pixel += 4;
            rowBrightness += luma;
        }
        brightness += rowBrightness / bufferWidth;
    }
    brightness = brightness / bufferHeight;
	
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
	
   	// Callback
	NSArray* params = [NSArray arrayWithObjects: [NSNumber numberWithInt:bufferWidth], [NSNumber numberWithInt:bufferHeight], [NSNumber numberWithFloat:brightness], nil];
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsMultipart: params ];

	[pluginResult setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:self.frame_callback];
}

- (void)endCapture:(CDVInvokedUrlCommand*)command
{
	if (self.session == nil)
	{
		CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No capture session is currently running."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		return;
	}

	AVCaptureSession* sessionRef = self.session;
	NSString* frameCallback = self.frame_callback;
	self.session = nil;
	self.frame_callback = nil;
	
	[sessionRef stopRunning];

	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:frameCallback];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end