//
//  NSDate+Timecop.h
//  Timecop
//
//  Created by Kazuhiro Sakamoto on 2015/04/19.
//  Copyright (c) 2015年 Soragoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(SRGTimecop)

+ (void) srg_travelWithDate:(NSDate *)date;
+ (void) srg_freezeWithDate:(NSDate *)date;
+ (void) srg_scaleWithFactor:(float)ratio;
+ (void) srg_finishTravel;

@end
