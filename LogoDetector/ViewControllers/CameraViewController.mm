////////
// This sample is published as part of the blog article at www.toptal.com/blog 
// Visit www.toptal.com/blog and subscribe to our newsletter to read great posts
////////

//
//  CameraViewController.m
//  LogoDetector
//
//  Created by altaibayar tseveenbayar on 13/05/15.
//  Copyright (c) 2015 altaibayar tseveenbayar. All rights reserved.
//

#import "CameraViewController.h"
#import <opencv2/highgui/ios.h>

#import "MSERManager.h"
#import "MLManager.h"
#import "ImageUtils.h"
#import "GeometryUtil.h"
#import "DiceManager.h"
#import "ImageUtils.h"

#ifdef DEBUG
#import "FPS.h"
#endif

#include "MyCvVideoCamera.h"

//this two values are dependant on defaultAVCaptureSessionPreset
#define W (480)
#define H (640)

//#define OPTIMIZE_FRAME
#define NB_SKIP_FRAME 4
//#define SHOW_MSR
//#define INITIAL_CODE

@interface CameraViewController()
{
    MyCvVideoCamera *camera;
    BOOL started;
    
    cv::Rect lastFound;
    int counterOptimizeFrame;
    
    int shownSlot;
}

@end

@implementation CameraViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    //UI
    [_btn setTitle: @" " forState: UIControlStateNormal];
    
    //Camera
    camera = [[MyCvVideoCamera alloc] initWithParentView: _img];
    camera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    camera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    camera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    camera.defaultFPS = 20;
    camera.grayscaleMode = NO;
    camera.delegate = self;
    
    lastFound = cv::Rect(0, 0, W, H);
    counterOptimizeFrame = 0;
    
    shownSlot = 0;
    started = YES;
    self.btn.hidden = YES;
    self.loadingView.hidden = NO;
    self.subtitleSlot.hidden = YES;
    [self.subtitleSlot sizeToFit];
    self.focus.hidden = YES;
    
    [self disableAutoFocus];
    
}

- (BOOL)shouldAutorotate {
    return NO;
}

// unregister observer
/*
- (void)viewWillDisappear:(BOOL)animated{
    AVCaptureDevice *camDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [camDevice removeObserver:self forKeyPath:@"adjustingFocus"];
    
    [super viewWillDisappear: animated];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if( [keyPath isEqualToString:@"adjustingFocus"] ){
        BOOL adjustingFocus = [ [change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1] ];
        NSLog(@"Is adjusting focus? %@", adjustingFocus ? @"YES" : @"NO" );
        NSLog(@"Change dictionary: %@", change);
        
         dispatch_async(dispatch_get_main_queue(), ^{
             self.focus.hidden = !adjustingFocus;
        });
    }
}

// register observer
- (void)viewWillAppear:(BOOL)animated{
    AVCaptureDevice *camDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    int flags = NSKeyValueObservingOptionNew;
    [camDevice addObserver:self forKeyPath:@"adjustingFocus" options:flags context:nil];
    
    [super viewWillAppear: animated];
}
*/

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    //[self test];
    [camera start];
    
    [self.loading startAnimating];
}

-(void)disableAutoFocus
{
    NSArray *devices = [AVCaptureDevice devices];
    NSError *error;
    for (AVCaptureDevice *device in devices) {
        if (([device hasMediaType:AVMediaTypeVideo]) &&
            ([device position] == AVCaptureDevicePositionBack) ) {
            [device lockForConfiguration:&error];
            /*if ([device isFocusModeSupported:AVCaptureFocusModeLocked]) {
                device.focusMode = AVCaptureFocusModeLocked;
                NSLog(@"Focus locked");
            }*/
            
            if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                CGPoint autofocusPoint = CGPointMake(0.5f, 0.5f);
                [device setFocusPointOfInterest:autofocusPoint];
                [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
            }

            if ([device isExposureModeSupported:AVCaptureExposureModeLocked]) {
                CGPoint exposurePoint = CGPointMake(0.5f, 0.5f);
                [device setExposurePointOfInterest:exposurePoint];
                [device setExposureMode:AVCaptureExposureModeLocked];
            }

            
            [device unlockForConfiguration];
        }
    }
}

- (void) test
{
    UIImage *logo = [UIImage imageNamed: @"toptal logo"];
    cv::Mat image = [ImageUtils cvMatFromUIImage: logo];

    //get gray image
    cv::Mat gray;
    cvtColor(image, gray, CV_BGRA2GRAY);
    
    //mser with maximum area is
    std::vector<cv::Point> mser = [ImageUtils maxMser: &gray];
    
    //get 4 vertices of the maxMSER minrect
    cv::RotatedRect rect = cv::minAreaRect(mser);    
    cv::Point2f points[4];
    rect.points(points);
    
    //normalize image
    cv::Mat M = [GeometryUtil getPerspectiveMatrix: points toSize: rect.size];
    cv::Mat normalizedImage = [GeometryUtil normalizeImage: &gray withTranformationMatrix: &M withSize: rect.size.width];

    //get maxMser from normalized image
    std::vector<cv::Point> normalizedMser = [ImageUtils maxMser: &normalizedImage];
    
    _img.backgroundColor = [UIColor greenColor];
    _img.contentMode = UIViewContentModeCenter;
    _img.image = [ImageUtils UIImageFromCVMat: normalizedImage];
    
}

- (IBAction)btn_TouchUp:(id)sender 
{
    //started = !started;
    NSLog(@"touchp");
    
}



-(void)showImageForDice1:(int)face {
    
    if (face == shownSlot) return;
    shownSlot = face;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.btn.hidden = NO;
        self.loadingView.hidden = YES;

  
        self.slot1.image = [UIImage imageNamed:@"select-ok.png"];
        self.dice1.image = [[DiceManager sharedInstance] getDiceImageForFace:face];
        
        self.titleSlot.textColor = [ImageUtils colorFromHexString:@"#7ABA1F"];
        
        self.subtitleSlot.text = [[DiceManager sharedInstance] getTitleForFace:face];
        self.subtitleSlot.hidden = NO;
        self.subtitleSlot.TextAlignment=NSTextAlignmentCenter;
        
        CALayer *layer = self.view.layer;
        [layer setNeedsDisplay];
        [layer displayIfNeeded];
        
        [self.view setNeedsDisplay];
        
    
    });
    
    
}

-(void)processImage:(cv::Mat &)image
{    
    if (!started) {
#ifdef DEBUG
        [FPS draw: image];
#endif
        return;
    }
    
#ifdef OPTIMIZE_FRAME
    ++counterOptimizeFrame;
    
    if(counterOptimizeFrame < NB_SKIP_FRAME)
    {
        if (lastFound != cv::Rect(0,0,0,0)) {
            cv::rectangle(image, lastFound, GREEN, 3);
        }
       
        [FPS draw: image];
        return;
    }
    counterOptimizeFrame = 0;
#endif
    
    
    // ID
    cv::Mat gray;
    cvtColor(image, gray, CV_BGRA2GRAY);
    std::vector<std::vector<cv::Point>> msers;
    [[MSERManager sharedInstance] detectRegions: gray intoVector: msers];
    std::vector<cv::Point> *bestMser = nil;
   
    std::for_each(msers.begin(), msers.end(), [&] (std::vector<cv::Point> &mser)
      {
                      MSERFeature *feature = [[MSERManager sharedInstance] extractFeature: &mser];
                      
                      if(feature != nil)
                      {
                          if([[DiceManager sharedInstance] isDice1Detected:feature] )
                          {
                              int face =[[DiceManager sharedInstance] getDice1FaceDetected];
                              //NSLog(@"dice 1 detected for face %d", face);
                              bestMser = &mser;
                              cv::Rect bound = cv::boundingRect(*bestMser);
                              lastFound = bound;
                              cv::rectangle(image, bound, GREEN, 3);
                              [self showImageForDice1:face];
                              
                              
                              //[ImageUtils drawMser: &mser intoImage: &image withColor: GREEN];
                          }
                          else
                          {
                              //[ImageUtils drawMser: &mser intoImage: &image withColor: RED];
                          }
                          
                      }
                      else 
                      {
                          //[ImageUtils drawMser: &mser intoImage: &image withColor: BLUE];
                      }
      });
  
    
#if DEBUG
    const char* str_fps = [[NSString stringWithFormat: @"MSER: %ld", msers.size()] cStringUsingEncoding: NSUTF8StringEncoding];
    cv::putText(image, str_fps, cv::Point(10, H - 10), CV_FONT_HERSHEY_PLAIN, 1.0, RED);
    [FPS draw: image];
#endif
    

/*
#ifdef INITIAL_CODE
    cv::Mat gray;
    cvtColor(image, gray, CV_BGRA2GRAY);
   
    
    std::vector<std::vector<cv::Point>> msers;
    [[MSERManager sharedInstance] detectRegions: gray intoVector: msers];
    if (msers.size() == 0) { [FPS draw: image]; return; };
    
    std::vector<cv::Point> *bestMser = nil;
    double bestPoint = 0.0;
    
    std::for_each(msers.begin(), msers.end(), [&] (std::vector<cv::Point> &mser) 
    {
        MSERFeature *feature = [[MSERManager sharedInstance] extractFeature: &mser];
    
        if(feature != nil)            
        {
            if([[MLManager sharedInstance] isToptalLogo: feature] )
            {
                double tmp = [[MLManager sharedInstance] distance: feature ];
                if ( bestPoint==0 || bestPoint > tmp ) {
                    bestPoint = tmp;
                    bestMser = &mser;
                }
                
#ifdef SHOW_MSR
                [ImageUtils drawMser: &mser intoImage: &image withColor: GREEN];
#endif
            }
            else
            {
                //NSLog(@"%@", [feature toString]);
#ifdef SHOW_MSR
                [ImageUtils drawMser: &mser intoImage: &image withColor: RED];
#endif
            }

        }
        else 
        {
            //[ImageUtils drawMser: &mser intoImage: &image withColor: BLUE];
        }
    });

    if (bestMser)
    {
        //NSLog(@"minDist: %f", bestPoint);

        cv::Rect bound = cv::boundingRect(*bestMser);
        lastFound = bound;
        cv::rectangle(image, bound, GREEN, 3);
    }
    else 
    {
        //cv::rectangle(image, cv::Rect(0, 0, W, H), RED, 3);
        lastFound = cv::Rect(0, 0, 0, 0);
    }

#if DEBUG
    const char* str_fps = [[NSString stringWithFormat: @"MSER: %ld", msers.size()] cStringUsingEncoding: NSUTF8StringEncoding];
    cv::putText(image, str_fps, cv::Point(10, H - 10), CV_FONT_HERSHEY_PLAIN, 1.0, RED);
    
    [FPS draw: image];#endif
    
#endif // INITIAL_CODE
 */
    
}

@end
