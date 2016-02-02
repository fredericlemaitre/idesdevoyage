//
//  DiceManager.m
//  LogoDetector
//
//  Created by Frederic Lemaitre on 02/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DiceManager.h"
#import "MSERManager.h"



@implementation DiceManager

+ (DiceManager *) sharedInstance
{
    static DiceManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DiceManager alloc] init];
    });
    
    return instance;
}

-(void) initDices
{
    NSLog(@"init dices");
    
    // DICE 1
    NSArray *array1 =[NSArray arrayWithObjects:@"1_1-plage",@"1_2-montagne",@"1_3-ville",@"1_4-nature",@"1_5-insolite",@"1_6-soleil", nil];
    self.dice1 = [[[Dice alloc] init] fillWithAray:array1];
    
}

-(BOOL)isDice1Detected:(MSERFeature *)feature {
    return [self.dice1 isDiceDetected:feature];
}

// return the face detected [1-6] If 0 => no detection
-(int)getDice1FaceDetected:(std::vector<std::vector<cv::Point>> &) msers {
    
    std::vector<cv::Point> *bestMser = nil;
    double bestPoint = 0.0;
    int bestface = 0;
    
    std::for_each(msers.begin(), msers.end(), [&] (std::vector<cv::Point> &mser)
    {
        MSERFeature *feature = [[MSERManager sharedInstance] extractFeature: &mser];
        if(feature != nil)
        {
            for(int k=1;k<=6;++k) {
                if ([self.dice1 isDetected:feature forFace:k]) {
                    double tmp = [self.dice1 distance: feature forFace:k ];
                    if ( bestPoint==0 || bestPoint > tmp ) {
                        bestPoint = tmp;
                        bestMser = &mser;
                        bestface = k;
                    }

                }
            }
            
        }
    });
    
    
    return bestface;
}


@end