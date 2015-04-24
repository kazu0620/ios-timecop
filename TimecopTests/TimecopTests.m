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
    [Timecop finishTravel];
    [Timecop setSafeMode:NO];
}

- (void)testTimeTravel{
    NSDate *realDate = [NSDate date];
    
    // Travel to future
    NSTimeInterval aHour = 60*60;
    NSDate *aHourLater   = [NSDate dateWithTimeIntervalSinceNow:aHour];
    [Timecop travelWithDate:aHourLater];
    XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] + aHour ,[[NSDate date] timeIntervalSince1970], 1);
    XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] + aHour ,[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970], 1);
   
    // Return to our age
    [Timecop finishTravel];
    XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] ,[[NSDate date] timeIntervalSince1970], 1);
    XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] ,[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970], 1);
    
    // Travel to past
    NSDate *aHourAgo = [NSDate dateWithTimeIntervalSinceNow:aHour*-1];
    [Timecop travelWithDate:aHourAgo];
    XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] - aHour ,[[NSDate date] timeIntervalSince1970], 1);
    XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] - aHour ,[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970], 1);
    
}

- (void)testTimeFreeze {
    [Timecop freezeWithDate:[NSDate date]];
    NSDate *freezedDate = [NSDate date];
    
    sleep(1.0);
    
    // Time freezed
    XCTAssertEqual([freezedDate timeIntervalSince1970], [[NSDate date] timeIntervalSince1970]);
    XCTAssertEqual([freezedDate timeIntervalSince1970], [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]);
    
    // The time starts moving
    [Timecop finishTravel];
    XCTAssertNotEqual([freezedDate timeIntervalSince1970], [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]);
    XCTAssertNotEqual([freezedDate timeIntervalSince1970], [[NSDate date] timeIntervalSince1970]);
}

- (void)testTravelWithBlocks {
    NSDate *realDate = [NSDate date];
    
    NSTimeInterval aHour = 60*60;
    NSDate *aHourLater   = [NSDate dateWithTimeIntervalSinceNow:aHour];
    
    // Travel to future
    [Timecop travelWithDate:aHourLater block:^{
        XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] + aHour ,[[NSDate date] timeIntervalSince1970], 1);
        
    }];
   
    XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] ,[[NSDate date] timeIntervalSince1970], 1);
}

- (void)testSafeMode {
    // can time travel with block in Safe mode
    [Timecop setSafeMode:YES];
    XCTAssertThrows([Timecop travelWithDate:nil]);
    XCTAssertThrows([Timecop freezeWithDate:nil]);
    XCTAssertThrows([Timecop scaleWithRatio:1]);
    
    [Timecop travelWithDate:nil block:^(){}];
    [Timecop freezeWithDate:nil block:^(){}];
    [Timecop scaleWithRatio:1 block:^(){}];
}

@end
