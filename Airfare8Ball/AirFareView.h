//
//  AirFareView.h
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 3/5/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface AirFareView : UIView <UITextFieldDelegate> {
    NSString* screenHeaderContent;
    CGRect originAirportInputRect;
    NSString* originAirportLabelContent;
    NSString* originAirportPlaceholderContent;
    CGRect destinationAirportInputRect;
    NSString* destinationAirportLabelContent;
    NSString* destinationAirportPlaceholderContent;
    CGRect departureDateInputRect;
    NSString* departureDateLabelContent;
    NSString* departureDatePlaceholderContent;
    CGRect returnDateInputRect;
    NSString* returnDateLabelContent;
    NSString* returnDatePlaceholderContent;
    NSString* shakeFooterContent;
    UITextField *originAirportTextField;
    UITextField *destinationAirportTextField;
    UITextField *departureDateTextField;
    UITextField *returnDateTextField;
}

@property (nonatomic,strong) NSString* screenHeaderContent;
@property (nonatomic,readwrite) CGRect originAirportInputRect;
@property (nonatomic,strong) NSString* originAirportLabelContent;
@property (nonatomic,strong) NSString* originAirportPlaceholderContent;
@property (nonatomic,readwrite) CGRect destinationAirportInputRect;
@property (nonatomic,strong) NSString* destinationAirportLabelContent;
@property (nonatomic,strong) NSString* destinationAirportPlaceholderContent;
@property (nonatomic,readwrite) CGRect departureDateInputRect;
@property (nonatomic,strong) NSString* departureDateLabelContent;
@property (nonatomic,strong) NSString* departureDatePlaceholderContent;
@property (nonatomic,readwrite) CGRect returnDateInputRect;
@property (nonatomic,strong) NSString* returnDateLabelContent;
@property (nonatomic,strong) NSString* returnDatePlaceholderContent;
@property (nonatomic,strong) NSString* shakeFooterContent;
@property (nonatomic,strong) UITextField *originAirportTextField;
@property (nonatomic,strong) UITextField *destinationAirportTextField;
@property (nonatomic,strong) UITextField *departureDateTextField;
@property (nonatomic,strong) UITextField *returnDateTextField;

- (BOOL) hasData;

@end
