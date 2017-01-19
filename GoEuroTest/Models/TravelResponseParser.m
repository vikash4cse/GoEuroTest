//
//  TravelResponseParser.m
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import "TravelResponseParser.h"
#import "TravelModel.h"

@implementation TravelResponseParser

- (NSArray *)parseTravelResponseData:(NSData *)responseData {
    
    if (responseData) {
        
        NSError *error;
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        
        if(responseArray && !error) {
            
            NSMutableArray * travelResponse = [NSMutableArray new];
            
            for (NSDictionary *travelItemDict in responseArray) {
                
                TravelModel *model = [[TravelModel alloc] initWithDictionary:travelItemDict];
                [travelResponse addObject:model];
            }
            
            return travelResponse;
        }
    }
    
    return nil;
}

@end
