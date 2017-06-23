//
// Created by 180 on 15/4/3.
// Copyright (c) 2015 180. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,MonthsTime) {
    
    MonthsTime_OtherYear,
    MonthsTime_OtherMonth,
    MonthsTime_ThisMonth,
    MonthsTime_OtherWeek,
    MonthsTime_ThisWeek,
    MonthsTime_Yesterday,
    MonthsTime_Today
    
};
/**
* NSString扩展
*/
@interface NSString (NSStringCategory)

/**
*  过滤字符串中的html标签
*
*  @param html 被过滤的HTML
*
*  @return 过滤过的html
*/
+ (NSString *) stringFilterHtmlTag:(NSString *)html ;
/**
 *  判断字符是否为空
 *
 *  @param str 字符
 *
 *  @return 空 yes 非空 no
 */
+(BOOL) isStringEmpty:(NSString*) str;
//-(BOOL) isStringEmpty;
/**
 *  去除字符串前后空格
 *
 *  @return 返回去除空格的字符串
 */
-(NSString*) stringByTrim;
- (NSString *)urlEncodedString;
- (NSString *)urlDecodingString;
/**
 *  判断字符串是否都是数字
 *
 *  @param string 字符串
 *
 *  @return 是数字返回YES 否为NO
 */
- (BOOL)isPureInt:(NSString *)string;


//字符串前面加空格
- (NSString *)addSpace;

- (NSString *)appendInformationWithUrl;

// 毫秒转时间
+ (NSString *)convertStrToTime:(NSString *)timeStr;
+ (NSString *)convertWeekToTime:(NSString *)timeStr;
+ (NSString *)convertStrToTime:(NSString *)timeStr timeStyle:(NSString *)style;
@end


@interface NSDictionary (NSDictionaryCategory)
//+ (void)appearance;
@end
