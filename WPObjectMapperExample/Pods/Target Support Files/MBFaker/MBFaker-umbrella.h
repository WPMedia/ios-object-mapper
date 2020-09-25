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

#import "MBFaker.h"
#import "MBFakerAddress.h"
#import "MBFakerCompany.h"
#import "MBFakerHelper.h"
#import "MBFakerInternet.h"
#import "MBFakerLorem.h"
#import "MBFakerName.h"
#import "MBFakerPhoneNumber.h"

FOUNDATION_EXPORT double MBFakerVersionNumber;
FOUNDATION_EXPORT const unsigned char MBFakerVersionString[];

