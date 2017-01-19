//
//  ServiceTest.m
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TravelServiceRequest.h"
#import <OCMock/OCMock.h>

@interface ServiceTest : XCTestCase

@end

@implementation ServiceTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testMethodINvoked {
    
    id mock = [OCMockObject mockForClass:[TravelServiceRequest class]];
    [[mock stub] getTravelResultsForType:0 onCompletionHandler:^(NSArray *responseData, NSError *error) {
        
    }];
    
    SEL selector = NSSelectorFromString(@"urlForTravelMode:");
    [[mock expect] methodForSelector:selector];
    [mock verify];
}


@end
