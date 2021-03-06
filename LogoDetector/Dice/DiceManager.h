//
//  DiceManager.h
//  LogoDetector
//
//  Created by Frederic Lemaitre on 02/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#ifndef LogoDetector_DiceManager_h
#define LogoDetector_DiceManager_h

#import <UIKit/UIKit.h>
#import "Dice.h"


@interface DiceManager : NSObject

// first dice (locations)
@property Dice * dice1;



+ (DiceManager *) sharedInstance;

/*
 init dices
 */
- (void) initDices;

-(BOOL)isDice1Detected:(MSERFeature *)feature;
-(int)getDice1FaceDetected;
-(UIImage*)getDiceImageForFace:(int)face;
-(NSString*)getTitleForFace:(int)face;

@end


#endif
