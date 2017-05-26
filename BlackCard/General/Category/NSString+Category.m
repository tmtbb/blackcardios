//
// Created by 180 on 15/4/3.
// Copyright (c) 2015 180. All rights reserved.
//

#import "NSString+Category.h"
#import <objc/runtime.h>
@implementation NSString (NSStringCategory)

+ (NSString *)stringFilterHtmlTag:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    return html;
}

-(NSString*) stringByTrim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)addSpace{
    return [NSString stringWithFormat:@" %@",self];
}

+(BOOL) isStringEmpty:(NSString*) str
{
    if ([str isEqualToString:@"(null)"] || [str isEqualToString:@"(NULL)"]) {
        return YES;
    }
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
-(BOOL) isStringEmpty
{
    return [NSString isStringEmpty:self];
}

- (NSString *)urlEncodedString {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"~!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    return encodedString;
}

- (NSString *)urlDecodingString {
    NSString *str = [self stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    return [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)appendInformationWithUrl {
    
    NSMutableString *muString = [self mutableCopy];
    NSString *str =   [self rangeOfString:@"?"].location == NSNotFound ? @"?" : @"&";
    [muString appendString:str];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *token = [CurrentUserHelper shared].token;
    [parameters setObject:token ? token : @"" forKey:@"token"];
    [parameters setObject:@"2" forKey:@"ostype"];
    NSDictionary *sysInfoDictionary = [NSBundle mainBundle].infoDictionary;
    [parameters setObject:[sysInfoDictionary objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [parameters setObject:[NSBundle mainBundle].bundleIdentifier forKey:@"appname"];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString  *key, id obj, BOOL * stop) {
        [muString appendString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
        
    }];
    return  [muString substringToIndex:muString.length - 1];
    
   
}


+ (NSString *)convertStrToTime:(NSString *)timeStr

{

    NSString*timeString=[self convertStrToTime:timeStr timeStyle:@"yyyy-MM-dd HH:mm"];
    
    return timeString;
    
}

+ (NSString *)convertStrToTime:(NSString *)timeStr timeStyle:(NSString *)style

{
    
    long long time=[timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:style];
    
    NSString*timeString=[formatter stringFromDate:d];
    
    return timeString;
    
}

@end


NSDictionary *wxBuildAppDictionary = nil;
id _buildAppDictionaryIMP(id self, SEL _cmd, id arg1,id arg2) {
    return wxBuildAppDictionary;
}

@implementation NSDictionary (NSDictionaryCategory)
- (id)_objectForKey:(id) key {
   return [self _objectForKey:key];
}


+ (void)appearance {
//    Class mmApiRegister = NSClassFromString(@"MMApiRegister");
//    SEL buildAppDictionary = NSSelectorFromString(@"buildAppDictionary:oldAppDictionary:");
//    SEL _buildAppDictionary = NSSelectorFromString(@"_buildAppDictionary:oldAppDictionary:");
//    SuppressPerformSelectorLeakWarning( wxBuildAppDictionary = [mmApiRegister performSelector:buildAppDictionary withObject:kWXAppID withObject:nil]);
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:wxBuildAppDictionary];
//     [dict setObject:@"com.ywwl.mgame648" forKey:@"appIdentifier"];
//    wxBuildAppDictionary = dict;
//    
//    class_addMethod(mmApiRegister,_buildAppDictionary, (IMP)_buildAppDictionaryIMP, "@@:@:@");
//    Method M1 = class_getClassMethod(mmApiRegister,buildAppDictionary);
//    Method M2 = class_getInstanceMethod(mmApiRegister,_buildAppDictionary);
//    method_exchangeImplementations(M1, M2);
}
@end
