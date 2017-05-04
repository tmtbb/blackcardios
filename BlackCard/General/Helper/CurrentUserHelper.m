//
//  CurrentUserHelper.m
//  mgame648
//
//  Created by yaowang on 15/11/25.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "CurrentUserHelper.h"
#import "CurrentUserActionHelper.h"
NSString *const kChannelFile = @".channel.dat";
@implementation CurrentUserHelper{
    NSString *_filename;
    OEZWeakMutableArray *_softMutableArray;
    OEZKeychainItemWrapper *_keychain;

}
HELPER_SHARED(CurrentUserHelper)

- (instancetype)init {
    self = [super init];
    if (self) {
        _softMutableArray = [[OEZSoftLockMutableArray alloc] init];
        _keychain = [[OEZKeychainItemWrapper alloc] initWithIdentifier:@"com.youdian.blackcard.ios.token" accessGroup:nil];
        [self readUserInfo];
//        [self readChannel];
    }
    return self;
}

- (void)dealloc {
    [[CurrentUserActionHelper shared] removeDelegate:self];
}

- (void) readUserInfo {
    _filename = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _filename = [_filename stringByAppendingPathComponent:@".currentuser.plist"];
    if (_filename != nil) {
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:_filename];
        if (dict != nil) {
            NSError *__autoreleasing *error = nil;
            MyAndUserModel *model = [OEZJsonModelAdapter modelOfClass:[MyAndUserModel class] fromJSONDictionary:dict error:error];
            if (error == nil) {
                _myAndUserModel = model;
                _myAndUserModel.token = [_keychain objectForKey:CFBridgingRelease(kSecAttrAccount)];
                if( [_myAndUserModel.token isEmpty])
                    _myAndUserModel = nil;
            }
            
        }
    }
}

- (void) readChannel {
//    NSString *filePath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    filePath = [filePath stringByAppendingPathComponent:kChannelFile];
//    _channel = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    if ( _channel == nil ) {
//        NSString *resFilePath = [[NSBundle mainBundle] pathForResource:kChannelFile ofType:nil];
//        _channel = [[NSString alloc] initWithContentsOfFile:resFilePath encoding:NSUTF8StringEncoding error:nil];
//        if ( _channel != nil ) {
//             [[NSFileManager defaultManager] copyItemAtPath:resFilePath toPath:filePath error:nil];
//        }
//        else {
//
//            _channel = @"";
//
//            
//        }
//    }
}

-(NSString *) uid
{
    return [_myAndUserModel userId];
}

-(NSString*) token
{
    return [_myAndUserModel token];
}

- (void)saveToken:(NSString *)token{
    
     [_keychain setObject:token forKey:CFBridgingRelease(kSecAttrAccount)];
}

//- (NSString *)idInt {
//    return [_myAndUserModel idInt];
//}

-(BOOL) isLogin
{
    return _myAndUserModel !=nil;
}
- (void)login:(MyAndUserModel *)userinfo {
    if (userinfo != nil) {
        _myAndUserModel = userinfo;
        [self saveUser];
        [[CurrentUserActionHelper shared] sender:self didLogin:userinfo];
        
        
    }
}

- (void)saveData
{
    [self saveUser];
}

- (NSString *)userName
{
    return [_myAndUserModel username];
}

- (NSString *)userLogoImage {
    return [_myAndUserModel headpic];
}

- (NSString *)userBlackCardName
{
    return [_myAndUserModel blackCardName];
}

- (void)saveUser {
    if (_myAndUserModel != nil) {
        [_keychain setObject:_myAndUserModel.token forKey:CFBridgingRelease(kSecAttrAccount)];
        NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithDictionary:[OEZJsonModelAdapter  jsonDictionaryFromModel:_myAndUserModel error:nil]];
        [userDict removeObjectForKey:@"token"];
        NSArray *keys = [userDict allKeys];
        for (NSString *key in keys) {
            if ( [userDict objectForKey:key] == [NSNull null] ) {
                [userDict removeObjectForKey:key];
            }
        }
        [userDict writeToFile:_filename atomically:YES];
    }
    
}

- (void)upUserModel:(MyAndUserModel *)userinfo {
    if( userinfo ) {
        self.myAndUserModel.username = [userinfo username];
        self.myAndUserModel.headpic = [userinfo headpic];
        self.myAndUserModel.blackCardName = userinfo.blackCardName;
        self.myAndUserModel.blackcardCreditline = userinfo.blackcardCreditline;
        [self saveData];
    }
}

//- (NSString *)stock
//{
//    return [_myAndUserModel stock];
//}

- (void)logout:(id)sender
{
    if (_myAndUserModel != nil) {
        _myAndUserModel = nil;
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSError *error = nil;
        [fileManager removeItemAtPath:_filename error:&error];
    }
    [[CurrentUserActionHelper shared] didLogoutSender:sender];
}


//- (void)sender:(id)sender didChangeMoney:(CGFloat)money {
//    double stock = [[self stock] doubleValue];
//    stock = stock + money;
//    if( stock < 0.00 ) {
//        stock = 0.00;
//    }
//    self.myAndUserModel.stock = [NSString stringWithFormat:@"%.2f",stock];
//    [self saveData];
//}
@end
