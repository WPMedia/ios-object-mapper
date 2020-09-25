//
//  MBFakerHelper.m
//  Faker
//
//  Created by Michał Banasiak on 10/29/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import "MBFakerHelper.h"

@implementation MBFakerHelper

+ (NSBundle *) bundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;

    dispatch_once (&onceToken, ^{
        NSURL *bundleURL = [[NSBundle mainBundle].resourceURL URLByAppendingPathComponent: @"Frameworks/MBFaker.framework/MBFaker.bundle"];

        // Backwards compatibility for those projects that don't use `use_frameworks!`
        if (![bundleURL checkResourceIsReachableAndReturnError: nil]) {
            bundleURL = [[NSBundle mainBundle].resourceURL URLByAppendingPathComponent: @"MBFaker.bundle"];
        }

        // When using as part of a test, we need to check elsewhere
        if (![bundleURL checkResourceIsReachableAndReturnError: nil]) {
            bundleURL = [[NSBundle bundleForClass: [self class]].resourceURL URLByAppendingPathComponent: @"MBFaker.bundle"];
        }

        bundle = [NSBundle bundleWithURL: bundleURL];
    });

    return bundle;
}

+ (NSDictionary*)translations {
    NSMutableDictionary* translationsDictionary = [[NSMutableDictionary alloc] init];
    
    NSArray *translationPaths = [self.bundle pathsForResourcesOfType:@"json" inDirectory:@"Locales"];
    
    for (NSString* path in translationPaths) {
        NSData *data = [NSData dataWithContentsOfFile: path];
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &error];
        if (!dict) {
            NSLog(@"Error reading JSON file %@, %@", path, error);
            continue;
        }

        NSString* key = [[dict allKeys] objectAtIndex:0];
        [translationsDictionary setObject: [dict objectForKey:key] forKey:key];
    }

    return (NSDictionary*)translationsDictionary;
}

+ (NSDictionary*)dictionaryForLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations {
    NSDictionary* dictionary = [translations objectForKey:language];
    
    return [dictionary objectForKey:@"faker"];
}

+ (NSArray*)fetchDataWithKey:(NSString*)key withLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations {
    NSDictionary* dictionary = [MBFakerHelper dictionaryForLanguage:language fromTranslationsDictionary:translations];
    
    NSArray* parsedKey = [key componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    
    if ([parsedKey count] == 1)
        return [dictionary objectForKey:key];
    else {
        id parsedObject = [dictionary objectForKey:[parsedKey objectAtIndex:0]];
        
        for (int i=1; i<[parsedKey count]; i++)
            parsedObject = [parsedObject objectForKey:[parsedKey objectAtIndex:i]];
        
        return (NSArray*)parsedObject;
    }
    
    return nil;
}

+ (NSString*)fetchRandomElementWithKey:(NSString*)key withLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations {
    NSString* lowercaseKey = [key lowercaseString];
    
    NSArray* elements = [MBFakerHelper fetchDataWithKey:lowercaseKey withLanguage:language fromTranslationsDictionary:translations];
    
    if ([elements count] > 0) {
        NSInteger randomIndex = arc4random() % [elements count];
        
        NSString* fetchedString = [elements objectAtIndex:randomIndex];
        
        return [MBFakerHelper fetchDataWithTemplate:fetchedString withLanguage:language fromTranslationsDictionary:translations];
    }
    
    return nil;
}

+ (NSString*)fetchDataWithTemplate:(NSString*)dataTemplate withLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations {
    NSRange hashRange = [dataTemplate rangeOfString:@"#"];
    
    if (hashRange.location != NSNotFound) {
        NSRange templateRange = [dataTemplate rangeOfString:@"#{"];
        
        if (templateRange.location == NSNotFound)
            return [MBFakerHelper numberWithTemplate:dataTemplate fromTranslationsDictionary:translations];
    } else {
		return dataTemplate;
	}
    
    NSArray* components = [dataTemplate componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"{#}"]];
        
    NSMutableArray* parsedTemplate = [[NSMutableArray alloc] init];
    
    for (NSString* component in components)
        if ([component length] > 0)
            [parsedTemplate addObject:component];
	
	NSString* fetchedString = @"";
	
	for (NSString* parsedElement in parsedTemplate) {
		if ([parsedElement compare:@" "] == 0)
			fetchedString = [fetchedString stringByAppendingString:@" "];
		else {
			NSString* stringToAppend = [MBFakerHelper fetchRandomElementWithKey:parsedElement withLanguage:language fromTranslationsDictionary:translations];
			
			if (stringToAppend)
				fetchedString = [fetchedString stringByAppendingString:stringToAppend];
			else
				fetchedString = [fetchedString stringByAppendingString:parsedElement];
		}
		
	}
	
	if ([fetchedString compare:@""] == 0)
		return nil;
	else
		return fetchedString;
}

+ (NSString*)numberWithTemplate:(NSString *)numberTemplate fromTranslationsDictionary:(NSDictionary*)translations {
    NSString* numberString = @"";
    
    for (int i=0; i<[numberTemplate length]; i++) {
        if ([numberTemplate characterAtIndex:i] == '#')
            numberString = [numberString stringByAppendingFormat:@"%d", arc4random()%10];
        else
            numberString = [numberString stringByAppendingString:[numberTemplate substringWithRange:NSMakeRange(i, 1)]];
    }
    
    return numberString;
}

@end
