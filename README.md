# timecop
[![Version](https://img.shields.io/cocoapods/v/Timecop.svg?style=flat)](https://github.com/kazu0620/ios-timecop)
[![License](https://img.shields.io/cocoapods/l/Timecop.svg?style=flat)](https://github.com/kazu0620/ios-timecop)
[![Platform](https://img.shields.io/cocoapods/p/Timecop.svg?style=flat)](https://github.com/kazu0620/ios-timecop)
## DESCRIPTION

A library providing "time travel" and "time freezing" capabilities, making it dead simple to test time-dependent code.  It inspired by [ruby timecop gem](https://github.com/travisjeffery/timecop).

## INSTALL

Install Timecop to your project with [CocoaPods](http://cocoapods.org) by adding the following to your Podfile:

``` ruby
pod 'Timecop', "0.0.5"
```
## FEATURES
- Freeze time to a specific point.
- Travel back/forward to a specific point in time, but allow time to continue moving forward from there.
- Scale time by a given scaling factor that will cause time to move at an accelerated pace.

## USAGE

Run a time-sensitive test

```objective-c
Person *joe = [Persons findJoe];
[joe purchaseHome];
XCTAssertFalse( [joe MortgageDue] );
// move ahead a month and assert that the mortgage is due
NSDate *aMonthLater = [NSDate dateWithTimeIntervalSinceNow:60*60*24*30];
[Timecop freezeWithDate:aMonthLater block:^{
    XCTAssertTrue( [joe mortgageDue] );
}];  
```

### The difference between Timecop.freeze and Timecop.travel

freeze is used to statically mock the concept of now. As your program executes,
Time.now will not change unless you make subsequent calls into the Timecop API.
travel, on the other hand, computes an offset between what we currently think
Time.now is (recall that we support nested traveling) and the time passed in.
It uses this offset to simulate the passage of time.  To demonstrate, consider
the following code snippets:

```objective-c
NSDate *aHourAgo = [NSDate dateWithTimeIntervalSinceNow:60*60*-1];
[Timecop freezeWithDate:aHourAgo];
sleep(10)
if( aHourAgo == [NSDate date] ){
    NSLog(@"TIME NOT PASSED");
}

[Timecop finishTravel]; // "turn off" Timecop
[Timecop travelWithDate:aHourAgo];
sleep(10)
if( aHourAgo != [NSDate date] ){
    NSLog(@"TIME PASSED!");
}
