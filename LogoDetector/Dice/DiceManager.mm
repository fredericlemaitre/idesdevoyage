//
//  DiceManager.m
//  LogoDetector
//
//  Created by Frederic Lemaitre on 02/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DiceManager.h"



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
    NSArray *array1 =[NSArray arrayWithObjects:@"un",@"deux",@"trois",@"quatre",@"cinq",@"six", nil];
    self.dice1 = [[[Dice alloc] init] fillWithAray:array1];
    
    NSLog(@"picture for face 2 : %@", [self.dice1 getPictureForFace:2]);
    
    // STORE PICTURES
    
    
    
    
}

@end