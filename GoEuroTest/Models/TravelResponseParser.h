//
//  TravelResponseParser.h
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelResponseParser : NSObject

- (NSArray *)parseTravelResponseData:(NSData *)responseData;

@end
