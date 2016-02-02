////////
// This sample is published as part of the blog article at www.toptal.com/blog 
// Visit www.toptal.com/blog and subscribe to our newsletter to read great posts
////////

//
//  CameraViewController.h
//  LogoDetector
//
//  Created by altaibayar tseveenbayar on 13/05/15.
//  Copyright (c) 2015 altaibayar tseveenbayar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>

@interface CameraViewController : UIViewController < CvVideoCameraDelegate >

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (retain, nonatomic) IBOutlet UIImageView *dice1;
@property (retain, nonatomic) IBOutlet UIImageView *slot1;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UIView *loadingView;

@property (retain, nonatomic) IBOutlet UITextView *titleSlot;
@property (retain, nonatomic) IBOutlet UITextView *subtitleSlot;




@end
