//
//  main.m
//  CaptureCam
//
//  Created by Csaba Fitzl on 2021. 05. 25..
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>

// VideoSnap
@interface VideoSnap : NSObject <AVCaptureFileOutputRecordingDelegate>
@property (strong, nonatomic) AVCaptureMovieFileOutput *videoFileOutput;
@property (strong, nonatomic) AVCaptureSession *session;

-(void)record;
@end

//class implementation
@implementation VideoSnap

-(void)record {
  //grab default video and audio device
  AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
  
    //init session and output file obj
    self.session = [[AVCaptureSession alloc] init];
    
    //init audio and video input
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    
    //init video output
    self.videoFileOutput = [[AVCaptureMovieFileOutput alloc] init];

    //add input and output to session
    [self.session addInput:audioInput];
    [self.session addInput:videoInput];
    [self.session addOutput:self.videoFileOutput];

    //do the capture
    [self.session startRunning];
    
    [self.videoFileOutput startRecordingToOutputFileURL: [NSURL fileURLWithPath:@"/tmp/spycam.mov"] recordingDelegate:self];

    //stop recoding after 15 seconds
    [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(stopRecording:) userInfo:nil repeats:NO];
}

-(void)stopRecording:(int)sigNum {
 //stop recording
 [self.videoFileOutput stopRecording];
}

-(void)captureOutput:(AVCaptureFileOutput *)captureOutput
 didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
 fromConnections:(NSArray *)connections
 error:(NSError *)error {

 //stop session & exit
 [self.session stopRunning];
 exit(0);
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        VideoSnap* vs = [[VideoSnap alloc] init];
        [vs record];
        [[NSRunLoop currentRunLoop] run];
        
    }
    return NSApplicationMain(argc, argv);
}
