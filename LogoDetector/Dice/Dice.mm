//
//  Dice.m
//  LogoDetector
//
//  Created by Frederic Lemaitre on 02/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"


@implementation Dice

- (id) fillWithAray:(NSArray*)arr {

    self.pictures = [arr copy];
    
    // load UIImages
    self.img = [[NSMutableArray alloc] initWithCapacity:6];
    for (int k=1;k<=6; ++k)
    {
        //[self.img addObject:[UIImage imageNamed:[self getPictureForFace:k]]];
    }
    
    // MSR
    self.msr = [[NSMutableArray alloc] initWithCapacity:6];
    
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



@end
