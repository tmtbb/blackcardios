//
// Created by 180 on 15/4/2.
// Copyright (c) 2015 180. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompleteBlock)(id data);
typedef void (^ErrorBlock)(NSError* error);


/**
* http post 通讯 API基类
*/
@interface BaseHttpAPI : NSObject

/**
 *  HTTP 请求
 *
 *  @param path      请求路径
 *  @param parameter 请求参数
 *  @param complete  成功block
 *  @param error     失败block
 */
-(void) postRequest:(NSString*) path parameters:(NSDictionary *) parameters complete:(CompleteBlock) complete error:(ErrorBlock)error;

/**
 *  上传多图片文件
 *
 *  @param path             请求路径
 *  @param parameter        请求参数
 *  @param fileDataArray    文件数据
 *  @param complete         成功block
 *  @param error            失败block
 */
- (void)uploadFiles:(NSString *)path parameters:(NSDictionary *)parameters fileDataArray:(NSArray *)fileDataArray complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
- (void)uploadFiles:(NSString *)path parameters:(NSDictionary *)parameters fileDataDict:(NSDictionary *)fileDataDict complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
/**
 *  追加token
 *
 *  @param parameter   追加的字典
 *  @param isMustToken 是否必须要token true:时如果token为空时回调返回异常
 *  @param error       失败block
 *
 *  @return <#return value description#>
 */
-(BOOL) addCurrentUserToken:(NSDictionary *)parameters isMustToken:(BOOL)isMustToken error:(ErrorBlock) error;
/**
 *  解析单个model
 *
 *  @param data       数据
 *  @param modelClass model class
 *  @param complete   成功block
 *  @param errorBlock 失败block
 */
-(void) parseModel:(id) data modelClass:(Class)modelClass  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
/**
 *  解析多个model
 *
 *  @param data       数据
 *  @param modelClass model class
 *  @param complete   成功block
 *  @param errorBlock 失败block
 */
-(void) parseModels:(id) data modelClass:(Class)modelClass  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
/**
 *  单个Model HTTP 请求
 *
 *  @param path       请求路径
 *  @param parameter  请求参数
 *  @param modelClass model class 为nil时返回字典
 *  @param complete    成功block
 *  @param error      失败block
 */
-(void) postModelRequest:(NSString*) path parameters:(NSDictionary *) parameters modelClass:(Class)modelClass  complete:(CompleteBlock) complete error:(ErrorBlock)error;
/**
 *  数组Model HTTP 请求
 *
 *  @param path       请求路径
 *  @param parameter  请求参数
 *  @param modelClass model class
 *  @param complete    成功block
 *  @param error      失败block
 */
-(void) postModelsRequest:(NSString*) path parameters:(NSDictionary *) parameters modelClass:(Class)modelClass  complete:(CompleteBlock) complete error:(ErrorBlock)error;


-(void) getReqeust:(NSString*) url parameters:(NSDictionary *)parameters complete:(CompleteBlock) complete error:(ErrorBlock)error;
+(NSString*) requestSign:(NSString *)method url:(NSString*) url  parameters:(NSDictionary *)parameters;
+(NSString*) getRequestSign:(NSString*) url parameters:(NSMutableDictionary*) parameters;
-(void) didError:(NSInteger) errorCode strError:(NSString*) strError error:(ErrorBlock)error;
+ (NSString*)advertisingIdentifier;
+(NSString *)getDeviceName;
@end
