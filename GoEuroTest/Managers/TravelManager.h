//
//  TravelManager.h
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelServiceRequest.h"

typedef void (^OnFetchCompletion) (NSArray *travelData);

@interface TravelManager : NSObject

+ (TravelManager *)sharedInstance;

- (void)getTravelDataForTravelMode:(TravelMode)travelMode onCompletionHandler:(OnFetchCompletion)completion;

@end
