//
//  ViewController.m
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 2/28/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import "AirfareViewController.h"
#import "AirFareView.h"
#import "AppVariables.h"
#import "ResultViewController.h"

@interface AirfareViewController () {
    AirFareView *airView;
}
@property (strong, nonatomic) IBOutlet AirFareView *airView;
@property (strong, nonatomic) IBOutlet UITextField *txtFrom;
@property (strong, nonatomic) IBOutlet UILabel *lblFrom;
@property (strong, nonatomic) IBOutlet UITextField *txtTo;
@property (strong, nonatomic) IBOutlet UILabel *lblTo;
@property (strong, nonatomic) IBOutlet UILabel *lblDepart;
@property (strong, nonatomic) IBOutlet UITextField *txtDepart;
@property (strong, nonatomic) IBOutlet UILabel *lblReturn;
@property (strong, nonatomic) IBOutlet UITextField *txtReturn;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPrompt;
@property (strong, nonatomic) IBOutlet UIView *viewLoading;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityLoading;


@end

//static AirfareViewController *_AirfareViewController = nil;

@implementation AirfareViewController
@synthesize airView;
@synthesize  viewLoading,activityLoading;

//+ (AirfareViewController *)search
//{
//    @synchronized([AirfareViewController class])
//	{
//		if (!_AirfareViewController)
//		{
//			_AirfareViewController = [[AirfareViewController alloc]init];
//		}
//		return _AirfareViewController;
//	}
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    color2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0];
    color3 = [UIColor colorWithRed: 0.5 green: 0.5 blue: 0.5 alpha: 1];
    color6 = [UIColor colorWithRed: 0.333 green: 0.333 blue: 0.333 alpha: 1];
    color4 = [UIColor colorWithRed: 0.667 green: 0.667 blue: 0.667 alpha: 1];
    color10 = [UIColor colorWithRed: 0 green: 0.532 blue: 1 alpha: 0.5];
    color11 = [UIColor colorWithRed: 0.114 green: 1 blue: 0.114 alpha: 1];
    color12 = [UIColor colorWithRed: 1 green: 0.114 blue: 0.114 alpha: 1];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        if ([airView hasData])
        [self doSearch];
    } 
}

-(BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void)doSearch
{
    [viewLoading setHidden:FALSE];
    [activityLoading startAnimating];
    [[lowFareAPI api] lowFareSearchForOrigin:airView.originAirportTextField.text Destination:airView.destinationAirportTextField.text Departure:airView.departureDateTextField.text Return:airView.returnDateTextField.text];
    [[lowFareAPI api] setDelegate:self];
}

-(void)requestFinished
{
    [viewLoading setHidden:TRUE];
    [activityLoading stopAnimating];
}

@end
