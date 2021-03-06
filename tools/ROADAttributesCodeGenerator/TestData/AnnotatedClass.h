/*
 AnnotatedClass.h
 AttributesPrototype
 
 Copyright (c) 2013 Epam Systems. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 Neither the name of the EPAM Systems, Inc.  nor the names of its contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE ".*/

#import <Foundation/Foundation.h>
#import "ESDAttribute.h"
#import "CustomESDAttribute.h"

///Testing of class with attributes
RF_ATTRIBUTE(ESDAttribute)
RF_ATTRIBUTE(CustomESDAttribute,
             property1 = @"Text1",
             dictionaryProperty = @{
                                    @"key1": @"[value1",
                                    @"key2": @"value2]"
                                    },
             arrayProperty = @[@'a', @'b', @'[', @'\'', @'[', @']', @'{', @'{', @'}', @'"', @'d', @'"'],
             blockProperty = ^(NSString *sInfo, int *result) {
                 if (sInfo == nil) {
                     *result = 1;
                     return;
                 }
                 
                 if ([sInfo length] == 0) {
                     *result = 2;
                     return;
                 }
                 
                 *result = 0;
             }
             )
@interface AnnotatedClass : NSObject <NSCopy, SomeOtherProto>{
    ///Testing of field with attributes
    RF_ATTRIBUTE(ESDAttribute)
    NSObject * _someField; NSObject *_someField2;
    RF_ATTRIBUTE(ESDAttribute)
    NSObject * _someField3;
}
/*@interface
 AnnotatedClass(SomeCategory)*/

///Testing of method with attributes
RF_ATTRIBUTE(ESDAttribute)
RF_ATTRIBUTE(CustomESDAttribute, property1 = @"Text1", /*Another /* comment*/ property2 = @"Text2//")
RF_ATTRIBUTE(CustomESDAttribute, property3 = @"Text1", /*Another /* comment*/ property4 = @"Text2//")
//Noise comment
- (void)viewDidLoad;

///Testing of method with attributes
///@param param1 Some parameter
RF_ATTRIBUTE(ESDAttribute)
RF_ATTRIBUTE(CustomESDAttribute, property1 = @"Text1", property2 = @"/*") - (void)viewDidLoad:(BOOL)param1;

RF_ATTRIBUTE(RFAttribute)
- (void)viewDidLoad:(BOOL)param1 param2:(BOOL)param2;

///Testing of property with attributes
RF_ATTRIBUTE(ESDAttribute)
RF_ATTRIBUTE(CustomESDAttribute, property2 = @"*/", intProperty = (2 + 2) * 2) //Some other comment
@property (strong, nonatomic) UIWindow *window;

@end

@interface AnnotatedClass (ExpandCat) {
    ///Testing of field with attributes
    RF_ATTRIBUTE(ESDAttribute)
    NSObject * _someField4;
}

///Testing of method with attributes
RF_ATTRIBUTE(ESDAttribute)
RF_ATTRIBUTE(CustomESDAttribute, property5 = @"Text1", /*Another /* comment*/ property6 = @"Text2//")
//Noise comment
- (void)viewDidLoad;

///Testing of method with attributes
///@param param1 Some parameter
RF_ATTRIBUTE(ESDAttribute)
RF_ATTRIBUTE(CustomESDAttribute, property1 = @"Text1", property2 = @"/*") - (void)viewDidLoad:(BOOL)param1;

///Testing of property with attributes
RF_ATTRIBUTE(ESDAttribute)
RF_ATTRIBUTE(CustomESDAttribute, property2 = @"*/", intProperty = (2 + 2) * 2) //Some other comment
@property (strong, nonatomic) UIWindow *window2;

RF_ATTRIBUTE(RFWebServiceCall, serializationDisabled = NO, relativePath = @"%%0%%")
RF_ATTRIBUTE(RFWebServiceHeader, hearderFields = @{@"Accept": @"application/json"})
RF_ATTRIBUTE(RFWebServiceErrorHandler, handlerClass = @"RFODataErrorHandler")
- (id <RFWebServiceCancellable>)testErrorHandlerRootWithSuccess:(void (^)(id result))successBlock failure:(void (^)(NSError *error))failureBlock;

RF_ATTRIBUTE(RFWebServiceCall)
RF_ATTRIBUTE(RFWebServiceHeader, hearderFields = @{@"Accept": @"application/json"})
RF_ATTRIBUTE(RFWebServiceURLBuilder, builderClass = [RFODataWebServiceURLBuilder class])
- (id <RFWebServiceCancellable>)loadDataWithFetchRequest:(RFODataFetchRequest *)fetchRequest success:(void (^)(id result))successBlock failure:(void (^)(NSError *error))failureBlock;

RF_ATTRIBUTE(RFWebServiceCall, serializationDisabled = NO, relativePath = @"?importantParameter=%%1%%")
RF_ATTRIBUTE(RFWebServiceURLBuilder, builderClass = [RFODataWebServiceURLBuilder class])
RF_ATTRIBUTE(RFWebServiceHeader, hearderFields = @{@"Accept": @"application/json"})
- (id <RFWebServiceCancellable>)loadDataWithFetchRequest:(RFODataFetchRequest *)fetchRequest someImportantParameter:(NSString *)importantParameter success:(void (^)(id result))successBlock failure:(void (^)(NSError *error))failureBlock;

RF_ATTRIBUTE(RFWebServiceCall, serializationDisabled = NO, serializationRoot = @"coord.lon", successCodes = @[[NSValue valueWithRange:NSMakeRange(200, 300)]])
- (id <RFWebServiceCancellable>)testSerializationRootWithSuccess:(void (^)(id result))successBlock failure:(void (^)(NSError *error))failureBlock;

RF_ATTRIBUTE(RFWebServiceCall, serializationDisabled = NO, serializationRoot = @"coord.lon.localizedMessage.locale", successCodes = @[[NSValue valueWithRange:NSMakeRange(200, 300)]])
- (id <RFWebServiceCancellable>)testWrongSerializationRootWithSuccess:(void (^)(id result))successBlock failure:(void (^)(NSError *error))failureBlock;

@end
