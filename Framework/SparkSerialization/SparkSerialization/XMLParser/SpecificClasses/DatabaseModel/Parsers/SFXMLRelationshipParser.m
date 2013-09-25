//
//  SFRelationshipParser.m
//  SparkSerialization
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


#import "SFXMLRelationshipParser.h"
#import "SFPropertyElement.h"

static NSString * const kSFXMLRelationshipDestinationKey = @"destination";
static NSString * const kSFXMLRelationshipSourceKey = @"source";
static NSString * const kSFXMLRelationshipMaxCountKey = @"maxcount";
static NSString * const kSFXMLRelationshipDeleteRuleKey = @"deleterule";

@implementation SFXMLRelationshipParser

- (void)childDidFinishParsing:(SFXMLSpecificParser * const)aChild {
    NSString * const childName = [aChild.element.name lowercaseString];
    
    if ([childName isEqualToString:kSFXMLRelationshipDestinationKey]) {
        self.element.target = [(SFPropertyElement *)[aChild element] target];
        self.element.targetKeypath = [(SFPropertyElement *)[aChild element] property];
        [aChild.element removeFromParentRecursively:YES];
    }
    else if ([childName isEqualToString:kSFXMLRelationshipSourceKey]) {
        self.element.sourceKeypath = [(SFPropertyElement *)[aChild element] property];
        [aChild.element removeFromParentRecursively:YES];
    }
    else if ([childName isEqualToString:kSFXMLRelationshipMaxCountKey]) {
        self.element.maxCount = @([[(SFXMLElement *)[[[aChild element] children] SF_lastElementIfNotEmpty] value] integerValue]);
        [aChild.element removeFromParentRecursively:YES];
    }
    else if ([childName isEqualToString:kSFXMLRelationshipDeleteRuleKey]) {
        self.element.deleteRule = [[aChild element] value];
        [aChild.element removeFromParentRecursively:YES];
    }
}

@end