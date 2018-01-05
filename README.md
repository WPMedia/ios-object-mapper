# WPObjectMapper

This was originally forked from the [NSObject-ObjectMap](https://github.com/uacaps/NSObject-ObjectMap) project. We’ve heavily modified it to allow for better inference of properties and types leading to less LOC in dependent projects.

## Use

Add `WPObjectMapper` as a dependency in your Podfile or pod spec. Import at the top of your file with `#import <WPObjectMapper/NSObject-ObjectMap>`.

## Projects

By far the project that makes the most use of this library is [PostKit](https://github.com/WPMedia/ios-postkit). Look at any of the Native or Rainbow content models for examples of usage.

## Included

Also included with this pod are the following libraries.

### NSString+Inflection

Underscore, camel-case or classify a string.

### NSObject+AutoDescription

Automatically describe an object’s properties and types. To use it, import the file and override the default `description` method.

```objc
- (NSString *) description {
    return [self autoDescription];
}
```

## License

Copyright (c) 2012 The Board of Trustees of The University of Alabama
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. Neither the name of the University nor the names of the contributors
    may be used to endorse or promote products derived from this software
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
OF THE POSSIBILITY OF SUCH DAMAGE.
