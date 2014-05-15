//
//  AppConstants.h
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 3/11/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//
#import "AppDelegate.h"

#define SCREEN_WIDTH (IS_IPHONE? 320:1024)
#define SCREEN_HEIGHT (IS_IPHONE? (IS_T? 568:480):768)

static const float URL_REQUEST_TIMEOUT = 30;