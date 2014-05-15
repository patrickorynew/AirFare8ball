//
//  AppDelegate.h
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 2/28/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_T ([[UIScreen mainScreen] bounds].size.height == 568)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ (void)warningAlertView:(NSString *)title messege:(NSString *)message;
@end
