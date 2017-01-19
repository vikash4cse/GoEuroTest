//
//  TravelManager.m
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import "TravelManager.h"

@implementation TravelManager

+ (TravelManager *)sharedInstance {
    
    static TravelManager *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        
        sharedInstance = [[TravelManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)getTravelDataForTravelMode:(TravelMode)travelMode onCompletionHandler:(OnFetchCompletion)completion {
    
    TravelServiceRequest *travel = [[TravelServiceRequest alloc] init];
    
    [travel getTravelResultsForType:travelMode onCompletionHandler:^(NSArray *travelData, NSError *error) {
        
        completion(travelData);
    }];
}

@end
