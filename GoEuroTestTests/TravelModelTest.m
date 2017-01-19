//
//  TravelModelTest.m
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TravelModel.h"

@interface TravelModelTest : XCTestCase

@end

@implementation TravelModelTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testPriceAmout {
    
    TravelModel *model = [[TravelModel alloc] init];
    model.priceInEuros = @"€5.48";
    NSNumber *priceAmount = model.priceAmount;
    XCTAssertEqual([priceAmount doubleValue],5.48, @"Amount are Equal");
}

@end
