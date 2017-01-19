//
//  TravelServiceRequest.h
//  GoEuroTest
//
//  Created by Nagarro on 18/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    TravelModeTrain,
    TravelModeBus,
    TravelModeFlight,
} TravelMode;

typedef void (^OnCompletion) (NSArray *responseData, NSError *error);

@interface TravelServiceRequest : NSObject

- (void)getTravelResultsForType:(TravelMode)travelMode onCompletionHandler:(OnCompletion)completion;

@end
