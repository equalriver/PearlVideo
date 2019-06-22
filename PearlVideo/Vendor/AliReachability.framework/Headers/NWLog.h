//
//  NWLog.h
//  ALINetworkSDK
//
//  Created by Roger.Mu on 3/24/15.
//  Copyright (c) 2015 Taobao.com. All rights reserved.
//

#pragma mark -
#pragma mark -----------------[重要]网络SDK每次更新都需要check----------------------

// -----------------------------------------------------------------------------
// 网络SDK版本号，每次有新版本集成都需要变更

#define NETWORK_V @"5.0.2.6"

#pragma mark -----------------[重要]网络SDK每次更新都需要check----------------------


typedef enum {
    NET_LOG_ERROR = 0,
    NET_LOG_WARNING,
    NET_LOG_INFO,
    NET_LOG_DEBUG,
    NET_LOG_ALL,
} LOG_LEVEL;

#define TLOG_MODEL_NAME @"NetworkSDK"




// -----------------------------------------------------------------------------
// NWLog宏定义

#define NW_LOG_ERROR(...) \
[NWLog log:NET_LOG_ERROR file:__FILE__ func:__func__ line:__LINE__ module:TLOG_MODEL_NAME msg:__VA_ARGS__]

#define NW_LOG_WARNING(...) \
[NWLog log:NET_LOG_WARNING file:__FILE__ func:__func__ line:__LINE__ module:TLOG_MODEL_NAME msg:__VA_ARGS__]

#define NW_LOG_INFO(...) \
[NWLog log:NET_LOG_INFO file:__FILE__ func:__func__ line:__LINE__ module:TLOG_MODEL_NAME msg:__VA_ARGS__]

#define NW_LOG_DEBUG(...) \
[NWLog log:NET_LOG_DEBUG file:__FILE__ func:__func__ line:__LINE__ module:TLOG_MODEL_NAME msg:__VA_ARGS__]

// -----------------------------------------------------------------------------
// 不拼装

#define NW_LOG_ERROR_NO_FORMAT(log) [NWLog log:NET_LOG_ERROR msg:log]
#define NW_LOG_WARNING_NO_FORMAT(log) [NWLog log:NET_LOG_WARNING msg:log]
#define NW_LOG_INFO_NO_FORMAT(log) [NWLog log:NET_LOG_INFO msg:log]
#define NW_LOG_DEBUG_NO_FORMAT(log) [NWLog log:NET_LOG_DEBUG msg:log]


@interface NWLog : NSObject

+ (void)log:(NSInteger)level file:(const char *)file func:(const char *)func line:(int)line module:(NSString *)module msg:(NSString *)fmt, ...;
+ (void)log:(NSInteger)level msg:(NSString *)msg;

@end

