//
//  ControllerTest.m
//  GoEuroTest
//
//  Created by Nagarro on 19/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import <OCMock/OCMock.h>

@interface ControllerTest : XCTestCase

@end

@implementation ControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testViewDidLoad {
    
    ViewController *toTest = [[ViewController alloc] init];
    
    [toTest viewDidLoad];
    id mockApplication = [OCMockObject partialMockForObject:[UIApplication sharedApplication]];
    
    [[mockApplication expect] viewDidLoad];
    
    [mockApplication verify];
    [mockApplication stopMocking];
}

- (void)testNavigationBar {

    ViewController *toTest = [[ViewController alloc] init];
    [toTest navigationItem];
    id mockApplication = [OCMockObject partialMockForObject:[UIApplication sharedApplication]];
    
    [[mockApplication expect] navigationBar];
    
    [mockApplication verify];
    [mockApplication stopMocking];
}

@end
