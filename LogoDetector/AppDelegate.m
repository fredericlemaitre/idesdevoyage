////////
// This sample is published as part of the blog article at www.toptal.com/blog 
// Visit www.toptal.com/blog and subscribe to our newsletter to read great posts
////////

//
//  AppDelegate.m
//  LogoDetector
//
//  Created by altaibayar tseveenbayar on 13/05/15.
//  Copyright (c) 2015 altaibayar tseveenbayar. All rights reserved.
//

#import "AppDelegate.h"

#import "MLManager.h"
#import "DiceManager.h"


#define FIRST_START_KEY @"FIRST_START"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    if ([self isFirstStart])
    {   
        //[[MLManager sharedInstance] learn: [UIImage imageNamed: @"toptal logo"]];
        //[[MLManager sharedInstance] learn: [UIImage imageNamed: @"1_1-plage"]];
        //[[MLManager sharedInstance] learn: [UIImage imageNamed: @"1_2-montagne"]]; // KO
        //[[MLManager sharedInstance] learn: [UIImage imageNamed: @"1_3-ville"]]; // OK
        //[[MLManager sharedInstance] learn: [UIImage imageNamed: @"1_4-nature"]]; // OK
        //[[MLManager sharedInstance] learn: [UIImage imageNamed: @"1_5-insolite"]]; // KO
        //[[MLManager sharedInstance] learn: [UIImage imageNamed: @"1_6-soleil"]]; // KO
        [[DiceManager sharedInstance] initDices];
        [self setFirstStartFlag];
    }
    
    return YES;
}

#pragma mark - first start 

- (BOOL) isFirstStart
{
//#if DEBUG
    return YES;
//#else
  //  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   // return [defaults objectForKey: FIRST_START_KEY] != nil;
//#endif
}

- (void) setFirstStartFlag
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: @":)" forKey: FIRST_START_KEY];
    [defaults synchronize];
}

@end
