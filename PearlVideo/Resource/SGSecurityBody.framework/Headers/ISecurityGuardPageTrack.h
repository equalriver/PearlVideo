//
//  SecurityGuradPageTrack.h
//  SecurityGuardSecurityBody
//
//  Created by yangzhao.zy on 2018/3/7.
//  Copyright © 2018年 Li Fengzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

#if TARGET_OS_WATCH
#import <SecurityGuardSDKWatch/SecurityBody/ISecurityBodyComponent.h>
#import <SecurityGuardSDKWatch/Open/IOpenSecurityGuardPlugin.h>
#else
#import <SecurityGuardSDK/Open/OpenSecurityBody/IOpenSecurityBodyComponent.h>
#import <SecurityGuardSDK/Open/IOpenSecurityGuardPlugin.h>
#endif

@protocol ISecurityGuardPageTrack <NSObject, IOpenSecurityGuardPluginInterface>

/**
 * 初始化新页面
 * @param pageID 页面唯一标识
 * @param error
 */
-(void) onPageStart: (NSString *) pageID
              error: (NSError **) error;

/**
 * 销毁页面
 * @param pageID 页面唯一标识
 * @param error
 */
-(void) onPageDestory: (NSString *) pageID
                error: (NSError **) error;

/**
 * 增加点击事件
 * @param pageID 页面唯一标识
 * @param pt 相对于当前页面的坐标
 * @param rawPt 相对于屏幕的坐标
 * @param error
 */
-(void) addTouchEvent: (NSString *) pageID
      touchEventPoint: (CGPoint *) pt
   touchEventRawPoint: (CGPoint *) rawPt
                error: (NSError **) error;

/**
 * 增加滑动事件
 * @param pageID 页面唯一标识
 * @param pt 滑动后的坐标
 * @param rawPt 滑动前的坐标
 * @param error
 */
-(void) addTouchEvent: (NSString *) pageID
          ScrollPoint: (CGPoint *) pt
       OldScrollPoint: (CGPoint *) oldPt
                error: (NSError **) error;

/**
 * 增加输入事件
 * @param pageID 页面唯一标识
 * @param keycode 输入字符(nil)
 * @param error
 */
-(void) addKeyEvent: (NSString *) pageID
            keyCode: (NSString *)keycode
              error: (NSError **) error;

@end
