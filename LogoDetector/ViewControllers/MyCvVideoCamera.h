//
//  MyCvVideoCamera.h
//  LogoDetector
//
//  Created by Frederic Lemaitre on 03/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#ifndef LogoDetector_MyCvVideoCamera_h
#define LogoDetector_MyCvVideoCamera_h

#import <opencv2/highgui/cap_ios.h>

@protocol CvVideoCameraDelegateMod <CvVideoCameraDelegate>
@end

@interface MyCvVideoCamera : CvVideoCamera

- (void)updateOrientation;
- (void)layoutPreviewLayer;

@property (nonatomic, retain) CALayer *customPreviewLayer;

@end

#endif
