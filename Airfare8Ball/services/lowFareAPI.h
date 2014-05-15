//
//  lowFareAPI.h
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 3/11/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol lowFareAPIDelegate <NSObject>

-(void)requestFinished;

// optional because it does not always apply to log in
@optional

@end

@interface lowFareAPI : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *responseData;
    id<lowFareAPIDelegate> delegate;
}
+ (lowFareAPI *)api;

@property (nonatomic, strong) NSMutableData *responseData;

@property(nonatomic, strong) id<lowFareAPIDelegate> delegate;

- (void)fetchToken;
- (void)lowFareSearchForOrigin:(NSString*)originAirport Destination:(NSString*)destinationAirport Departure:(NSString*)departureDate Return:(NSString*)returnDate;

@end
