//
//  ResultViewController.m
//  LogoDetector
//
//  Created by Frederic Lemaitre on 02/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResultViewController.h"

@implementation ResultViewController

- (IBAction)returnToDices:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToBook:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.sejour.voyages-sncf.com/offre/sejour-malte/la-valette/seabank-4-etoiles-sup/id,442240/"]];

}


@end