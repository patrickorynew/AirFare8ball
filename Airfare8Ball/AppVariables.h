//
//  AppVariables.h
//  SRMWClient
//
//  Created by Nathan Stoltenberg on 2/7/13.
//  Copyright (c) 2014 Sabre Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

UIColor* color;
UIColor* color2;
UIColor* color3;
UIColor* color4;
UIColor *color6;
UIColor* color10;
UIColor* color11;
UIColor* color12;

//NSString *apiToken;
//KeychainItemWrapper *apiSecureToken;

NSMutableParagraphStyle* paragraphStyle;
NSDictionary* textFontAttributes;
NSDictionary* labelFontAttributes;
NSString* strOriginAirport;
NSString* strDestinationAirport;
NSString* strDepartureDate;
NSString* strReturnDate;

int intLastResult;
int HighestPredictedFare;
int LowestPredictedFare;
int LowestFare;


@interface AppVariables : NSObject
{
}
+ (KeychainItemWrapper *)apiSecureToken;
+ (void)initialize;
+ (NSString *)toBase64String:(NSString *)string;

+ (NSString*)apiToken;
+ (void)setAPIToken:(NSString*)token;

@end