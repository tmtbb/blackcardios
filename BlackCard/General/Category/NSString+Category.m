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

+ (NSString *)convertWeekToTime:(NSString *)timeStr{
    long long time=[timeStr longLongValue];

    return  [self formatTime:time / 1000.0];
    
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



+ (NSString*) formatTime:(NSTimeInterval )time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* currentDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents* lastDate  = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSString *day;
    switch ([self compareDateComponentsWithLastDate:lastDate andCurrentDate:currentDate]) {
        case MonthsTime_ThisWeek:
        case MonthsTime_Today:{
            day = [self compareBeforeDayInWeekDay:lastDate currentDate:currentDate];
            return  [NSString formatTime:date formatString:[NSString stringWithFormat:@"%@  HH:mm",day]];
        }
            
    }
    
    return [NSString formatWithTime:date];
    
}

+ (NSString *)compareBeforeDayInWeekDay:(NSDateComponents *)lastDate currentDate:(NSDateComponents *)currentDate{
    NSInteger lastDay = currentDate.day - lastDate.day ;
    NSString *day;
    switch (lastDay) {
        case 0:
            day = @"今天";
            break;
        case 1:
            day = @"一天前";
            break;
        case 2:
            day = @"二天前";
            break;
        case 3:
            day = @"三天前";
            break;
        case 4:
            day = @"四天前";
            break;
        case 5:
            day = @"五天前";
            break;
        case 6:
            day = @"六天前";
            break;
        default:
            day =  @(lastDate.year).stringValue;
            break;
    }
    return day;
}

- (NSString *)formatShortTime {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* currentDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents* lastDate  = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    switch ([NSString compareDateComponentsWithLastDate:lastDate andCurrentDate:currentDate]) {
        case  MonthsTime_OtherYear:
        case  MonthsTime_OtherMonth:
        case  MonthsTime_OtherWeek:
            return   [NSString formatWithShortTime:date];
        case MonthsTime_ThisWeek:
            return   [NSString formatWithWeekTime:date];
        case MonthsTime_Yesterday:
            return   [NSString stringWithFormat:@"昨天 %@",[NSString formatHourAndMin:date]];
        case MonthsTime_Today:
            return  [NSString stringWithFormat:@"%@",[NSString formatHourAndMin:date]];
            
    }
    
    return [NSString formatWithTime:date];
    
    
}


+ (MonthsTime)compareDateComponentsWithLastDate:(NSDateComponents *)lastDate andCurrentDate:(NSDateComponents *)currentDate{
    if (currentDate.year - lastDate.year > 0) {
        
        return  MonthsTime_OtherYear ;
    }
    if (currentDate.month  - lastDate.month > 0) {
        
        return MonthsTime_OtherMonth;
    }
    NSInteger lastDay = currentDate.day - lastDate.day ;
    switch (lastDay) {
        case 0:
            return  MonthsTime_Today;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            return MonthsTime_ThisWeek;
        default: {
            return  MonthsTime_OtherWeek;
        }
    }
}


+(NSString*)formatWithWeekTime:(NSDate*) date {
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSString *weekName;
    switch (componets.weekday) {
        case 1:
            weekName = @"周日";
            break;
        case 2:
            weekName = @"周一";
            break;
        case 3:
            weekName = @"周二";
            break;
        case 4:
            weekName = @"周三";
            break;
        case 5:
            weekName = @"周四";
            break;
        case 6:
            weekName = @"周五";
            break;
        case 7:
            weekName = @"周六";
            break;
        default:
            return [NSString formatWithTime:date];
    }
    
    
    return  [NSString formatTime:date formatString:[NSString stringWithFormat:@"%@  HH:mm",weekName]];
    
}


+(NSString*)formatTime:(NSDate*) date formatString:(NSString*) format
{
    NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:format];
    }
    
    return  [dateFormatter stringFromDate:date];
}

+ (NSString*) formatWithTime:(NSDate*) date
{

    return  [self formatTime:date formatString:@"yyyy-MM-dd   HH:mm"];
}

+ (NSString*) formatWithShortTime:(NSDate*) date
{

    return  [self formatTime:date formatString:@"yy/MM/dd"];
}

+ (NSString*) formatHourAndMin:(NSDate*) date
{

    return [self formatTime:date formatString:@"HH:mm"];
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
