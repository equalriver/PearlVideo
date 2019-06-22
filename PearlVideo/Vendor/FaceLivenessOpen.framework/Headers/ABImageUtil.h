//
//  ABImageUtil.h
//  FaceLivenessSDK
//
//  Created by Isaac Lam on 16/3/31.
//  Copyright © 2016年 ALIBABA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CMSampleBuffer.h>

@interface ABImageUtil : NSObject

/**
 * save image to app sandbox
 */
+(void) savePNGToSandbox : (UIImage*) image withFilename:(NSString*) filename;

/**
 * convert from CMSampleBufferRef
 */
+ (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer;

/**
 * get the imageSize from CMSampleBufferRef
 */
+ (CGSize) getImageSize:(CMSampleBufferRef) sampleBuffer;

///**
// * scale the image
// */
//+ (UIImage *)scaleImage:(UIImage *)image withScale:(float)scale;
//
///**
// * crop Image
// */
//+ (UIImage*) cropImage:(UIImage *)image withCropRect:(CGRect)rect;

/**
 * crop and Scale Image
 */
+ (UIImage*) cropAndScaleImage:(UIImage *)image withCropRect:(CGRect)rect withScale:(float)scale;


+(UIImage *)rotate:(UIImage *)image rotation:(UIImageOrientation)orientation;

+ (UIImage *)getOrientationUpImage:(UIImage *)image;

+ (int) sampleBufferRefToYUV420SP:(CMSampleBufferRef)sampleBufferRef toYuvData:(unsigned char*) yuvData withYuvDataSize:(int) yuvDataSize;

/**
 * Convert YUV420SP into UIImage
 */
+ (UIImage*) YUV420SPtoImage:(unsigned char*) yuvData withImageWidth:(int) imageWidth withImageHeight:(int) imageHeight;

+ (int) imageToYUV420SP:(UIImage *)image toYuvData:(unsigned char*) yuvData withYuvDataSize:(int) yuvDataSize;

@end
