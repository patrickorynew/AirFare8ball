//
//  AirFareView.m
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 3/5/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import "AirFareView.h"
#import "DateInputViewController.h"
#import "AppVariables.h"
#import "AppConstants.h"
@implementation AirFareView
@synthesize  departureDateInputRect,
departureDatePlaceholderContent,
destinationAirportPlaceholderContent,
departureDateLabelContent,
destinationAirportInputRect,
destinationAirportLabelContent,
originAirportPlaceholderContent,
originAirportInputRect,
originAirportLabelContent,
returnDatePlaceholderContent,
returnDateInputRect,
returnDateLabelContent,
screenHeaderContent,
shakeFooterContent,
departureDateTextField,
destinationAirportTextField,
originAirportTextField,
returnDateTextField;

UIDatePicker *departureDatePicker;
UIDatePicker *returnDatePicker;
UITextField* currentTextField;
UIToolbar *toolbarAccessory;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    [self drawAcessoryView];
    
    paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment: NSTextAlignmentLeft];
    textFontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName: @"Helvetica" size: 24], NSFontAttributeName, color6, NSForegroundColorAttributeName, paragraphStyle, NSParagraphStyleAttributeName, nil];
    labelFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-Light" size: 24], NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: paragraphStyle};
    
    //// Abstracted Attributes
    screenHeaderContent = @"Airfare Details";
    originAirportInputRect = CGRectMake(26, 126, 274, 48);
    originAirportLabelContent = @"From";
    originAirportPlaceholderContent = @"Airport Code...";
    destinationAirportInputRect = CGRectMake(24, 226, 274, 48);
    destinationAirportLabelContent = @"To";
    destinationAirportPlaceholderContent = @"Airport Code...";
    departureDateInputRect = CGRectMake(21, 326, 274, 48);
    departureDateLabelContent = @"Departure Date";
    departureDatePlaceholderContent = @"Date (YYYY-MM-DD)";
    returnDateInputRect = CGRectMake(25, 426, 274, 48);
    returnDateLabelContent = @"Return Date";
    returnDatePlaceholderContent = @"Date (YYYY-MM-DD)";
    shakeFooterContent = @"Shake to Ask";
    
    
    //// screenHeader Drawing
    CGRect screenHeaderRect = CGRectMake(0, 14, 321, 85);
    NSMutableParagraphStyle* screenHeaderStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [screenHeaderStyle setAlignment: NSTextAlignmentCenter];
    
    NSDictionary* screenHeaderFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 48], NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: screenHeaderStyle};
    
    [screenHeaderContent drawInRect: screenHeaderRect withAttributes: screenHeaderFontAttributes];
    
    
    [self drawOriginAirport];
    
    [self drawDestinationAirport];
    
    [self drawDepartureDate];
    
    [self drawReturnDate];
    
    
    //// shakeFooter Drawing
    CGRect shakeFooterRect = CGRectMake(0, 503, 320, 65);
    NSMutableParagraphStyle* shakeFooterStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [shakeFooterStyle setAlignment: NSTextAlignmentCenter];
    
    NSDictionary* shakeFooterFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 48], NSForegroundColorAttributeName: color3, NSParagraphStyleAttributeName: shakeFooterStyle};
    
    [shakeFooterContent drawInRect: shakeFooterRect withAttributes: shakeFooterFontAttributes];
}

- (void)drawBoxForRect:(CGRect)rect
{
    UIBezierPath* originAirportInputPath = [UIBezierPath bezierPathWithRoundedRect: rect cornerRadius: 8];
    [color2 setFill];
    [originAirportInputPath fill];
    [color setStroke];
    originAirportInputPath.lineWidth = 1;
    [originAirportInputPath stroke];
}

- (UITextField*)drawTextFieldInRect:(CGRect)rect withPlaceholder:(NSString*)placeholder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectInset(rect, 12, 9)];
    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:placeholder attributes:textFontAttributes]];
    [textField setTextColor:color];
    [textField setFont:[textFontAttributes objectForKey:NSFontAttributeName]];
    [textField setDelegate: self];
    [textField setInputAccessoryView:toolbarAccessory];
    [self addSubview:textField];
    return textField;
}

- (void)drawOriginAirport
{
    //// originAirportInput Drawing
    [self drawBoxForRect:originAirportInputRect];
    originAirportTextField = [self drawTextFieldInRect:originAirportInputRect withPlaceholder:originAirportPlaceholderContent];
    
    //// originAirportLabel Drawing
    CGRect originAirportLabelRect = CGRectMake(24, 93, 157, 26);
    [originAirportLabelContent drawInRect: originAirportLabelRect withAttributes: labelFontAttributes];
}

- (void)drawDestinationAirport
{
    //// destinationAirportInput Drawing
    [self drawBoxForRect:destinationAirportInputRect];
    destinationAirportTextField = [self drawTextFieldInRect:destinationAirportInputRect withPlaceholder:destinationAirportPlaceholderContent];
    
    //// destinationAirportLabel Drawing
    CGRect destinationAirportLabelRect = CGRectMake(25, 193, 157, 26);
    [destinationAirportLabelContent drawInRect: destinationAirportLabelRect withAttributes: labelFontAttributes];

}

- (void)drawDepartureDate
{
    //// departureDateInput Drawing
    [self drawBoxForRect:departureDateInputRect];
    departureDateTextField = [self drawTextFieldInRect:departureDateInputRect withPlaceholder:departureDatePlaceholderContent];
    departureDatePicker = [self addDatePickerForTextField:departureDateTextField];
    [departureDatePicker addTarget:self action:@selector(departureDateChanged:)      forControlEvents:UIControlEventValueChanged];
    
    //// departureDateLabel Drawing
    CGRect departureDateLabelRect = CGRectMake(22, 293, 300, 26);
    
    [departureDateLabelContent drawInRect: departureDateLabelRect withAttributes: labelFontAttributes];
}

- (void)drawReturnDate
{
    //// returnDateInput Drawing
    [self drawBoxForRect:returnDateInputRect];
    returnDateTextField = [self drawTextFieldInRect:returnDateInputRect withPlaceholder:returnDatePlaceholderContent];
    returnDatePicker = [self addDatePickerForTextField:returnDateTextField];
    [returnDatePicker addTarget:self action:@selector(returnDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    //// returnDateLabel Drawing
    CGRect returnDateLabelRect = CGRectMake(26, 393, 157, 26);
    [returnDateLabelContent drawInRect: returnDateLabelRect withAttributes: labelFontAttributes];
}

- (UIDatePicker*)addDatePickerForTextField:(UITextField*)textField
{
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    [picker setDatePickerMode:UIDatePickerModeDate];
    [picker setBackgroundColor:[UIColor whiteColor]];
    [picker setMinimumDate:[NSDate date]];
    [textField setInputView:picker];
    return picker;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0){
    if (textField == returnDateTextField)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        returnDateTextField.text = [formatter stringFromDate:returnDatePicker.date];
    }
    else if (textField == departureDateTextField)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        departureDateTextField.text = [formatter stringFromDate:departureDatePicker.date];
    }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == originAirportTextField || textField == destinationAirportTextField)
	{
//        string = [AppVariables convertKeyBinding:string];
        
		textField.text = [textField.text stringByReplacingCharactersInRange:range
																 withString:[string uppercaseStringWithLocale:[NSLocale currentLocale]]];
		return NO;
	}
	return YES;
}

- (IBAction)departureDateChanged:(id)sender {
    UIDatePicker *picker = (UIDatePicker*)sender;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    departureDateTextField.text = [formatter stringFromDate:picker.date];
}

- (IBAction)returnDateChanged:(id)sender {
    UIDatePicker *picker = (UIDatePicker*)sender;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    returnDateTextField.text = [formatter stringFromDate:picker.date];
}

- (BOOL) hasData
{
    if (originAirportTextField.text.length == 0 || destinationAirportTextField.text.length == 0 || departureDateTextField.text.length == 0 || returnDateTextField.text.length == 0)
        return FALSE;
    return TRUE;
}


#pragma mark - Accessory View
- (void)drawAcessoryView
{
	CGRect rect = CGRectMake(0, 0, 320, 40);
    
	toolbarAccessory = [[UIToolbar alloc]initWithFrame:rect];
    [toolbarAccessory setTintColor:[UIColor colorWithWhite:222/255.0f alpha:1.0f]];
	toolbarAccessory.barStyle = UIBarStyleBlackTranslucent;
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Prev", @"Next"]];
	[segmentedControl addTarget:self action:@selector(selectAdjacentResponder:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.momentary = YES;
    segmentedControl.accessibilityIdentifier = @"SegmentedControl";
	UIBarButtonItem *segmentedControlBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
	UIBarButtonItem *spacebutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *barbtnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton:)];
	toolbarAccessory.items = @[ segmentedControlBarButtonItem, spacebutton, barbtnDone ];
}

- (void)selectAdjacentResponder:(UISegmentedControl *)sender
{
	if (sender.selectedSegmentIndex == 0)
	{
		[self previousButtonClicked];
	}
    
	else
	{
		[self nextButtonClicked];
	}
}

- (void)nextButtonClicked
{
    
	if (currentTextField == originAirportTextField)
	{
		[destinationAirportTextField becomeFirstResponder];
	}
	else if (currentTextField == destinationAirportTextField)
	{
		[departureDateTextField becomeFirstResponder];
	}
    else if (currentTextField == departureDateTextField)
    {
        [returnDateTextField becomeFirstResponder];
    }
}

- (void)previousButtonClicked
{
	if (currentTextField == destinationAirportTextField)
	{
		[originAirportTextField becomeFirstResponder];
	}
	else if (currentTextField == departureDateTextField)
	{
		[destinationAirportTextField becomeFirstResponder];
	}
    else if (currentTextField == returnDateTextField)
    {
        [departureDateTextField becomeFirstResponder];
    }
}

- (void)doneButton:(id)sender
{
    NSLog(@"Done");
    [currentTextField resignFirstResponder];
}

@end
