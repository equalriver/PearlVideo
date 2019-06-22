//
//  AuthContext.h
//  FaceDetectLite
//
//  Created by Isaac Lam on 15/11/24.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#ifndef AB_AuthContext_h
#define AB_AuthContext_h

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ABLivenessResult.h"

#define SG_AUTHCODE @"0769"
//#define SG_AUTHCODE @"0335"

//#define ALG_HISIGN
//#define ALG_MEGVII
#define ALG_ALI

#define kABVersionName @"FaceLivenessOpen"        //
#define kABVersion @"2.1.6.19"        //应用版本
#define kABVersionDate @"20190109 (Open)"        //

//config Key
#define kABAppID @"appID"        //应用ID
#define kABUserID @"userID"     //用户ID
#define KABDeviceID @"deviceID" //设备ID
#define kABSceneID @"sceneID"   //外部场景ID
#define kABInnerSceneID @"innerSceneID"  //内部场景ID
#define kABSound @"sound"            //声音是否打开
#define kABShowSoundSwitch @"showSoundSwitch"            //声音是否打开
#define kABShowNav @"showNav"         //是否显示导航页
#define kABAdjustStep @"adjustStep"         //是否需要对齐步骤
#define KABCameraAlert @"cameraAlert"  //是否显示摄像头警告
#define kABUplaodImage @"uploadImage"   //是否上传图片
#define kABAppName @"appName"        //应用名
#define kABExt @"ext"                 //扩展消息
#define kABNoFaceThreshold @"noFaceThreshold"    //连续检测到多少无人脸帧，报错阀值,大于阀值报错
#define kABMineThreshold @"mineThreshold"      //雷阀值， 操过阀值重试
#define kABActiveThreshold @"activeThreshold"      //动作通过难度阀值
#define kABNotActiveThreshold @"notActiveThreshold"      //错误动作难度阀值
#define kABStrategy @"strategy"      //动作策略
#define kABImageStrategy @"imageStrategy"      //  public static final String
#define kABIsDebug @"isDebug"      //  public static final String KEY_IMAGE_STRATEGY     "K_IMAGE_STRATEGY"  //取图策略, 0:全程 1:仅在照镜子阶段取， 2:仅在动作阶段取

#define kABReachBusinessRetryLimited @"reachBusinessRetryLimited"

#define kABNeedLastImage @"lastImage"         //是否显示导航页
#define kABDisplayImage @"displayImage"         //是否返回展示用的图片
#define kABDisplayWaitingDialog @"waitingDialog"         //是否返回展示用的图片
#define kABLessImageMode @"lessImageMode"            //是否最小图模式
#define kABDetectWrongAction @"detectWrongAction"            //是否检测错误动作
#define kABEnableReflect @"enableReflect"         //是否进行反射活体检测
#define kABReflectMode @"reflectMode"         //反射检测模式， 0: 反射失败后重试  1: 反射失败后活体成功， 2: 反射失败后活体失败
#define kABISOTheshold @"reflectISOThreshold"         //iSO阀值
#define kABPrevFailTheshold @"reflectPrevFailThreshold"         //连续失败视为通过阀值
#define kABReflectDistanceTheshold @"reflectDistanceThreshold"         //距离阀值，（眼间距） 眼间距 < min(imageWidth, imageHeigt) * thresold 为距离太远

#define kABEnableRecap @"enableRecap"         //是否进行离线翻拍识别
#define kABRecapThreshold @"recapThreshold"         //离线翻拍阀值

#define kABUsername @"username"      //  用户名，用于显示

#define kABLivenessConfig @"livenessConfig"      // json liveness config


#define kABActionCount @"actionCount"      //动作个数， 缺省为2个
#define kABOrientation @"orientation"      //界面方向

#define kABRecognizeModlePath @"recognizeModlePath"      //人脸识别模型目录路径
#define kABRecognizeEnable @"recognizeEnable"      //人脸识别是否启用
#define kABRecognizeEnableRetry @"recognizeEnableRetry"      //活体成功、离线人脸比对失败时，是否进行连续比对

#define kABImgCheckEnable @"imgCheckEnable"      //人脸识别前， 是否检查人脸的大小、清晰度、位置
#define kABRecognizeScoreThreshold @"recognizeScoreThreshold"      //人脸比对阀值
#define kABRecognizeTemplate @"recognizeTemplate"      //人脸比对模版数据

#define kABRecognizeResultScore @"recognizeResultScore"      //人脸比对分数
#define kABRecognizeResult @"recognizeResult"      //人脸比对是否成功

#define kABRecordCode @"code"        //应用ID
#define kABRecordMsg @"msg"        //应用ID

#define kABTheme @"theme"  //皮肤
#define END_LIVENESS 0
#define END_LIVENESS_SUCCESS 1
#define END_LIVENESS_FAIL 2

#define FACE_ERROR_KEY @"FACE_ERROR_KEY"
#define FACE_ERROR_RECOGNIZE 0
#define FACE_ERROR_NETWORK 1

#define REFLECT_MODE_LOCAL 0
#define REFLECT_MODE_ONLINE 1
#define kABThemeBlue @"blue"
#define kABThemeOrange @"orange"
#define kABDefalutTheme @"blue"

/**
 * 退出原因
 */
//typedef enum{
//    DETECT_SUCCESS = 0,            //采集中断(未完成人脸采集中间返回)
//    INTERRUPT = 100,            //采集中断(未完成人脸采集中间返回)
//    CAMERA_INIT_ERROR = 101,          //摄像头初始化失败
//    CAMERA_PERMISSION_DENIED = 102,   //无摄像头权限
//    DEVICE_UNSUPPORT = 103,           //设备不支持(该返回值暂时没有用到,使用需要跟app达成一致,不要影响其他调用app)
//    USEPWD = 104,                     //登录场景失败，使用密码登录
//    GOTO_SETTING = 105,               //试玩场景失败，回到设置页面
//    TIMEOUT = 150,              //超时
//    UNKNOWN_ERROR = 200,      //其他异常
//}FaceDetectStatus;

#define REFELCT_MODE_LOCAL  0
#define REFELCT_MODE_ONLINE 1

/**
 * result type
 */
typedef enum{
    FACE_RESULT_SUCCESS                  = 0,                      //成功
    FACE_RESULT_INTERRUPT                 = 100,                    //被中断
    FACE_RESULT_CAMERA_INIT_ERROR        = 101,                    //摄像头初始化失败
    FACE_RESULT_CAMERA_PERMISSION_DENIED = 102,                    //无摄像头权限
    FACE_RESULT_DEVICE_UNSUPPORT         = 103,                    //设备不支持（如无前置摄像头等）
    FACE_RESULT_GOTO_SETTING             = 105,                    //跳转到权限设置页面
    FACE_RESULT_UNKNOWN_ERROR            = 200,                    //其他异常
    FACE_RESULT_TIMEOUT                  = 150,                    // 超时
    FACE_RESULT_UPLOAD_ERROR             = 151,                    //上传失败
    FACE_RESULT_ALG_SDK_ERROR            = 152,                    //SDK初始化失败,或检测过程中抛出异常
    FACE_RESULT_CAMERA_NO_SUITABLE_PIXEL = 153,                    //前置条件,像素不达标
    FACE_RESULT_UNSURPPORT_CPU           = 154,                    //CPU性能不符合要求
    FACE_RESULT_OS_VERSION_HIGH          = 155,                    //OS版本太高
    FACE_RESULT_OS_VERSION_LOW           = 156,                    //OS版本太低
    FACE_RESULT_USER_SELECT_OTHER        = 157,                    //用户选择其他认证行为
    FACE_RESULT_NO_QUALITY_IMAGE         = 158,                    //没有合格图片
    FACE_RESULT_USER_EXIT                = 159,                    //用户退出
    FACE_RESULT_NO_FACE                  = 160,                    //未检测到人脸
    FACE_RESULT_MINE_TOO_MUCH            = 161,                    //触雷太多
    FACE_RESULT_RETRY_TOO_MUCH           = 162,                    //达到重试阀值
    FACE_RESULT_USER_NOT_RETRY           = 163,                    //用户不选择重试
    FACE_RESULT_VC_MODAL_ERROR            = 164,                    //ViewController  无法弹出
    FACE_RESULT_BUSINESS_RETRY_LIMITED   = 162,                    //达到业务重试次数
} FaceDetectResult;



/**
 * result type
 */
typedef enum{
    FACE_DIALOG_BUTTON_CANCEL            = 0,                      //用户取消
    FACE_DIALOG_BUTTON_RETRY             = 1                    //用户重试
} ABFaceDialogButton;


enum ABCheckResult
{
    FACE_CHECK_NONE = 0,       //无错误
    FACE_CHECK_NOTINREGION = 1,  //不在有效区域, 人脸正中不在 left=0.4 top=0.35 right=0.6 bottom=0.65
    FACE_CHECK_TOOFAR = 2,       //太远
    FACE_CHECK_YAW_TOO_BIG = 3,
    FACE_CHECK_TOO_DARK = 4,     //太暗
    FACE_CHECK_SHAKE = 5,        //手机摇晃
    FACE_CHECK_TOOCLOSE = 6,     //太近
    FACE_CHECK_GESTURE_SMALL = 7,
    FACE_CHECK_PITCH_TOO_BIG = 8,
    FACE_CHECK_FACE_UNEVEN = 9    //脸部光暗不平均
};

/**
 *  人脸检测结果
 */
struct ABFaceDetectResult {
    /** 检测结果， 0 为成功，其他为错误吗  */
    int result;
    /** 检测出人脸数  */
    int facesDetected;
    /** 人脸位置：像素 */
    CGRect faceSize;
    /** 人脸位置： 百分比 0-100 */
    CGRect position;
    /** 高斯模糊程度 */
    float gaussianBlur;// = 0;
    /** 亮度 */
    float brightness;// = 0;
    /** 综合图片质量 */
    float quality;// = 0;
    /* 检查结果（太远、太近、太暗等）,见ABCheckResult */
    int checkResult;
    /** 抬头分，0为正脸，>0为抬头，<0为低头*/
    float pitchScore;
    /** 摇头分，0为正脸，>0为向左摇头，<0为向右摇头（真人的方向）*/
    float yawScore;
    /** 张嘴分，0为闭嘴，>0为张嘴*/
    float mouthScore;
    /** 眨眼分，0为闭眼，>0为睁眼 */
    float blinkScore;
    /** 关键点分，越大表示越像人脸，越小表示越不像人脸（捂嘴等）*/
    float landmarkScore;
    /** 光照均匀分，1为光照均匀，>1时越大光照越不均匀*/
    float brightDiff;
    /** 0~100，越大表示背光越强 */
    float backHightlight;
    /** 人脸移动速度， 阀值15 */
    float faceSpeed;
};


//@protocol ABFaceDialogCallback<NSObject>
//
///**
// *  人脸活体弹框回调
// *  @param resultData   弹框回调结果结果
// */
//- (void)onDialogResult:(int)button  withData:(NSDictionary *)resultData;
//
//@end

@protocol ABFaceDetectCallback<NSObject>

-(void) onFaceDetected : (id) authContext FaceDetectResult:(struct ABFaceDetectResult) resultData;

/**
 *  人脸活体检测成功，外部回调
 *
 *  @param livenessResult   检测结果
 *  @param images  图片集
 */
- (void)onLivenessDetectSuccess:(ABLivenessResult *)livenessResult;

/**
 *  人脸活体检测失败，外部回调
 *
 *  @param result 失败原因
 *
 *  @param withLivenessResult livenessResult
 */
- (void)onLivenessDetectFailed:(NSInteger)result withLivenessResult:(ABLivenessResult *)livenessResult;

/**
 * 当用户活体失败,需要重试前调用， 返回 0:显示重试提示; 1:显示次数超限提示
 */
- (int) onLivenessDetectBeforeRetry:(NSMutableDictionary*) data;

/**
 *  埋点接口
 *  @param recordData 埋点信息， 其中kABRecordCode对应原来的code， kABRecordCode对应原来msg
 */
- (void) doRecord:(NSDictionary*) recordData;

-(void) onLivenessDetectFinish :(NSDictionary*) resultData;


@end


@protocol ABAuthCallback<NSObject>
- (void) onSuccess:(id) resultData;
- (void) onError:(int) errorCode withResult:(id) resultData;
- (void) onMessage:(int) msgID withData:(id) data;

@end


@interface ABAuthContext : NSObject

@property id<ABFaceDetectCallback> mpFaceDetectCallback;
//@property id<ABFaceDialogCallback> faceDialogCallback;
@property id<ABAuthCallback> authCallback;
@property (nonatomic,weak) id faceRecognizer;
@property BOOL isProcessing;
@property NSDate* lastLaunchDate;
@property(nonatomic, weak) UIViewController * cameraViewController;

/**
 * 单例
 *
 * @return ABAuthContext 实例
 */
+(ABAuthContext*) sharedInstance;

/**
 *  将视频流获取的原始数据传入检测器进行异步活体检测，检测结果将以异步调用DetectListener
 *
 *  @param viewController 调用方viewController
 *  @param config 配置信息
 *  @param callback 检测回调函数， 见 ABFaceDetectCallback
 */
+(void) livenessDetect: (UIViewController*)viewController withConfig:(NSDictionary *)config withCallback:(id<ABFaceDetectCallback>) faceDetectCallback;

/**
 * liveness fail callback
 */
+(void)livenessOnFailed:(FaceDetectResult)status;

///**
// * showDialog
// */
//+(void) showRetryDialog:(NSDictionary *)config withCallback:(id<ABFaceDialogCallback>) faceDialogCallback;

/**
 *  setFaceRecognizer
 */
+(void)setFaceRecognizer:(id<NSObject>) recognizer;

/**
 *  restartLivenessDetect
 */
+(void)restartLivenessDetect:(NSDictionary *)data;

/**
 * end livenessDetect
 */
+(void)endLivenessDetect:(int) endStatus withData:(NSDictionary *)data;

/**
 *  dismiss the memory
 */
+(void)dismiss;

/**
 *  getVersion
 */
+(NSString*) getVersion;

/**
 * checkLicense
 * return 0:success other:errorcode
 */
+(int)checkLicense;

/**
 *   人脸人机识别
 *
 *  @param viewController 调用方viewController
 *  @param config 配置信息
 *  @param callback 检测回调函数， 见 ABAuthCallback
 */
-(void) faceCaptcha: (UIViewController*)viewController withConfig:(NSDictionary *)config withCallback:(id<ABAuthCallback>) faceDetectCallback;

/**
 *  将视频流获取的原始数据传入检测器进行异步活体检测，检测结果将以异步调用DetectListener
 *
 *  @param imgBuffer AVCaptureOutput获取的原始数据流，RGB格式
 *  @param orientation 手机朝向，用于旋转/翻转图像
 *  @param callback 检测回调函数， 见 ABFaceDetectCallback
 *  @return 请求是否成功 1:成功， 0:失败
 */
-(int) faceDetect: (CMSampleBufferRef) imgBuffer orientation:(UIImageOrientation) orientation callback:(id<ABFaceDetectCallback>) faceDetectCallback;

/**
 *  将视频流获取的原始数据传入检测器进行异步活体检测，检测结果将以异步调用DetectListener
 *
 *  @param imgBuffer AVCaptureOutput获取的原始数据流，RGB格式
 *  @param orientation 手机朝向，用于旋转/翻转图像
 *  @param callback 检测回调函数， 见 ABFaceDetectCallback
 *  @return sturct ABFaceDetectResult
 */
-(struct ABFaceDetectResult) faceDetect: (CMSampleBufferRef) imgBuffer orientation:(UIImageOrientation) orientation;

/**
 *  将视频流(captureOutput回调参数)获取的原始数据传入检测器进行异步活体检测，检测结果将以异步调用DetectListener
 *
 *  @param imgBuffer AVCaptureOutput获取的原始数据流
 *  @param orientation 手机朝向，用于旋转/翻转图像， 一般为UIImageOrientationRight
 *  @param callback 检测回调函数， 见 ABFaceDetectCallback
 *  @param params 检测参数， 暂时无用，置为nil
 *  @return 请求是否成功， 0:成功   其他：失败
 */
-(int) faceDetect: (CMSampleBufferRef) imgBuffer orientation:(UIImageOrientation) orientation params:(NSDictionary *)  params callback:(id<ABFaceDetectCallback>) faceDetectCallback;


/**
 *  将图片进行异步活体检测，检测结果将以异步调用DetectListener
 *
 *  @param image 输入图片， 人像正面向上
 *  @param callback 检测回调函数， 见 ABFaceDetectCallback
 *  @param params 检测参数， 暂时无用，置为nil
 *  @return 请求是否成功， 0:成功   其他：失败
 */
-(int) faceDetect: (UIImage*) image params:(NSDictionary *) params callback:(id<ABFaceDetectCallback>) faceDetectCallback;


/**
 *  将图片进行异步活体检测，检测结果将以异步调用DetectListener
 *
 *  @param yuvData 图片数据， yuv格式
 *  @param width 图片宽
 *  @param width 图片高
 *  @param angle 图片角度
 *  @param callback 检测回调函数， 见 ABFaceDetectCallback
 *  @return 请求是否成功， 0:成功   其他：失败
 */
-(int) faceDetect:(unsigned char*) yuvData withWidth:(int) width withHeight:(int)height withAngle:(int) angle callback:(id<ABFaceDetectCallback>) faceDetectCallback;


-(void) record:(NSDictionary*)data;


#define kABRFieldEventID @"eventId"

#define kABRIdEnterLiveness @"10000"        //进入活体
#define kABRIdEnterNav @"10001"        //
#define kABRIdLeaveNav @"10002"        //
#define kABRIdStartLiveness @"10003"        //
#define kABRIdEnterAdjust @"10004"        //
#define kABRIdLeaveAdjust @"10005"        //
#define kABRIdEnterAct @"10006"        //
#define kABRIdHintText @"10007"        //
#define kABRIdHintSound @"10008"        //
#define kABRIdActSucc @"10009"        //
#define kABRIdActFail @"10010"        //
#define kABRIdReachActTh @"10011"        //
#define kABRIdReachRetryTh @"10012"        //
#define kABRIdUserRetry @"10013"        //
#define kABRIdLivenessSucc @"10014"        //
#define kABRIdStartUploadImg1 @"10015"        //
#define kABRIdEndUploadImg1 @"10016"        //
#define kABRIdStartUploadImg2 @"10017"        //
#define kABRIdEndUploadImg2 @"10018"        //
#define kABRIdStartUploadImg3 @"10019"        //
#define kABRIdEndUploadImg3 @"10020"        //
#define kABRIdStartUploadImg4 @"10021"        //
#define kABRIdEndUploadImg4 @"10022"        //
#define kABRIdStartUploadImg5 @"10023"        //
#define kABRIdEndUploadImg5 @"10024"        //
#define kABRIdSoundClick @"10025"        //
#define kABRIdBackClick @"10026"        //
#define kABRIdBackConfirm @"10027"        //
#define kABRIdAppBackground @"10028"        //
#define kABRIdAppForeground @"10029"        //
#define kABRIdAppUserExit @"10030"        //
#define kABRIdLeaveLiveness @"10031"        //
#define kABRIdTimeout @"10032"        //
#define kABRIdRestartLivenessDetect @"10033"        //
#define kABRIdException @"10099"        //
#define kABRIdReflectDetect @"10040"        //  反射

#define kABRFieldCameraWidth @"cam_w"        //
#define kABRFieldCameraHeight @"cam_h"        //
#define kABRFieldCameraAngle @"cam_a"        //
#define kABRFieldVolumeStatus @"vol_s"        //
#define kABRFieldNav @"nav"        //
#define kABRFieldActCount @"act_c"        //
#define kABRFieldAct1 @"act_1"        //
#define kABRFieldAct2 @"act_2"        //
#define kABRFieldAct3 @"act_3"        //
#define kABRFieldAct4 @"act_4"        //
#define kABRFieldAct5 @"act_5"        //
#define kABRFieldRetryMax @"retry_m"        //
#define kABRFieldFailMax @"fail_m"        //
#define kABRFieldAdjustTimeout @"aju_to"        //
#define kABRFieldActTimeout @"act_to"        //
#define kABRFieldActThreshold @"act_th"        //
#define kABRFieldActWrongThreshold @"act_wr_th"        //
#define kABRFieldMinFaceThreshold @"min_face_th"        //
#define kABRFieldGuassianBlurThreshold @"gblur_th"        //
#define kABRFieldMotionBlurThreshold @"mblur_th"        //
#define kABRFieldQualityThreshold @"qua_th"        //
#define kABRFieldNoFaceThreshold @"no_face_th"        //
#define kABRFieldBlinkTimes @"blink_t"        //

#define kABRFieldALGMessage @"alg_m"
#define kABRFieldALGFailReaseon @"alg_fr"


#define kABRFieldGravity @"gra"        //
#define kABRFieldAdjustCount @"aju_c"        //

#define kABRFieldResult @"result"        //
#define kABRFieldBright @"bri"        //
#define kABRFieldGuassianBlur @"gblur"
#define kABRFieldMotionBlur @"mblur"
#define kABRFieldQuality @"qua"	//
#define kABRFieldFrameCount @"frm_c"
//#define kABRFieldGravity @"gra"        //


#define kABRFieldActIndex @"act_idx"        // 从1开始
#define kABRFieldActType @"act_type"        //

#define kABRFieldHintContent @"hint_c"        //
//#define kABRFieldResult @"result"        //

#define kABRFieldSoundContent @"snd_c"	//
//#define kABRFieldGravity @"gra"        //


//#define kABRFieldResult @"result"        //
//#define kABRFieldBright @"bri"        //
//#define kABRFieldGuassianBlur @"gblur"
//#define kABRFieldMotionBlur @"mblur"
//#define kABRFieldQuality @"qua"	//
//#define kABRFieldGravity @"gra"        //

#define kABRFieldFailType @"fail_t"	//
//#define kABRFieldResult @"result"        //
//#define kABRFieldFrameCount @"result"        //
//#define kABRFieldGravity @"gra"        //

#define kABRFieldErrorTotalTimes @"err_tt"	//

#define kABRFieldRetryTotalTimes @"retry_tt"	//
#define kABRIdReachRetryThType @"retry_rtt"    //

#define kABRFieldConfirm @"confirm"	//

#define kABRFieldImg1Timestamp @"img1_ts"	//
#define kABRFieldImg2Timestamp @"img2_ts"	//
#define kABRFieldImg3Timestamp @"img3_ts"	//
#define kABRFieldImg4Timestamp @"img4_ts"	//
#define kABRFieldImg5Timestamp @"img5_ts"	//
//#define kABRFieldResult @"result"        //
//#define kABRFieldResult @"result"        //
//#define kABRFieldBright @"bri"        //
//#define kABRFieldGuassianBlur @"gblur"
//#define kABRFieldMotionBlur @"mblur"
//#define kABRFieldQuality @"qua"	//

#define kABRFieldLength @"len"	//
#define kABRFieldURL @"url"	//
#define kABRField @"len"	//

//#define kABRFieldVolumeStatus @"vol_s"        //

#define kABRFieldSuccess @"succ"	//
#define kABRFieldReason @"reason"	//
//#define kABRFieldVolumeStatus @"vol_s"        //

#define kABRFieldReflectMode @"mode"
#define kABRFieldReflectScore @"score"
#define kABRFieldReflectFrames @"frm"
#define kABRFieldReflectBrightResult @"b_result"
#define kABRFieldReflectBrightScore @"b_score"
#define kABRFieldReflectBrightScores @"b_scores"
#define kABRFieldReflectBrightFrames @"b_frm"
#define kABRFieldReflectBrightHis @"b_his"
#define kABRFieldReflectEyeFrames @"e_frm"
#define kABRFieldReflectEyeScore @"e_score"
#define kABRFieldReflectEyeResult @"e_result"
#define kABRFieldReflectLeftEyeResult @"le_result"
#define kABRFieldReflectRightEyeResult @"re_result"
#define kABRFieldReflectEyeValidFrames @"e_v_frm"
#define kABRFieldISO @"iso"
#define kABRFieldIlluminance @"illuminance"
#define kABRFieldReflectISOPassTheshold @"ip_t"
#define kABRFieldReflectPrevFailTimes @"p_f_times"

#ifdef ENABLE_ONLINE_STAT

#define STAT_LIVENESS_PREFIX   100

#define STAT_START  1
#define STAT_END_SUCCESS  2
#define STAT_END_FAIL  3

#define STAT_AJUST_START 91
#define STAT_AJUST_END 92

#define STAT_ACTION_1_START 11
#define STAT_ACTION_1_END_SUCCESS 12
#define STAT_ACTION_1_END_FAIL 13
#define STAT_ACTION_2_START 21
#define STAT_ACTION_2_END_SUCCESS 22
#define STAT_ACTION_2_END_FAIL 23

#define STAT_MINE 4
#define STAT_USER_EXIT 5

//+(void) onlineStat:(int)statCode withMsg:(NSString*) msg;
//+(void) onlineStat:(int)statCode withErrorCode:(int)errorCode withMsg: (NSString*)msg;

+(void) onlineStatWithCode:(int)statCode withErrorCode:(int)errorCode withDetectType:(int)detectType;
+(void) onlineStat:(int)statCode withDict:(NSDictionary*)dict;

-(void) record:(NSDictionary*)data;

#endif

@end

#endif /* AuthContext_h */
