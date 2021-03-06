//
//  RFMutableObject.m
//  ROADCore
//
//  Copyright (c) 2013 Epam Systems. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without 
// modification, are permitted provided that the following conditions are met:
// 
//  Redistributions of source code must retain the above copyright notice, this 
// list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this 
// list of conditions and the following disclaimer in the documentation and/or 
// other materials provided with the distribution.
//  Neither the name of the EPAM Systems, Inc.  nor the names of its contributors 
// may be used to endorse or promote products derived from this software without 
// specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// See the NOTICE file and the LICENSE file distributed with this work
// for additional information regarding copyright ownership and licensing


#import "RFMutableObject.h"
#import "NSString+RFAccessorUtilities.h"
#import <objc/runtime.h>
#import "ROADReflection.h"

const char *RFMutableObjectSetterEncoding = "v@:@";
const char *RFMutableObjectGetterEncoding = "@@:";

@implementation RFMutableObject

- (void)initialize {
    [super initialize];
    _dynamicPropertyValues = [[NSMutableDictionary alloc] init];
}

- (id)valueForUndefinedKey:(NSString *)key {
    return _dynamicPropertyValues[key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if (value == nil) {
        [_dynamicPropertyValues removeObjectForKey:key];
    }
    else {
        _dynamicPropertyValues[key] = value;
    }
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    BOOL result;
    NSString * const getterName = [NSStringFromSelector(sel) RF_stringByTransformingToGetterAccessor];
    NSString * const setterName = [getterName RF_stringByTransformingToSetterAccessor];
    RFPropertyInfo * const desc = [self RF_propertyNamed:getterName];
    
    
    if ([desc isDynamic]) {
        SEL getter = sel_registerName([getterName cStringUsingEncoding:NSUTF8StringEncoding]);
        SEL setter = sel_registerName([setterName cStringUsingEncoding:NSUTF8StringEncoding]);
        
        const char *encoding = RFMutableObjectGetterEncoding;
        IMP implementation = [self instanceMethodForSelector:@selector(genericValueGetter)];
        class_addMethod(self, getter, implementation, encoding);
        
        encoding = RFMutableObjectSetterEncoding;
        implementation = [self instanceMethodForSelector:@selector(setGenericValueSetter:)];
        class_addMethod(self, setter, implementation, encoding);
        
        result = YES;
    }
    else {
        result = [super resolveInstanceMethod:sel];
    }
    
    return result;
}

- (void)setGenericValueSetter:(id)value {
    NSString * const key = [NSStringFromSelector(_cmd) RF_stringByTransformingToGetterAccessor];
    [self setValue:value forUndefinedKey:key];
}

- (id)genericValueGetter {
    NSString * const key = NSStringFromSelector(_cmd);
    return [self valueForUndefinedKey:key];
}

@end
