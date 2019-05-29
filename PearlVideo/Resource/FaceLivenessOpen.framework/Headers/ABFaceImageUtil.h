//
//  FaceImageUtil.h
//  FaceLivenessSDK
//
//  Created by Isaac Lam on 16/7/18.
//  Copyright © 2016年 ALIBABA. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ABFaceImageUtil : NSObject

+(UIImage  *) getUplodImage:(UIImage  *)image withFaceRect:(CGRect) faceRect;

+ (bool) checkImageRect:(CGRect)faceRect withImageSize:(CGSize)imageSize withMarginLeft:(float) marginLeft withMarginTop:(float) marginTop withMarginRight:(float) marginRight withMarginBottom:(float) marginBottom;

+(UIImage  *) cropFaceImage:(UIImage  *)image withFaceRect:(CGRect *) faceRect;

+(UIImage  *) getGlobalImage:(UIImage  *)image withFaceRect:(CGRect) faceRect;

+(UIImage  *) getLocalImage:(UIImage  *)image withFaceRect:(CGRect) faceRect;

@end
