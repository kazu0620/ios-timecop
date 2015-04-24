//
//  NSDate+Timecop.h
//  Timecop
//
//  Created by Kazuhiro Sakamoto on 2015/04/19.
//  Copyright (c) 2015年 Soragoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Timecop)

+ (void) travelWithDate:(NSDate *)date;
+ (void) freezeWithDate:(NSDate *)date;
+ (void) scaleWithRatio:(float)ratio;
+ (void) finishTravel;

@end
