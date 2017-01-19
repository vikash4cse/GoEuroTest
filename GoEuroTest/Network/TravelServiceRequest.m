//
//  TravelServiceRequest.m
//  GoEuroTest
//
//  Created by Nagarro on 18/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import "TravelServiceRequest.h"
#import "ProjectConstants.h"
#import "ConnectionHandler.h"
#import "TravelResponseParser.h"

@implementation TravelServiceRequest

- (void)getTravelResultsForType:(TravelMode)travelMode onCompletionHandler:(OnCompletion)completion {
    
    ConnectionHandler *handler = [[ConnectionHandler alloc] initWithURL:[self urlForTravelMode:travelMode]];
    
    [handler executeRequestOnSuccess:^(NSData *responseData) {
        
        TravelResponseParser *parser = [[TravelResponseParser alloc] init];
        NSArray *results = [parser parseTravelResponseData:responseData];
        completion(results,nil);
    } onFailure:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        completion(nil,error);
    }];
}


-(NSURL *)urlForTravelMode:(TravelMode)travelMode {
    
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:kBaseURL];
    
    switch (travelMode) {
            
        case TravelModeTrain: {
            
            [urlString appendString:kTrainAService];
            break;
        }
            
        case TravelModeBus: {
            
            [urlString appendString:kBusService];
            break;
        }
            
        case TravelModeFlight: {
            
            [urlString appendString:kFlightService];
            break;
        }
            
        default:
            return nil;
    }
    
    return [NSURL URLWithString:urlString];
}

@end
