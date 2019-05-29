//
//  ABLivenessResult.h
//  FaceLivenessSDK
//
//  Created by Isaac Lam on 15/12/23.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#ifndef ABLivenessResult_h
#define ABLivenessResult_h

#import <UIKit/UIKit.h>

/**
 *  触雷
 */
@interface ABMine : NSObject

@property(nonatomic, assign)NSUInteger mt;          //错误类型
@property(nonatomic, assign)UInt64 t;           //时间

- (NSDictionary *) toDict;

@end

/**
 *  图片结果
 */
@interface ABImageResult : NSObject

@property(nonatomic, assign)NSUInteger q;          //质量
@property(nonatomic, copy)NSString *p;          //路径
@property(atomic, strong) UIImage  *image;      //image
@property(atomic, assign) CGRect fr;       //人脸位置,单位：像素
@property float gb;       //高斯模糊
@property float mb;       //动作模糊
@property float b;       //亮度
@property(nonatomic, assign)UInt64 t;           //时间

- (NSDictionary *)toDict;

@end

/**
 *  动作结果
 */
@interface ABActionResult : NSObject
@property(nonatomic, assign)NSInteger at;                  //动作类型
@property(nonatomic, assign)NSInteger r;               //结果
@property(nonatomic, assign)UInt64 bt;               //开始时间
@property(nonatomic, assign)UInt64 et;               //结束时间
@property(nonatomic, assign)BOOL td;         //3d是否通过 0:不通过， 1：通过
@property(nonatomic, strong)NSMutableArray *is;          //图片列表
@property(nonatomic, strong)NSMutableArray *ms;          //错误列表

- (NSDictionary *)toDict;

@end

/**
 *  活体检测结果
 */
@interface ABLivenessResult : NSObject

@property(nonatomic, assign)NSInteger r;                  //结果
@property(nonatomic, copy)NSString *v;                    //版本号
@property(nonatomic, assign)UInt64 bt;               //开始时间
@property(nonatomic, assign)UInt64 et;               //结束时间
@property(nonatomic, copy)NSString *aid;                  //appid，应用ID
@property(nonatomic, copy)NSString *did;                //deviceid，设备ID
@property(nonatomic, copy)NSString *uid;                 //useid，用户ID
@property(nonatomic, copy)NSString *sid;                //场景ID
@property(nonatomic, copy)NSString *isid;                //内部场景id
@property(nonatomic, assign)NSInteger rt;                  //重试次数
@property(nonatomic, strong)ABImageResult *oi;                //高质量、全局、局部对应的整帧图片
@property(nonatomic, strong)ABImageResult *qi;                //高质量图片
@property(nonatomic, strong)ABImageResult *gi;                //全局图片
@property(nonatomic, strong)ABImageResult *li;                //全局图片
@property(nonatomic, copy)NSString *k;                 //加密Key
@property(nonatomic, copy)NSString *os;                     //系统
@property(nonatomic, copy)NSString *m;                     //型号
@property(nonatomic, strong)NSMutableArray *as;          //动作列表
@property(nonatomic, strong) NSDictionary *ex;          //扩展属性

@property(nonatomic) int recognizeResult;                  //结果
@property(nonatomic) float recognizeResultScore;                  //结果分数

@property(atomic, strong) UIImage  *displayImage;      //展示用图片

/**
 *  转换成Json字符串
 */
- (NSString *) toJSON;

/**
 *转换成 NSDictionary
 */
- (NSDictionary *)toDict;


@end

#endif /* LivenessResult_h */
