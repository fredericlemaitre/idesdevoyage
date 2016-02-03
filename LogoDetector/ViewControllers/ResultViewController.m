//
//  ResultViewController.m
//  LogoDetector
//
//  Created by Frederic Lemaitre on 02/02/2016.
//  Copyright (c) 2016 altaibayar tseveenbayar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResultViewController.h"
#import "DiceManager.h"

@interface ResultViewController()
{
    NSString* url;
}

@end

@implementation ResultViewController

- (BOOL)shouldAutorotate {
    return NO;
}

- (void) viewDidLoad
{
    
    NSString* bgToLoad;
    
    int face = [[DiceManager sharedInstance] getDice1FaceDetected];
    
   switch(face) {
    case 1:
            //plage
            bgToLoad = @"Plage.png";
            url = @"http://m.sejour.voyages-sncf.com/offre/autotour-corse/bastia/autotour-corse-en-liberte---decouverte-de-l-ile-de-beaute/id,401384/";
        break;
    case 2:
            // montagne
            bgToLoad = @"Montagne.png";
            url = @"http://m.sejour.voyages-sncf.com/offre/circuit-nepal/kathmandou/splendeurs-du-nepal---hiver-15-16/id,565967/";
        break;
    case 3:
            // ville
            bgToLoad = @"Ville.png";
            url = @"http://m.sejour.voyages-sncf.com/offre/autotour-etats-unis/new-york/autotour-escapade-urbaine-3-etoiles/id,509903/";

        break;
    case 4:
            // nature
            bgToLoad = @"Nature.png";
            url = @"http://m.sejour.voyages-sncf.com/offre/week-end-thalasso-alpes/week-end-thalasso-la-plagne/hotel-la-tourmaline-3-etoiles--acces-spa/id,584894/";

        break;
    case 5:
            //insolite
            bgToLoad = @"Insolite.png";
            url =@"http://m.sejour.voyages-sncf.com/offre/circuit-maroc/marrakech/circuit-oasis-en-4x4/id,244255/";

        break;
    case 6:
            // au soleil
            bgToLoad = @"Soleil.png";
            url = @"http://m.sejour.voyages-sncf.com/offre/autotour-corse/bastia/autotour-corse-en-liberte---decouverte-de-l-ile-de-beaute/id,401384/";

            
        break;
    
    default: return;
    }
    
    if(bgToLoad != nil)
    {
        self.bg.image = [UIImage imageNamed:bgToLoad];
    }
    
    [super viewDidLoad];
    
}


- (IBAction)returnToDices:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToBook:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


@end