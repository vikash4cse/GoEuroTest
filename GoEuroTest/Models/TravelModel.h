//
//  TravelModel.h
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)responseDict;

@property (nonatomic, strong) NSNumber *itemId;
@property (nonatomic, strong) NSURL *logoURL;
@property (nonatomic, strong) NSString *priceInEuros;
@property (nonatomic, strong) NSString *departureTime;
@property (nonatomic, strong) NSString *arrivalTime;
@property (nonatomic, strong) NSNumber *numberOfStops;

@property (nonatomic,strong) NSDate *arrivalDate;
@property (nonatomic,strong) NSDate *departureDate;
@property (nonatomic,strong) NSNumber *totalDuration;
@property (nonatomic,strong) NSNumber *priceAmount;

@end
