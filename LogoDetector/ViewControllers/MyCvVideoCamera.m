//
//  MyCvVideoCamera.m
//  LogoDetector
//
//  Created by Frederic Lemaitre on 03/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyCvVideoCamera.h"

@implementation MyCvVideoCamera

@synthesize customPreviewLayer = _customPreviewLayer;

- (void)updateOrientation;
{
    // nop
}
- (void)layoutPreviewLayer;
{
    if (self.parentView != nil) {
        CALayer* layer = self.customPreviewLayer;
        CGRect bounds = self.customPreviewLayer.bounds;
        layer.position = CGPointMake(self.parentView.frame.size.width/2., self.parentView.frame.size.height/2.);
        layer.bounds = bounds;
    }
}
@end