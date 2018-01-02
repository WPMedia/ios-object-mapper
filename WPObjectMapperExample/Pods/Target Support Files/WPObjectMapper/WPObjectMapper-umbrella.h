#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+AutoDescription.h"
#import "NSObject+ObjectMap.h"
#import "NSString+Inflections.h"

FOUNDATION_EXPORT double WPObjectMapperVersionNumber;
FOUNDATION_EXPORT const unsigned char WPObjectMapperVersionString[];

