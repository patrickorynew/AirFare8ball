//
//  ResultViewController.m
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 2/28/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import "ResultViewController.h"
#import "AppConstants.h"
#import "AppVariables.h"

@interface ResultViewController () {
}
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnWhat;
@property (strong, nonatomic) IBOutlet UIButton *btnAskAnother;
@property (strong, nonatomic) IBOutlet UIImageView *imgResult;

@end

@implementation ResultViewController
@synthesize lblTitle;
@synthesize btnWhat;
@synthesize imgResult;
@synthesize intResult;
@synthesize btnAskAnother;

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
    [super viewDidLoad];
    CGRect screenHeaderRect = CGRectMake(0, 0, 320, 100);
    lblTitle = [[UILabel alloc] initWithFrame:screenHeaderRect];
    [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22]];
    [btnWhat.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22]];
    [btnWhat setTitleEdgeInsets:UIEdgeInsetsMake(0, 22.0, 0, 0)];
    [btnAskAnother.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *oldDateD = [formatter dateFromString:strDepartureDate];
    NSDate *oldDateR = [formatter dateFromString:strReturnDate];
    [formatter setDateFormat:@"MM/dd"];
//    strDepartureDate = [formatter stringFromDate:oldDateD];
//    strReturnDate = [formatter stringFromDate:oldDateR];
    
    [lblTitle setText:[NSString stringWithFormat:@"Should I buy Airfare from\n%@ to %@ for\n%@ - %@?",strOriginAirport, strDestinationAirport, [formatter stringFromDate:oldDateD], [formatter stringFromDate:oldDateR]]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:[UIColor whiteColor]];
    [lblTitle setNumberOfLines:0];
    [self.view addSubview: lblTitle];
	// Do any additional setup after loading the view.
//    intLastResult = 0;
    [self pickImage];
    [self skewImage];
    [self performSelector:@selector(uprightImage) withObject:nil afterDelay:0.3];
}

- (void)skewImage
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -300/500;
    transform = CATransform3DRotate(transform, .5 * M_PI, .2, .3, 0);
    transform = CATransform3DScale(transform, .5, .5, 1);
    imgResult.layer.transform = transform;
    [imgResult setAlpha:0.0f];
}

- (void)uprightImage
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:2.0];
    imgResult.layer.transform = CATransform3DMakeRotation(M_PI, 0.0, 0.0, 0.0);
    [imgResult setAlpha:1.0];
    [UIView commitAnimations];
}

- (void)pickImage
{
    //0-responseArt-00.png
    [imgResult setImage:[UIImage imageNamed:[self stringForImage]]];
    
}

- (NSString *)stringForImage
{
    NSString *strImageName = [NSString stringWithFormat:@"%i-responseArt-%02d.png",intLastResult,(arc4random() % ((intLastResult == 1)? 7:5))];
    NSLog (@"%@",strImageName);
    return strImageName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
