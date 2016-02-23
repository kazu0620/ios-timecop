//
//  Timecop.h
//  Timecop
//
//  Created by Kazuhiro Sakamoto on 2015/04/19.
//  Copyright (c) 2015年 Soragoto. All rights reserved.
//

@import Foundation;

FOUNDATION_EXPORT double TimecopVersionNumber;
FOUNDATION_EXPORT const unsigned char TimecopVersionString[];

typedef void (^TimecopBlock)();

@interface Timecop : NSObject

@property (nonatomic) BOOL safeMode;

+ (BOOL)safeMode;
+ (void)setSafeMode:(BOOL)safeMode;

+ (void)travelWithDate:(NSDate *)date;
+ (void)travelWithDate:(NSDate *)date block:(TimecopBlock)block;

+ (void)freezeWithDate:(NSDate *)date;
+ (void)freezeWithDate:(NSDate *)date block:(TimecopBlock)block;

+ (void)scaleWithFactor:(float)ratio;
+ (void)scaleWithFactor:(float)ratio block:(TimecopBlock)block;

+ (void)finishTravel;

@end