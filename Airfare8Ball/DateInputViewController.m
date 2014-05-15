//
//  DateInputViewController.m
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 3/10/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import "DateInputViewController.h"

@interface DateInputViewController ()
{
    UIDatePicker *picker;
    UITextField *textField;
}
@end

@implementation DateInputViewController
@synthesize picker;
@synthesize textField;

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
    [picker addTarget:self action:@selector(dateChanged:)      forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    textField.text = [formatter stringFromDate:picker.date];
}

- (IBAction)doneEditing:(id)sender {
    [textField resignFirstResponder];
}

@end
