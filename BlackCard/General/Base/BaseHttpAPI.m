//
// Created by 180 on 15/4/2.
// Copyright (c) 2015 180. All rights reserved.
//

#import "BaseHttpAPI.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLRequestSerialization.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+Category.h"
#import <sys/utsname.h>
//#import "CertificateHelper.h"
#define STATUS_OK 0

#ifndef MGAME648_STORE
#import <AdSupport/AdSupport.h>
#endif
@implementation BaseHttpAPI {

}


- (AFHTTPRequestOperationManager*) createOperationManager:(NSSet*) contentTypes timeoutInterval:(NSTimeInterval) timeoutInterval {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = contentTypes;
#ifndef DEBUG
    manager.securityPolicy = [self createSecurityPolicy];
#endif
    return manager;
}
- (AFSecurityPolicy*) createSecurityPolicy {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:NO];
    //    [securityPolicy setPinnedCertificates:[[CertificateHelper shared] certificates]];
    
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"app.jingyingheika.com" ofType:@"cer"];//自签名证书
    NSData* caCert = [NSData dataWithContentsOfFile:cerPath];
    
    [securityPolicy setPinnedCertificates:@[caCert]];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:YES];
    return securityPolicy;
}

- (void)postRequest:(NSString *)path parameters:(NSDictionary *)parameters complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [BaseHttpAPI requestSignWithMethod:@"POST" url:path parameters:postDictionary];
    AFHTTPRequestOperationManager *manager = [self createOperationManager:[NSSet setWithObjects:@"text/html",@"text/plain", @"application/json", nil] timeoutInterval:30.f];


    __weak BaseHttpAPI *SELF = self;
    [manager POST:path parameters:postDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SELF success:operation responseObject:responseObject complete:complete error:errorBlock];
    }     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (errorBlock != nil) {
            errorBlock(error);
        }
    }];
}

+(NSString*) getRequestSign:(NSString*) url parameters:(NSMutableDictionary*) parameters
{
    [BaseHttpAPI requestSignWithMethod:@"GET" url:url parameters:parameters];
    __block NSString *getURL = [[NSString alloc] initWithFormat:@"%@?",url];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        getURL = [getURL stringByAppendingFormat:@"%@=%@&",key,obj];
    }];
    return [getURL substringWithRange:NSMakeRange(0, getURL.length - 1)];
}


+ (NSString*)advertisingIdentifier {
    static NSString *advertisingIdentifier = nil;
    if( advertisingIdentifier == nil ) {
       OEZKeychainItemWrapper* keychain = [[OEZKeychainItemWrapper alloc] initWithIdentifier:kAppAdvertisingIdentifier accessGroup:nil];
        advertisingIdentifier = [keychain objectForKey:CFBridgingRelease(kSecAttrAccount)];
        if( [NSString isEmpty:advertisingIdentifier] ) {
            advertisingIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            [keychain setObject:advertisingIdentifier forKey:CFBridgingRelease(kSecAttrAccount)];
        }
    }
    return advertisingIdentifier;
}
+(NSString *)getDeviceName
{
    // 需要#import "sys/utsname.h"
    static NSString *deviceString = nil;
    if (deviceString == nil) {
        struct utsname systemInfo;
        uname(&systemInfo);
        deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        if ([NSString isEmpty:deviceString]) {
            
            deviceString = @"none";
        }
    }
    
    return  deviceString;


}


+ (NSString *)device_key {
    
    static NSString *device_key = nil;
    if( [NSString isEmpty:device_key]) {
        OEZKeychainItemWrapper* keychain = [[OEZKeychainItemWrapper alloc] initWithIdentifier:kAppDevice_key accessGroup:nil];
        device_key = [keychain objectForKey:CFBridgingRelease(kSecAttrAccount)];
        if( [NSString isEmpty:device_key] ) {
            return kAppDevice_Normal_key;
        }
    }
    return device_key;
}

+ (NSString *)device_keyid {
    
    static NSString  *device_keyid = nil;
    if( [NSString isEmpty:device_keyid]) {
        
        OEZKeychainItemWrapper* keychain = [[OEZKeychainItemWrapper alloc] initWithIdentifier:kAppDevice_keyid accessGroup:nil];
        device_keyid = [keychain objectForKey:CFBridgingRelease(kSecAttrAccount)];
        if([NSString isEmpty:device_keyid] ) {
            return kAppDevice_Normal_keyid;
        }
    }
    return device_keyid;
}

+ (void) requestSignWithMethod:(NSString*) method url:(NSString*) url parameters:(NSMutableDictionary*) parameters {
    

    [parameters setObject:@"0" forKey:@"osType"];
//    [parameters setObject:[BaseHttpAPI advertisingIdentifier] forKey:@"idfa"];
//    [parameters setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"vendorid"];
    NSDictionary *sysInfoDictionary = [NSBundle mainBundle].infoDictionary;
    [parameters setObject:[sysInfoDictionary objectForKey:@"CFBundleShortVersionString"] forKey:@"appVersion"];
    [parameters setObject:@((long)[[NSDate date] timeIntervalSince1970]) forKey:@"timestamp"];
    [parameters setObject:[self device_keyid] forKey:@"keyId"];
    
//    [parameters setObject:[NSBundle mainBundle].bundleIdentifier forKey:@"appname"];
//    [parameters setObject:[[UIDevice currentDevice] systemVersion] forKey:@"sysVersion"];
    
    [parameters setObject:[BaseHttpAPI requestSign:method url:url parameters:parameters] forKey:@"sign"];
}

+(void) postRequestSign:(NSString*) url parameters:(NSMutableDictionary*) parameters
{
    [BaseHttpAPI requestSignWithMethod:@"POST" url:url parameters:parameters];
}


+(NSString*) requestSign:(NSString *)method url:(NSString*) url  parameters:(NSDictionary *)parameters
{
    __block NSString *strSing = [NSString stringWithFormat:@"%@%@",method,url];
    NSArray *keys = [[parameters allKeys] sortedArrayUsingSelector:@selector(compare:)];
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if( ! [obj isKindOfClass:[NSArray class]] ) {
            NSString *value = [NSString stringWithFormat:@"%@",[parameters objectForKey:obj]];
            if( ! [NSString isStringEmpty:value]) {
                strSing = [strSing stringByAppendingFormat:@"%@=%@",obj,value];
            }
        }
        
    }];
    strSing = [strSing stringByAppendingFormat:@"%@",[self device_key]];
    
    return [strSing  md5Hex];
}

- (void)uploadFiles:(NSString *)path parameters:(NSDictionary *)parameters fileDataArray:(NSArray *)fileDataArray complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithDictionary:parameters];
     [BaseHttpAPI postRequestSign:path parameters:postDictionary];
    
    AFHTTPRequestOperationManager *manager = [self createOperationManager:[NSSet setWithObjects:@"text/html",@"text/plain", @"application/json", nil] timeoutInterval:60.0f];

    __weak BaseHttpAPI *SELF = self;
    [manager POST:path parameters:postDictionary constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        // 上传多张图片
        for (NSInteger i = 0; i < fileDataArray.count; i++) {
            NSData *imageData = [fileDataArray objectAtIndex:i];
            NSString *argument = @"filename";                                               // 上传的参数名
            NSString *filename = [NSString stringWithFormat:@"%@%zi.jpg", argument, i + 1];
            [formData appendPartWithFileData:imageData name:@"filename" fileName:filename mimeType:@"image/jpeg"];
        }
    }     success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SELF success:operation responseObject:responseObject complete:complete error:errorBlock];
    }     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
}

- (void)uploadFiles:(NSString *)path parameters:(NSDictionary *)parameters fileDataDict:(NSDictionary *)fileDataDict complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithDictionary:parameters];
     [BaseHttpAPI postRequestSign:path parameters:postDictionary];
    AFHTTPRequestOperationManager *manager = [self createOperationManager:[NSSet setWithObjects:@"text/html",@"text/plain", @"application/json", nil] timeoutInterval:60.0f];

    /*__weak*/ BaseHttpAPI *SELF = self;
    [manager POST:path parameters:postDictionary constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *enumerator = [fileDataDict keyEnumerator];
        for (NSString *key in enumerator) {
            NSData *data = [fileDataDict objectForKey:key];
            [formData appendPartWithFileData:data name:@"filename" fileName:[key lastPathComponent] mimeType:[key pathExtension]];
        }

    }     success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SELF success:operation responseObject:responseObject complete:complete error:errorBlock];
    }     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLOG(@"Error: %@", error);
        errorBlock(error);
    }];
}

- (void)success:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    if ( responseObject ) {
        NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
        if (status == STATUS_OK) {
            if (complete != nil)
                complete([responseObject objectForKey:@"data"]);
        }
        else if( errorBlock ){
            NSString *failed = [responseObject objectForKey:@"msg"];
            if ( ! failed ) {
                failed = @"failed";
            }
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:failed forKey:NSLocalizedDescriptionKey];
            errorBlock([NSError errorWithDomain:kAppNSErrorDomain code:status userInfo:userInfo]);
        }
    }
    else if( errorBlock ){
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"json格式错误" forKey:NSLocalizedDescriptionKey];
        errorBlock([NSError errorWithDomain:kAppNSErrorDomain code:-1 userInfo:userInfo]);
    }

}

-(void) didError:(NSInteger) errorCode strError:(NSString*) strError error:(ErrorBlock)error
{
    if (error != nil) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:strError forKey:NSLocalizedDescriptionKey];
        error([NSError errorWithDomain:kAppNSErrorDomain code:errorCode userInfo:userInfo]);
    }
}

- (BOOL)addCurrentUserToken:(NSDictionary *)parameter isMustToken:(BOOL)isMustToken error:(ErrorBlock)error {
    if (parameter != nil) {
        if ([[CurrentUserHelper shared] isLogin]) {
            [parameter setValue:[[CurrentUserHelper shared] token] forKeyPath:@"token"];
            return YES;
        }
        else if (isMustToken) {
            [self didError:kAppNSErrorTokenCode strError:@"not token" error:error];
        }
    }
    return isMustToken == NO;
}


- (void)parseModel:(id)data modelClass:(Class)modelClass complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    if (complete) {
        if (modelClass == nil) {
            complete(data);
        }
        else {

            NSError __autoreleasing *error = nil;
            
            OEZModel *model = [OEZJsonModelAdapter modelOfClass:modelClass fromJSONDictionary:data error:&error];;
            if (error == nil && model != nil )
                complete(model);
            else {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"解析数据失败" forKey:NSLocalizedDescriptionKey];
                errorBlock([NSError errorWithDomain:kAppNSErrorDomain code:kAppNSErrorJsonCode userInfo:userInfo]);
            }
        }
    }
}


- (void)parseModels:(id)data modelClass:(Class)modelClass complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    if (complete) {
        if (modelClass == nil) {
            complete(data);
        }
        else {

            NSError __autoreleasing *error = nil;
            NSArray *models = [OEZJsonModelAdapter modelsOfClass:modelClass fromJSONArray:data error:&error];;
            if (error == nil && models != nil )
                complete(models);
            else {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"解析数据失败" forKey:NSLocalizedDescriptionKey];
                errorBlock([NSError errorWithDomain:kAppNSErrorDomain code:kAppNSErrorJsonCode userInfo:userInfo]);
            }
        }
    }
}


- (void)postModelRequest:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass complete:(CompleteBlock)complete error:(ErrorBlock)error {
    __weak BaseHttpAPI *SELF = self;
    [self postRequest:path parameters:parameters complete:^(id data) {
    [SELF parseModel:data modelClass:modelClass complete:complete error:error];
    }           error:error];
}

- (void)postModelsRequest:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass complete:(CompleteBlock)complete error:(ErrorBlock)error {

    __weak BaseHttpAPI *SELF = self;
    [self postRequest:path parameters:parameters complete:^(id data) {
        [SELF parseModels:data modelClass:modelClass complete:complete error:error];
    }           error:error];


}


- (void)getReqeust:(NSString *)url parameters:(NSDictionary *)parameters complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json", nil];
    

    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if( complete )
        {
            complete(responseObject);
        }
    }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error != nil) {
            errorBlock(error);
        }
    }];

}
@end
