//
//  XCTestCase+ObjectMapTestCategory.m
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "XCTestCase+ObjectMapTestCategory.h"

@implementation XCTestCase (ObjectMapTestCategory)


#pragma mark - TEST: Equality
- (void)testEqualityOfObject:(id)testObj withDeserializedVersion:(id)deserializedObj forMethodNamed:(const char*)methodName dataType:(CAPSDataType)type {
    XCTAssert([self testObject:testObj isEqualToDeserializedObject:deserializedObj forType:type], @"Failed %@ equality of serialization/deserialization test for method named: %s.", [self stringForType:type], methodName);
}


#pragma mark - TEST: Inequality
- (void)testInequalityOfObject:(id)testObj withDeserializedVersion:(id)deserializedObj forMethodNamed:(const char*)methodName dataType:(CAPSDataType)type {
    XCTAssertFalse([self testObject:testObj isEqualToDeserializedObject:deserializedObj forType:type], @"Failed %@ inequality of serialization/deserialization test for method named: %s.", [self stringForType:type], methodName);
}



#pragma mark - Are Objects Equal Method
- (BOOL)testObject:(id)testObj isEqualToDeserializedObject:(id)deserializedObj forType:(CAPSDataType)type {
    // Test for one's nilness and the other's non-nilness
    if ((testObj == nil && deserializedObj != nil) || (testObj != nil && deserializedObj == nil)) {
        return NO;
    } else if (testObj == nil && deserializedObj == nil) {
        return YES;
    }

    // Test for simple types, arrays, and dictionaries
    if ([testObj isKindOfClass:[NSNumber class]]) {
        return [testObj isEqualToNumber:deserializedObj];
    } else if ([testObj isKindOfClass:[NSString class]]) {
        return [testObj isEqualToString:deserializedObj];
    } else if ([testObj isKindOfClass:[NSDate class]]) {
        NSTimeInterval one = [testObj timeIntervalSince1970];
        NSTimeInterval two = [deserializedObj timeIntervalSince1970];
        return ((NSInteger) one) == ((NSInteger) two);
    } else if ([testObj isKindOfClass:[NSArray class]]) {
        if ([testObj count] != [deserializedObj count]) {
            return NO;
        }
        for (NSUInteger i = 0; i < [testObj count]; i++) {
            id indexedTestObj = [testObj objectAtIndex: i];
            id indexedDeserializedObj = [deserializedObj objectAtIndex: i];
            if (![self testObject:indexedTestObj isEqualToDeserializedObject:indexedDeserializedObj forType:type]) {
                return NO;
            }
        }
        return YES;
    } else if ([testObj isKindOfClass:[NSDictionary class]]) {
        NSSet *keys = [NSSet setWithArray: [testObj allKeys]];
        if (![keys isEqualToSet: [NSSet setWithArray: [deserializedObj allKeys]]]) {
            return NO;
        }
        for (id key in keys) {
            id keyedTestObj = [testObj objectForKey: key];
            id keyedDeserializedObj = [deserializedObj objectForKey: key];
            if (![self testObject:keyedTestObj isEqualToDeserializedObject:keyedDeserializedObj forType:type]) {
                return NO;
            }
        }
        return YES;
    }

    //Test all properties
    for (NSString *propertyName in [deserializedObj propertyDictionary]) {
        // SingleObject does not implement `hash`
        if ([propertyName isEqualToString: @"hash"]) {
            continue;
        }

        if ([propertyName isEqualToString: @"count"]) {
            continue;
        }

        // Get instance of property
        id testValue;
        @try {
            testValue = [testObj valueForKey:propertyName];
        } @catch (NSException *exception) {
            continue; // not a thing
        }
        id deserializedValue = [deserializedObj valueForKey:propertyName];

        if ([testValue isKindOfClass:[NSDictionary class]] && (type == CAPSDataTypeXML || type == CAPSDataTypeSOAP)) {
            // XML/SOAP doesn't have the concept of Dictionary - everything is an object, an array, or a type of some sort
            continue;
        }

        if (![self testObject:testValue isEqualToDeserializedObject:deserializedValue forType:type]) {
            return NO;
        }
    }

    return YES;
}


#pragma mark - String for Type
- (NSString *)stringForType:(CAPSDataType)type {
    switch (type) {
        case CAPSDataTypeXML:
            return @"XML";
            break;
        case CAPSDataTypeJSON:
            return @"JSON";
            break;
        case CAPSDataTypeSOAP:
            return @"SOAP";
            break;
        default:
            return @"";
            break;
    }
}

@end
