//
//  RandomNumber.m
//  WashPost
//
//  Created by Soper, Sean on 9/23/13.
//  Copyright (c) 2013 Washington Post. All rights reserved.
//

#import "RandomNumber.h"

@implementation RandomNumber

- (NSNumber *) inRange:(NSUInteger) low
                  high:(NSUInteger) high {
    return [NSNumber numberWithUnsignedInteger: (arc4random_uniform((uint32_t)high) % ((high + 1) - low)) + low];
}

- (NSString *) twitterIdStr {
    return [NSString stringWithFormat: @"%@", [self inRange: 80000000 high: 90000000]];
}

- (NSNumber *) trueOrFalse {
    return [[self inRange: 0 high: 500] intValue] > 250 ? @(YES) : @(NO);
}

@end
