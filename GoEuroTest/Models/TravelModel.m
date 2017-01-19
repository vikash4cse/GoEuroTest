//
//  TravelModel.m
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import "TravelModel.h"

NSString *const kItemIdKey          =   @"id";
NSString *const kProvideLogoKey     =   @"provider_logo";
NSString *const kSizeKey            =   @"{size}";
NSString *const kImgSizeConstant    =   @"63";
NSString *const kPriceKey           =   @"price_in_euros";
NSString *const kDepartureTimeKey   =   @"departure_time";
NSString *const kArrivalTimeKey     =   @"arrival_time";
NSString *const kNoOfStopsKey       =   @"number_of_stops";
NSString *const kHHmmFormatterKey   =   @"HH:mm";

@interface TravelModel()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation TravelModel

- (instancetype)initWithDictionary:(NSDictionary *)responseDict {
    
    if(self = [super init]) {
        
        self.itemId = [responseDict valueForKey:kItemIdKey];
        NSString *url = [responseDict valueForKey:kProvideLogoKey];
        self.logoURL = [NSURL URLWithString:[url stringByReplacingOccurrencesOfString:kSizeKey withString:kImgSizeConstant]];
        self.priceInEuros = [NSString stringWithFormat:@"€%.2f", [[responseDict valueForKey:kPriceKey] floatValue]] ;
        self.departureTime = [responseDict valueForKey:kDepartureTimeKey];
        self.arrivalTime = [responseDict valueForKey:kArrivalTimeKey];
        self.numberOfStops = [responseDict valueForKey:kNoOfStopsKey];
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:kHHmmFormatterKey];
    }
    
    return self;
}

-(NSNumber *)totalDuration {
    
    NSDate *arrivalDate = [_dateFormatter dateFromString:_arrivalTime];
    NSDate *departureDate = [_dateFormatter dateFromString:_departureTime];
    NSTimeInterval interval = [arrivalDate timeIntervalSinceDate:departureDate];
    
    return [NSNumber numberWithInt:(int)interval];
}

-(NSNumber *)priceAmount {
    
    NSString *priceWithOutEuroSign = [_priceInEuros stringByReplacingOccurrencesOfString:@"€" withString:@""];
    double euroPrice = [priceWithOutEuroSign doubleValue];
    
    return [NSNumber numberWithDouble:euroPrice];
}

-(NSDate *)departureDate {
    
    return [_dateFormatter dateFromString:_departureTime];
}

-(NSDate *)arrivalDate {
    
    return [_dateFormatter dateFromString:_arrivalTime];
}

@end
