//
//  ViewController.h
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 2/28/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowFareAPI.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface AirfareViewController : UIViewController <lowFareAPIDelegate>

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
//+ (AirfareViewController *)search;

@end
