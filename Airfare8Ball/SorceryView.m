//
//  SorceryView.m
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 3/20/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import "SorceryView.h"
#import "AppVariables.h"

@implementation SorceryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

float TopValue;

- (float)yForValue:(int)fare
{
    NSString* str=[NSString stringWithFormat: @"%.2f", (fare/TopValue)*100];
    return 439 - ([str floatValue] *2.69);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    TopValue = LowestPredictedFare+HighestPredictedFare;
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Abstracted Attributes
    CGFloat theAlpha = 1;
    CGRect explainerTextheadlineRect = CGRectMake(10, 20, 300, 60);
    NSString* explainerTextheadlineContent = @"What's the method behind this madness?";
    CGRect explainerTextpRect = CGRectMake(21, 82, 280, 72);
    NSString* explainerTextpContent = @"We look at what people paid for the same flight last year, and what flights cost now, and predict a range, then we find a flight and compare it to our prediction.";
    UIFont* explainerTextpFont = [UIFont fontWithName: @"HelveticaNeue-Light" size: [UIFont systemFontSize]];
    CGRect askAnotherRect = CGRectMake(0, 520, 320, 30);
    NSString* askAnotherContent = @"Ask Another";
    CGRect resultLinkRect = CGRectMake(0, 470, 320, 30);
    NSString* resultLinkContent = @"❮  Ugh. Math. Nevermind.";
    CGRect resultsSpreadRect = CGRectMake(59, [self yForValue:HighestPredictedFare], 200, ([self yForValue:LowestPredictedFare]-[self yForValue:HighestPredictedFare]));
    NSString* resultsSpreadContent = @"";
    CGRect rangeLabelhighRect = CGRectMake(8, [self yForValue:HighestPredictedFare], 44, 14);
    NSString* rangeLabelhighContent = [NSString stringWithFormat:@"$%i",HighestPredictedFare];
    CGRect rangeLabellowRect = CGRectMake(8, [self yForValue:LowestPredictedFare]-12, 44, 14);
    NSString* rangeLabellowContent = [NSString stringWithFormat:@"$%i",LowestPredictedFare];
    CGRect predictionLabelRect = CGRectMake(168, [self yForValue:HighestPredictedFare]-14, 91, 14);
    NSString* predictionLabelContent = @"Predicted Range";
    UIFont* largeLabelFont = [UIFont fontWithName: @"HelveticaNeue-Light" size: 24];
    UIFont* smallLabelFont = [UIFont fontWithName: @"Helvetica" size: 12];
    CGFloat StrokeWidth = 1;
    CGFloat indicatorLinewaitlineStrokeWidth = 1;
    NSString* indicatorLinewaittextContent = [NSString stringWithFormat:@"$%i",LowestFare];
    UIFont* indicatorLinewaittextFont = [UIFont fontWithName: @"Helvetica" size: 12];
    
    
    //// Group 2
    {
        CGContextSaveGState(context);
        CGContextSetAlpha(context, theAlpha);
        CGContextBeginTransparencyLayer(context, NULL);
        
        
        //// Group
        {
            CGContextSaveGState(context);
            CGContextSetAlpha(context, theAlpha);
            CGContextBeginTransparencyLayer(context, NULL);
            
            
            //// scaleLine Drawing
            UIBezierPath* scaleLinePath = [UIBezierPath bezierPath];
            [scaleLinePath moveToPoint: CGPointMake(158.92, 170)];
            [scaleLinePath addLineToPoint: CGPointMake(158.92, 439)];
            [color setStroke];
            scaleLinePath.lineWidth = StrokeWidth;
            [scaleLinePath stroke];
            
            
            //// topFoot Drawing
            UIBezierPath* topFootPath = [UIBezierPath bezierPath];
            [topFootPath moveToPoint: CGPointMake(151, 170)];
            [topFootPath addLineToPoint: CGPointMake(166, 170)];
            [color setStroke];
            topFootPath.lineWidth = StrokeWidth;
            [topFootPath stroke];
            
            
            //// bottomFoot Drawing
            UIBezierPath* bottomFootPath = [UIBezierPath bezierPath];
            [bottomFootPath moveToPoint: CGPointMake(151, 439)];
            [bottomFootPath addLineToPoint: CGPointMake(166, 439)];
            [color setStroke];
            bottomFootPath.lineWidth = StrokeWidth;
            [bottomFootPath stroke];
            
            
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
        }
        
        
        //// resultsSpread Drawing
        UIBezierPath* resultsSpreadPath = [UIBezierPath bezierPathWithRect: resultsSpreadRect];
        [color10 setFill];
        [resultsSpreadPath fill];
        NSMutableParagraphStyle* resultsSpreadStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [resultsSpreadStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* resultsSpreadFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 12], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: resultsSpreadStyle};
        
        [resultsSpreadContent drawInRect: resultsSpreadRect withAttributes: resultsSpreadFontAttributes];
        
//        if (intLastResult == 1)
//        //// indicatorLine-buy
//        {
//            //// indicatorLine-buy-line Drawing
//            UIBezierPath* indicatorLinebuylinePath = [UIBezierPath bezierPath];
//            [indicatorLinebuylinePath moveToPoint: CGPointMake(59, 405)];
//            [indicatorLinebuylinePath addLineToPoint: CGPointMake(259.38, 405)];
//            
//            indicatorLinebuylinePath.lineWidth = indicatorLinebuylineStrokeWidth;
//            [indicatorLinebuylinePath stroke];
//            
//            
//            //// indicatorLine-buy-text Drawing
//            NSMutableParagraphStyle* indicatorLinebuytextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//            [indicatorLinebuytextStyle setAlignment: NSTextAlignmentLeft];
//            
//            NSDictionary* indicatorLinebuytextFontAttributes = @{NSFontAttributeName: indicatorLinebuytextFont, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: indicatorLinebuytextStyle};
//            
//            [indicatorLinebuytextContent drawInRect: indicatorLinebuytextRect withAttributes: indicatorLinebuytextFontAttributes];
//        }
        
        
        //// rangeLabel-high Drawing
        NSMutableParagraphStyle* rangeLabelhighStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [rangeLabelhighStyle setAlignment: NSTextAlignmentRight];
        
        NSDictionary* rangeLabelhighFontAttributes = @{NSFontAttributeName: smallLabelFont, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: rangeLabelhighStyle};
        
        [rangeLabelhighContent drawInRect: rangeLabelhighRect withAttributes: rangeLabelhighFontAttributes];
        
        
        //// rangeLabel-low Drawing
        NSMutableParagraphStyle* rangeLabellowStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [rangeLabellowStyle setAlignment: NSTextAlignmentRight];
        
        NSDictionary* rangeLabellowFontAttributes = @{NSFontAttributeName: smallLabelFont, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: rangeLabellowStyle};
        
        [rangeLabellowContent drawInRect: rangeLabellowRect withAttributes: rangeLabellowFontAttributes];
        CGRect drawingRectForLine;
//        if (intLastResult == 2)
        //// indicatorLine-wait
        {
            CGContextSaveGState(context);
            CGContextSetAlpha(context, theAlpha);
            CGContextBeginTransparencyLayer(context, NULL);
            
            
            //// indicatorLine-wait-line Drawing
            UIBezierPath* indicatorLinewaitlinePath = [UIBezierPath bezierPath];
            CGPoint moveToPoint;
            CGPoint addLineToPoint;
            
            moveToPoint = CGPointMake(59, [self yForValue:LowestFare]+7);
            addLineToPoint =CGPointMake(259.38, [self yForValue:LowestFare]+7);
            drawingRectForLine = CGRectMake(263, [self yForValue:LowestFare], 44, 14);
            switch (intLastResult) {
                case 0:
                    [color setStroke];
                    break;
                case 1:
                    [color11 setStroke];
                    break;
                case 2:
                    [color12 setStroke];
                    break;
                    
                default:
                    break;
            }
            
            
            [indicatorLinewaitlinePath moveToPoint: moveToPoint];
            [indicatorLinewaitlinePath addLineToPoint: addLineToPoint];
            indicatorLinewaitlinePath.lineWidth = indicatorLinewaitlineStrokeWidth;
            [indicatorLinewaitlinePath stroke];
            
            
            //// indicatorLine-wait-text Drawing
            NSMutableParagraphStyle* indicatorLinewaittextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            [indicatorLinewaittextStyle setAlignment: NSTextAlignmentLeft];
            
            NSDictionary* indicatorLinewaittextFontAttributes = @{NSFontAttributeName: indicatorLinewaittextFont, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: indicatorLinewaittextStyle};
            
            [indicatorLinewaittextContent drawInRect: drawingRectForLine withAttributes: indicatorLinewaittextFontAttributes];
            
            
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
        }
        
        //// predictionLabel Drawing
        NSMutableParagraphStyle* predictionLabelStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [predictionLabelStyle setAlignment: NSTextAlignmentRight];
        
        NSDictionary* predictionLabelFontAttributes = @{NSFontAttributeName: smallLabelFont, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: predictionLabelStyle};
        
        [predictionLabelContent drawInRect: predictionLabelRect withAttributes: predictionLabelFontAttributes];
        
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }
    
    
    //// explainerText-headline Drawing
    NSMutableParagraphStyle* explainerTextheadlineStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [explainerTextheadlineStyle setAlignment: NSTextAlignmentCenter];
    
    NSDictionary* explainerTextheadlineFontAttributes = @{NSFontAttributeName: largeLabelFont, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: explainerTextheadlineStyle};
    
    [explainerTextheadlineContent drawInRect: explainerTextheadlineRect withAttributes: explainerTextheadlineFontAttributes];
    
    
    //// explainerText-p Drawing
    NSMutableParagraphStyle* explainerTextpStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [explainerTextpStyle setAlignment: NSTextAlignmentCenter];
    
    NSDictionary* explainerTextpFontAttributes = @{NSFontAttributeName: explainerTextpFont, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: explainerTextpStyle};
    
    [explainerTextpContent drawInRect: explainerTextpRect withAttributes: explainerTextpFontAttributes];
    
    
    //// askAnother Drawing
    NSMutableParagraphStyle* askAnotherStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [askAnotherStyle setAlignment: NSTextAlignmentCenter];
    
    NSDictionary* askAnotherFontAttributes = @{NSFontAttributeName: largeLabelFont, NSForegroundColorAttributeName: color4, NSParagraphStyleAttributeName: askAnotherStyle};
    
    [askAnotherContent drawInRect: askAnotherRect withAttributes: askAnotherFontAttributes];
    
    
    //// resultLink Drawing
    NSMutableParagraphStyle* resultLinkStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [resultLinkStyle setAlignment: NSTextAlignmentCenter];
    
    NSDictionary* resultLinkFontAttributes = @{NSFontAttributeName: largeLabelFont, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: resultLinkStyle};
    
    [resultLinkContent drawInRect: resultLinkRect withAttributes: resultLinkFontAttributes];
    
}


@end
