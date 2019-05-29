//
//  ABFaceDetect.h
//  FaceLivenessSDK
//
//  Created by Isaac Lam on 16/7/26.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthContext.h"

//#define ENABLE_AUTO_FACE_PHOTO

#ifdef ENABLE_AUTO_FACE_PHOTO

@protocol ABAutoFacePhotoCallback<NSObject>

-(void) onFaceDetected :(struct ABFaceDetectResult) resultData;

/**
 *  人脸检测成功，外部回调
 *
 *  @param image  结果图片
 */
- (void)onSuccess:(UIImage *) image withResult:(struct ABFaceDetectResult) resultData;

@end


@interface ABAutoFacePhoto : NSObject

@property float thresholdMarginLeft;
@property float thresholdMarginRight;
@property float thresholdMarginBottom;
@property float thresholdMarginTop;
@property int thresholdBrightnessLV1;  // 40
@property int thresholdBrightnessLV2; //  80
@property int thresholdQualityLV1;          // Android 20    iOS 30
@property int thresholdQualityLV2;         // 70 （目前安卓55，iOS90）
@property double delayQualifiedTime;     // 500毫秒
@property int delayQualifiedFrame;           // 5

@property int thresholdFrameCountMin;           // 3

@property struct ABFaceDetectResult bestDetectResult;       //最好质量图片的结果

@property int qualifiedImageCount;       //符合质量的图片数

@property id<ABAutoFacePhotoCallback> autoFacePhotoCallback;

@property NSTimeInterval firstQualifiedTime;

/**
 *  将视频流获取的原始数据传入检测器进行异步活体检测，检测结果将回调用ABFaceDetectDelegate, UIImageOrientationRight
 *
 *  @param imgBuffer AVCaptureOutput获取的原始数据流，RGB格式
 *  @param orientation 手机朝向，用于旋转/翻转图像
 *  @return 请求是否成功 1:成功， 0:失败
 */
-(int) faceDetect: (CMSampleBufferRef) imgBuffer orientation:(UIImageOrientation) orientation;

/**
 *  将视频流获取的原始数据传入检测器进行异步活体检测，检测结果将回调用ABFaceDetectDelegate
 *
 *  @param imgBuffer AVCaptureOutput获取的原始数据流，RGB格式
 *  @return 请求是否成功 1:成功， 0:失败
 */
-(int) faceDetect: (CMSampleBufferRef) imgBuffer;

/**
 *  重置reset
 *
 */
-(void) reset;

@end

#endif
