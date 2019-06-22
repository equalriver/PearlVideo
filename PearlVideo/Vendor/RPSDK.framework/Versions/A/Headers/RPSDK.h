//
//  RPSDK.h
//  RPSDK
//
//  Created by bluefish on 16/2/19.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RPSDKEnv){
    RPSDKEnvDaily,  /* 日常 */
    RPSDKEnvPre,    /* 预发 */
    RPSDKEnvOnline  /* 线上 */
};

typedef NS_ENUM(NSInteger, AUDIT){
    AUDIT_EXCEPTION = -2, //认证异常,网络不通或者环境问题
    AUDIT_NOT = -1,       //未认证,用户主动取消
    AUDIT_IN_AUDIT = 0,   //认证中
    AUDIT_FAIL = 1,       //审核失败
    AUDIT_PASS = 2,       //审核通过
    
    /**业务相关code,仅在淘宝上使用，其他业务方无需处理此code**/
    AUDIT_USER_CHOOSE_OTHER = 3  //用户选择其他认证方式
};

typedef void (^RPCompletedHandler)(AUDIT auditState);

@interface  RPSDK : NSObject

/**
 *    初始化RPSDK环境,设置执行环境
 *
 * env : 环境类型
 *      日常(RPSDKEnvDaily)
 *      预发(RPSDKEnvPre)
 *      线上(RPSDKEnvOnline),外部客户选Online，日常和预发不生效
 *
 *    初始化操作基本上只做变量设置，建议放在应用启动时做
 */
+ (void)initialize:(RPSDKEnv)env;


/**
 * 初始化RPSDK,采用线上环境
 **/
+(void)initialize;

/**
 *   初始化RPSDK环境,但不对Web容器做初始化,
 * 一般情况下不需要用这种方式初始化，除非已经使用了阿里的Web容器(WindVane)
 *
 *  @param env : 环境类型 日常/预发/线上
 */
+(void)initializeHasWV:(RPSDKEnv)env;


/**
 *  设置使用方的应用名和版本号
 *
 *  @param appName : 应用名
 *  @param appVersion : 应用版本号
 */
+ (void)setAppName:(NSString*)appName appVersion:(NSString*)appVersion;


/**
 * 开始认证(一般性认证方式),启动一次认证流程
 *
 *   @param verifyToken : 此次认证流程的唯一标识,一般客户从自己的服务端取到,
 *                            而服务端调用getVeriryToken获取(*请参考文档)
 *
 *   @param  rpCompleted  认证结束后的结果回调
 *   @param  nav          所属的UINavigationController来管理
 */
+(void)start:(NSString *)verifyToken rpCompleted:(RPCompletedHandler)rpCompleted withVC:(UINavigationController *)nav;


/**
 *  开始认证(采用纯native方式，最快的性能和体验，只支持纯人脸的登陆/解锁/认证功能)
 *
 *   @param verifyToken: 认证/验证流程的唯一标识
 *   @param rpCompleted: 验证结束之后的结果回调
 *   @param nav:         所属的UIViewController
 */
+(void)startVerifyByNative:(NSString*)verifyToken rpCompleted:(RPCompletedHandler)rpCompleted withVC:(UIViewController*)nav;


/**
 *    开始认证,使用指定的H5地址作为认证入口,URL的查询串规范请参考文档
 * (客户希望自己来定制自己的H5流程,如在认证的前后置入定制的流程)
 *
 *  @param urlString    认证流程的url
 *  @param rpCompleted  认证结束后的结果回调
 *  @param nav          所属的NavigationController
 *
 */
+(void)startVerifyByURL:(NSString *)urlString rpCompleted:(RPCompletedHandler)rpCompleted withVC:(UINavigationController *)nav;


/**
 *   设置是否打开本地人脸加速功能,如扫脸解锁/扫脸登录这种要求高性能场所
 * 本地加速打开可以增加比对准确性和速度
 *  @param open  YES:本地加速打开  NO:本地加速关闭,缺省为打开状态
 */
+(void)setLocalAccelerate:(bool)open;

/**
 *  请求认证的环境标识,获取到认证的环境信息
 */
+(NSString*) getDeviceEnv;

/**
 *  获取子错误码
 */
+(NSString*) getSubCode;

/**
 *  获取子错误详情
 */
+(NSString*) getSubMessage;


@end

