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

#import "Dates.h"
#import "RandomNumber.h"
#import "WPFaker.h"
#import "WPFakerDate.h"
#import "WPFakerNumber.h"

FOUNDATION_EXPORT double WPFakerVersionNumber;
FOUNDATION_EXPORT const unsigned char WPFakerVersionString[];

