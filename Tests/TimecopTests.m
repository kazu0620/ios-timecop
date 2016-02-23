//
//  TimecopTests.m
//  TimecopTests
//
//  Created by Kazuhiro Sakamoto on 2015/04/19.
//  Copyright (c) 2015年 Soragoto. All rights reserved.
//

@import Foundation;
@import XCTest;

#import "Timecop.h"

@interface TimecopTests : XCTestCase

@end

@implementation TimecopTests

- (void)tearDown {
  [super tearDown];
  
  [Timecop finishTravel];
  [Timecop setSafeMode:NO];
}

- (void)testTimeTravel {
  NSDate *realDate = [NSDate date];
  
  // Travel to future
  NSTimeInterval aHour = 60 * 60;
  NSDate *aHourLater   = [NSDate dateWithTimeIntervalSinceNow:aHour];
  
  [Timecop travelWithDate:aHourLater];
  NSTimeInterval epoch = [realDate timeIntervalSince1970] + aHour;
  XCTAssertEqualWithAccuracy(epoch, [[NSDate date] timeIntervalSince1970], 1);
  XCTAssertEqualWithAccuracy(epoch, [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970], 1);
  
  // Return to our age
  [Timecop finishTravel];
  epoch = [realDate timeIntervalSince1970];
  XCTAssertEqualWithAccuracy(epoch, [[NSDate date] timeIntervalSince1970], 1);
  XCTAssertEqualWithAccuracy(epoch, [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970], 1);
  
  // Travel to past
  NSDate *aHourAgo = [NSDate dateWithTimeIntervalSinceNow:aHour * -1];
  [Timecop travelWithDate:aHourAgo];
  
  epoch = [realDate timeIntervalSince1970] - aHour;
  XCTAssertEqualWithAccuracy(epoch, [[NSDate date] timeIntervalSince1970], 1);
  XCTAssertEqualWithAccuracy(epoch, [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970], 1);
}

- (void)testTimeFreeze {
  [Timecop freezeWithDate:[NSDate date]];
  
  NSDate *frozenDate = [NSDate date];
  sleep(1.0);
  
  // Time frozen
  NSTimeInterval epoch = [frozenDate timeIntervalSince1970];
  XCTAssertEqual(epoch, [[NSDate date] timeIntervalSince1970]);
  XCTAssertEqual(epoch, [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]);
  
  // The time starts moving
  [Timecop finishTravel];
  epoch = [frozenDate timeIntervalSince1970];
  XCTAssertNotEqual(epoch, [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]);
  XCTAssertNotEqual(epoch, [[NSDate date] timeIntervalSince1970]);
}

- (void)testTravelWithBlocks {
  NSDate *realDate = [NSDate date];
  
  NSTimeInterval aHour = 60 * 60;
  NSDate *aHourLater   = [NSDate dateWithTimeIntervalSinceNow:aHour];
  
  // Travel to future
  [Timecop travelWithDate:aHourLater block:^{
    XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] + aHour ,[[NSDate date] timeIntervalSince1970], 1);
    
  }];
  
  XCTAssertEqualWithAccuracy([realDate timeIntervalSince1970] ,[[NSDate date] timeIntervalSince1970], 1);
}

- (void)testSafeMode {
  [Timecop setSafeMode:YES];
  
  // cannot time travel without a block in safe mode
  XCTAssertThrows([Timecop travelWithDate:nil]);
  XCTAssertThrows([Timecop freezeWithDate:nil]);
  XCTAssertThrows([Timecop scaleWithFactor:1]);
}

@end
