//
//  Dice.h
//  LogoDetector
//
//  Created by Frederic Lemaitre on 02/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#ifndef LogoDetector_Dice_h
#define LogoDetector_Dice_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MSERFeature.h"

@interface Dice : NSObject

// name of images for each face (ex : soleil.png)
@property NSArray * pictures;
// titles
@property NSArray * titles;
// UIImage for each face;
@property NSMutableArray * img;
// MSRfeature for each face;
@property NSMutableArray * msr;
// current face detected (0 if none)
@property int faceDetected;

/*
 init dice with pictures for each face
 */
-(id)fillWithAray: (NSArray*)arr andTitles:(NSArray*)titles;

-(NSString*)getPictureForFace:(int)face;

-(NSString*)getTitleForFace:(int)face;

-(UIImage*)getUIImageForFace:(int)face;

-(MSERFeature*)getMSRForFace:(int)face;

-(BOOL)isDetected:(MSERFeature *)feature forFace:(int)face;

-(BOOL)isDiceDetected:(MSERFeature *)feature;

-(double) distance: (MSERFeature *)feature forFace:(int)face;

@end



#endif
