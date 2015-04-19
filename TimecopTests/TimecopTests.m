//
//  TimecopTests.m
//  TimecopTests
//
//  Created by Kazuhiro Sakamoto on 2015/04/19.
//  Copyright (c) 2015年 Soragoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Timecop.h"

@interface TimecopTests : XCTestCase

@end

@implementation TimecopTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    NSLog(@"DATE %@", [NSDate date]);
    [Timecop travelWithDate:[NSDate dateWithTimeIntervalSinceNow:60*60]];
    NSLog(@"DATE %@", [NSDate date]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
