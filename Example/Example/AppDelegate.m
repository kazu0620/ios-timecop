//
//  AppDelegate.m
//  Example
//
//  Created by sakamoto kazuhiro on 2015/04/24.
//  Copyright (c) 2015年 sakamoto kazuhiro. All rights reserved.
//

#import "AppDelegate.h"
#import "Timecop.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self timecopExample];
    return YES;
}

- (void) timecopExample {
    [self travelExample];
    [self freezeExample];
    [self scaleExample];
}

- (void) travelExample {
    // Time travel methods
    NSLog(@"Real current time :%@", [NSDate date]);
    
    NSDate *aHourAgo = [NSDate dateWithTimeIntervalSinceNow:60*60*-1];
    [Timecop travelWithDate:aHourAgo];
    NSLog(@"Travel to a hour ago  :%@", [NSDate date]);
    
    // return to real time
    [Timecop finishTravel];
    NSLog(@"Return to real time :%@", [NSDate date]);
   
    // with blocks
    [Timecop travelWithDate:aHourAgo block:^{
        NSLog(@"Travel with blocks :%@", [NSDate date]);
    }];
    
    NSLog(@"The time is not forward out of blocks :%@", [NSDate date]);
    
    // return to real time
    [Timecop finishTravel];
}

- (void) freezeExample {
    NSDate *aHourLater = [NSDate dateWithTimeIntervalSinceNow:60*60];
    // Freeze the time!!
    [Timecop freezeWithDate:aHourLater];
    NSLog(@"The time freezed at a hour later :%@", [NSDate date]);
   
    // Sleep 3 sec
    sleep(3);
    
    NSLog(@"The time freezed!!:%@", [NSDate date]);
   
    // Unfreeze the time and return to real time
    [Timecop finishTravel];
    
    // Sleep 3 sec
    sleep(3);
    
    // with blocks
    [Timecop freezeWithDate:aHourLater block:^{
        // The time freezed in this blocks scope
    }];
}

- (void) scaleExample {
    NSLog(@"The time before scale :%@", [NSDate date]);
    
    [Timecop scaleWithFactor:3600];
    
    // Sleep 1sec
    sleep(1);
    
    // A hour passed by 1 sec in real world
    NSLog(@"a hour passed! :%@", [NSDate date]);
    
    // Stop time accelerating
    [Timecop finishTravel];
    
    // with blocks
    [Timecop scaleWithFactor:3600 block:^{
        // The time scaled in this blocks scope
    }];
}

@end