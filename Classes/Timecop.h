//
//  Timecop.h
//  Timecop
//
//  Created by Kazuhiro Sakamoto on 2015/04/19.
//  Copyright (c) 2015年 Soragoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timecop : NSObject

@property (nonatomic) BOOL safeMode;

+ (BOOL) safeMode;
+ (void) setSafeMode:(BOOL)safeMode;

+ (void) travelWithDate:(NSDate *)date;
+ (void) travelWithDate:(NSDate *)date block:(void(^)())block;

+ (void) freezeWithDate:(NSDate *)date;
+ (void) freezeWithDate:(NSDate *)date block:(void(^)())block;

+ (void) scaleWithFactor:(float)ratio;
+ (void) scaleWithFactor:(float)ratio  block:(void(^)())block;

+ (void) finishTravel;

@end