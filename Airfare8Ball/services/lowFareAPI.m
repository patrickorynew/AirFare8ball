//
//  lowFareAPI.m
//  Airfare8Ball
//
//  Created by Nathan Stoltenberg on 3/11/14.
//  Copyright (c) 2014 Sabre Holdings. All rights reserved.
//

#import "lowFareAPI.h"
#import "AppConstants.h"
#import "AppVariables.h"
#import "AirfareViewController.h"

@implementation lowFareAPI
@synthesize delegate;
@synthesize responseData;

static lowFareAPI *_lowFareAPI = nil;
NSInteger statusCode;
BOOL didCancel;

BOOL isFetch;

+ (lowFareAPI *)api
{
	@synchronized([lowFareAPI class])
	{
		if (!_lowFareAPI)
		{
			_lowFareAPI = [[lowFareAPI alloc]init];
		}
		return _lowFareAPI;
	}
}

- (void)fetchToken
{
#error You must add your API key here
    NSString *apiKey = @"You must add your API key here";
    NSLog(@"Client ID Key: %@",apiKey);
    isFetch = YES;
    NSURL *url = [NSURL URLWithString:@"https://api.test.sabre.com/v1/auth/token"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setTimeoutInterval:URL_REQUEST_TIMEOUT];
	[request setHTTPMethod:@"POST"];
	[request setValue:[NSString stringWithFormat:@"Basic %@",apiKey] forHTTPHeaderField:@"Authorization"];
    
    NSString *body = @"grant_type=client_credentials";
	[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    responseData = [NSMutableData data];
	[connection start];
}

- (void)lowFareSearchForOrigin:(NSString*)originAirport Destination:(NSString*)destinationAirport Departure:(NSString*)departureDate Return:(NSString*)returnDate
{
    isFetch = NO;
    strOriginAirport = originAirport;
    strDestinationAirport = destinationAirport;
    strDepartureDate = departureDate;
    strReturnDate = returnDate;
    NSLog(@"LowFareAPI %@ %@ %@ %@",originAirport, destinationAirport, departureDate, returnDate);

	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.test.sabre.com/v1/forecast/flights/fares?origin=%@&destination=%@&departuredate=%@&returndate=%@",originAirport, destinationAirport, departureDate, returnDate]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setTimeoutInterval:URL_REQUEST_TIMEOUT];
	[request setHTTPMethod:@"GET"];
	[request setValue:[NSString stringWithFormat:@"Bearer %@",[AppVariables apiToken]] forHTTPHeaderField:@"Authorization"];
	[request setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
	NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    responseData = [NSMutableData data];
	[connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	//Handle Response
    NSLog(@"Something Worked: %@",[response description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.delegate requestFinished];
    
    NSError *error = nil;
    
    NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
    NSLog(@"%@",[resultsDictionary description]);
    if (error) {
        //Error
        NSString *data = [[NSString alloc] initWithData:self.responseData encoding:NSASCIIStringEncoding];
        NSLog(@"Something Went Wrong: %@",data);

    }
    else if (resultsDictionary != nil && error == nil)
	{
        NSString *errorCode = [resultsDictionary objectForKey:@"errorCode"];
        if ([errorCode isKindOfClass:[NSString class]] && errorCode.length >= 1)
        {
            if ([errorCode isEqualToString:@"ERR.2SG.SEC.INVALID_CREDENTIALS"] || [errorCode isEqualToString:@"ERR.2SG.SEC.MISSING_CREDENTIALS"])
            {
                if (!isFetch) [self performSelector:@selector(fetchToken) withObject:Nil afterDelay:0.1];
                return;
            }
            else
            {
                NSString *message = [resultsDictionary objectForKey:@"message"];
            
                if ([message isKindOfClass:[NSString class]] && message.length == 0) message = @"Unknown";
                [AppDelegate warningAlertView:@"Error" messege:[NSString stringWithFormat:@"%@\n\nTry another City/Date set",message]];
                return;
            }
            return;
        }
        //Success
        if (isFetch)
        {
            NSString *access_token = [resultsDictionary objectForKey:@"access_token"];
            if ([access_token isKindOfClass:[NSString class]] && access_token.length >= 1)
            {
                //Token Fetch Success
                [AppVariables setAPIToken:access_token];
                [self lowFareSearchForOrigin:strOriginAirport Destination:strDestinationAirport Departure:strDepartureDate Return:strReturnDate];

            }
        }
        else
        {
            //LowFare success
            NSString *recommendation = [resultsDictionary objectForKey:@"Recommendation"];
            if ([recommendation isKindOfClass:[NSString class]] && recommendation.length >= 1)
            {
                if ([recommendation isEqualToString:@"buy"])
                {
                    intLastResult = 1;
                }
                else if([recommendation isEqualToString:@"wait"])
                {
                    intLastResult = 2;
                }
                else
                {
                    intLastResult = 0;
                }
            } else intLastResult = 0;
            NSDictionary *Forecast = [resultsDictionary objectForKey:@"Forecast"];
            NSNumber *numHighestPredictedFare = [Forecast objectForKey:@"HighestPredictedFare"];
            NSNumber *numLowestPredictedFare = [Forecast objectForKey:@"LowestPredictedFare"];
            NSNumber *numLowestFare = [resultsDictionary objectForKey:@"LowestFare"];
            
            HighestPredictedFare = ([numHighestPredictedFare isKindOfClass:[NSNumber class]] ? [numHighestPredictedFare intValue]:1000);
            LowestPredictedFare = ([numLowestPredictedFare isKindOfClass:[NSNumber class]] ? [numLowestPredictedFare intValue]:200);
            LowestFare = ([numLowestFare isKindOfClass:[NSNumber class]] ? [numLowestFare intValue]:500);
            
            //Send to Results view here
            [(AirfareViewController*)self.delegate performSegueWithIdentifier:@"goToResults" sender:nil];
        }
            
    }
    else intLastResult = 0;
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [AppDelegate warningAlertView:@"Error" messege:[error localizedDescription]];
    [self.delegate requestFinished];
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
	return NO;
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)redirectResponse;
    
	statusCode = [httpResponse statusCode];
	return request;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    didCancel = YES;
    [[challenge sender] cancelAuthenticationChallenge:challenge];
}

@end
