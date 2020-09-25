//
//  WPFaker.m
//  Rainbow
//
//  Created by Soper, Sean on 10/29/14.
//  Copyright (c) 2014 Washington Post. All rights reserved.
//

#import "WPFaker.h"

@implementation MBFakerInternet (WP)

+ (NSString *) path {
    NSUInteger numComponents = 5;
    NSMutableArray *components = [[NSMutableArray alloc] initWithCapacity: numComponents];
    for (int i = 0; i < numComponents; i++)
        [components addObject: [MBFakerInternet userName]];

    return [@"/" stringByAppendingString: [components componentsJoinedByString: @"/"]];
}

+ (NSString *) uuid {
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
    return uuidString;
}

+ (NSString *) adSetUrl {

    const int strLength = 4 + arc4random() % 5;
    const NSString *letters = @"abcdefghijklmnopqrstuvwxyz";

    NSMutableString *randomString = [NSMutableString stringWithCapacity: strLength];

    for (int i = 0; i < strLength; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }

    NSString *urlString = @"http://ad.doubleclick.net/N701/pfadx/wpni.video.%@/postsportslive_apps;frmt=2;frmt=1;frmt=0;vid=15;vid=30;sz=640x480;ord=[TIMESTAMP]";
    urlString = [urlString stringByReplacingOccurrencesOfString:@"%@" withString:randomString];

    return urlString;
}

@end
