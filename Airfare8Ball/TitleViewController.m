//
//  TitleViewController.m
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 2/28/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import "TitleViewController.h"
#import "AppVariables.h"
#import "AppConstants.h"

@interface TitleViewController ()
@property UILabel *lblTitle;

@end

@implementation TitleViewController
@synthesize lblTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    color2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0];
    color3 = [UIColor colorWithRed: 0.5 green: 0.5 blue: 0.5 alpha: 1];
    color6 = [UIColor colorWithRed: 0.333 green: 0.333 blue: 0.333 alpha: 1];
    color4 = [UIColor colorWithRed: 0.667 green: 0.667 blue: 0.667 alpha: 1];
    color10 = [UIColor colorWithRed: 0 green: 0.532 blue: 1 alpha: 0.5];
    color11 = [UIColor colorWithRed: 0.114 green: 1 blue: 0.114 alpha: 1];
    color12 = [UIColor colorWithRed: 1 green: 0.114 blue: 0.114 alpha: 1];
    
    [super viewDidLoad];
    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [lblTitle setText:@"AirFare8Ball"];
    [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:48]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:color];
    [self.view addSubview:lblTitle];
	// Do any additional setup after loading the view.
    [self performSelector:@selector(nextView) withObject:nil afterDelay:1.0];
}

- (void)nextView
{
    [self performSegueWithIdentifier:@"titleTransition" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
