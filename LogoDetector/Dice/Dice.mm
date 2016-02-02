//
//  Dice.m
//  LogoDetector
//
//  Created by Frederic Lemaitre on 02/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"
#import "MLManager.h"


@implementation Dice

- (id) fillWithAray:(NSArray*)arr {

    self.pictures = [arr copy];
    
    // load UIImages
    self.img = [[NSMutableArray alloc] initWithCapacity:6];
    for (int k=1;k<=6; ++k)
    {
        //[self.img addObject:[UIImage imageNamed:@"toptal logo"]];
        NSLog(@"loading image %@",[self getPictureForFace:k]);
        [self.img addObject:[UIImage imageNamed:[self getPictureForFace:k]]];
        NSLog(@"loading ok");
    }
    
    // MSR
    self.msr = [[NSMutableArray alloc] initWithCapacity:6];
    for (int k=1;k<=6; ++k)
    {
        [self.msr addObject:[[MLManager sharedInstance] extractMSER:[self getUIImageForFace:k]]];
    }
    
    
    return self;

}

// return picture image for face n [1-6]
-(NSString*)getPictureForFace:(int)face {
    if (face<0) return nil;
    if (face>6) return nil;
    return [self.pictures objectAtIndex:(face-1)];
}

// return UIImage for face [1-6]
-(UIImage*)getUIImageForFace:(int)face {
    if (face<0) return nil;
    if (face>6) return nil;
    return (UIImage*)[self.img objectAtIndex:(face-1)];
}

// return MSERFeature for face [1-6]
-(MSERFeature*)getMSRForFace:(int)face {
    if (face<0) return nil;
    if (face>6) return nil;
    return (MSERFeature*)[self.msr objectAtIndex:(face-1)];
}

// return distance for feature with face [1-6]
-(double) distance: (MSERFeature *)feature forFace:(int)face {
    if (face<0) return 0;
    if (face>6) return 0;
    return [[self getMSRForFace:face] distance:feature];
}

// return if the face [1-6] is similar with the mser
-(BOOL)isDetected:(MSERFeature *)feature forFace:(int)face {
    
    BOOL bRet = [[MLManager sharedInstance] isStored:[self getMSRForFace:face] matchWith:feature];
    return bRet;
}

-(BOOL)isDiceDetected:(MSERFeature *)feature {
    for(int k=1; k<=6; ++k) {
        BOOL bRet = [self isDetected:feature forFace:k];
        if (bRet) {
            NSLog(@"dice 1 detected for face %d",k);
         return YES;
        }
    }
    return NO;
}

@end
