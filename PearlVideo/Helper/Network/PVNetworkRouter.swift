//
//  PVNetworkRouter.swift


import Alamofire
import SwiftyJSON

enum Router: URLRequestConvertible {
    
    ///游客模式登录
    case visitorLogin(deviceId: String)
    
    ///注册
    case register(phone: String, msgcode: String, inviteCode: String)
    
    ///登录
    case login(phone: String, psd: String, msgcode: String)
    
    ///获取验证码
    case getAuthCode(phone: String)
    
    ///验证验证码
    case validateAuthCode(phone: String, code: String)
    
    ///修改密码
    case changePsd(userId: String, phone: String, psd: String)
    
    ///退出登录
    case loginOut
    
    ///获取版本号
    case getVersion
    
    
    
    //首页
    ///首页
    case homePage
    
    ///首页推荐视频列表
    case homeRecommendVideoList(page: Int)
    
    ///首页关注视频列表
    case homeAttentionVideoList(page: Int)
    
    ///会员等级
    case userLevel(nextPage: Int)
    
    ///当前会员等级信息
    case currentUserLevel
    
    ///会员等级详情
    case userLevelDetail
    
    ///活跃度详情
    case activenessDetail(page: Int)
    
    ///平安果详情
    case fruitDetail(page: Int)
    
    ///商学院视频列表
    case schoolVideoList(page: Int)
    
    ///商学院新手指南
    case schoolUserGuide(page: Int)
    
    ///我的任务
    case myTask(page: Int)
    
    ///任务书卷
    case taskAll(page: Int)
    
    ///历史任务
    case historyTask(page: Int)
    
    ///我的团队信息
    case teamInfo
    
    ///全部团队成员列表
    case teamAllList(page: Int)
    
    ///未实名认证团队成员列表
    case teamNotAuthList(page: Int)
    
    ///实名认证团队成员列表
    case teamAuthList(page: Int)

    ///消息列表category：NOTICEMESSAGE(通知)，COMMENTMESSAGE（评论），FOLLOWMESSAGE（关注），THUMBUPMESSAGE（点赞）
    case messsageList(page: Int, category: String)
    
    ///获取消息状态
    case messageBadgeState
    
    ///更新消息状态category：NOTICEMESSAGE(通知)，COMMENTMESSAGE（评论），FOLLOWMESSAGE（关注），THUMBUPMESSAGE（点赞）
    case refreshMessageBadgeState(category: String)
    
    
    
    
    //video
    ///获取上传地址和凭证
    case getUploadAuthAndAddress(description: String, fileName: String)
    
    ///获取播放STS
    case getVideoSTS
    
    ///所有视频播放列表 1: 推荐, 2: 关注, 3: 我的作品, 4: 我的喜欢视频, 5: 私密视频
    case videoList(type: Int, videoIndex: Int, videoId: String)
    
    ///关注 action: 1关注 2取消
    case attention(id: String, action: Int)
    
    ///视频点赞 action: 1点赞 2取消
    case videoLike(id: String, action: Int)
    
    ///视频评论列表
    case videoCommentList(videoId: String, page: Int)
    
    ///视频举报 imageUrl<string>数组
    case videoReport(videoId: String, type: String, content: String)
    
    ///视频评论点赞 action: 1点赞 2取消
    case videoCommentLike(videoId: String, commentId: Int, action: Int)
    
    ///删除视频
    case deleteVideo(videoId: String)
    
    ///设置私密视频
    case setVideoSecurity(videoId: String, security: Bool)
    
    ///提交视频评论
    case videoComment(videoId: String, content: String)
    
    ///二次评论（评论的评论）
    case twiceComment(id: Int, videoId: String, content: String)
    
    ///获取邀请码
    case getInviteCode
    
    
    //交换中心
    ///市场信息
    case exchangeInfo
    
    ///市场订单列表
    case exchangeInfoList(isBuyOrder: Bool, phone: String, page: Int)
    
    ///准备发布买单
    case readySendBuyOrder
    
    ///准备发布卖单
    case readySendSellOrder
    
    ///发布买单
    case sendBuyOrder(price: Double, count: Int, password: String)
    
    ///发布卖单
    case sendSellOrder(price: Double, count: Int, password: String)
    
    ///准备接单
    case readyAcceptOrder(orderId: String)
    
    ///接单
    case acceptOrder(orderId: String, password: String, count: Int)
    
    ///交易记录列表
    case recordList(type: PVExchangeRecordListType, nextPage: Int)
    
    ///交易记录详情
    case recordDetail(orderId: String)
    
    ///取消订单
    case cancelOrder(orderId: String)
    
    ///支付订单
    case payOrder(orderId: String, screenshot: String)
    
    
    
    //我的
    ///用户信息
    case userInfo(userId: String, page: Int)
    
    ///关于我们
    case about
    
    ///视频 type: 3作品 4喜欢 5私密
    case userInfoVideo(userId: String, type: Int, page: Int)
    
    ///意见反馈 类型: 1解冻 2优化意见 3其他
    case feedback(type: Int, name: String, phone: String, idCard: String, imageUrl: [String], content: String)
    
    ///我的反馈
    case myFeedback(page: Int)
    
    ///修改用户信息  sign签名
    case editUserInfo(name: String, avatarUrl: String, sign: String, gender: String)
    
    ///获取实人认证token
    case getUserValidateToken(idCard: String, name: String)
    
    ///获取上传图片的阿里云auth和address
    case getAuthWithUploadImage(imageExt: String)
    
    ///获取用户认证状态
    case getUserValidateStatus
    
    ///非人脸身份认证 verifyId: 加密的参数("name|idCard|deviceId", 密钥"fuyin")
    case userValidate(name: String, idCard: String, deviceId: String)
    
    ///修改背景图片
    case editBackgroundImage(imagePath: String)
    
    ///关注和粉丝列表 type：1.关注 2粉丝 3.搜索
    case attentionAndFansList(type: Int, userId: String, content: String, page: Int)
    
    ///设置交易密码
    case setExchangePassword(phone: String, authCode: String, password: String)
    
    ///设置支付方式
    case setPayWay(name: String, account: String)
    
    
    
    func asURLRequest() throws -> URLRequest {
        
        //MARK: - path
        var path: String {
            switch self {
            //login
            case .visitorLogin:
                return "visit"
                
            case .register:
                return "signUp"
                
            case .login:
                return "userLogin"

            case .getAuthCode:
                return "sendMsgCode"
                
            case .validateAuthCode:
                return "MobileVerification"
                
            case .changePsd:
                return "retrievePassword"
                
            case .loginOut:
                return "/api/common/token/logout"
                
            case .getVersion:
                return "GetVersion"
                
            //home
            case .homePage:
                return "GetCarousel"
                
            case .homeRecommendVideoList:
                return "GetRecommendVideoList"
                
            case .homeAttentionVideoList:
                return "GetFollowVideoList"
                
            case .userLevel:
                return "GetUserExpDetail"
                
            case .currentUserLevel:
                return "getUserLevel"
                
            case .userLevelDetail:
                return "GetUserLevelDetail"
                
            case .activenessDetail:
                return "LivenessDetail"
                
            case .fruitDetail:
                return "PearlDetail"
                
            case .schoolVideoList:
                return "GetSchoolVideo"
                
            case .schoolUserGuide:
                return "GetCommercialBeginnerGuide"
                
            case .myTask:
                return "getMyReel"
                
            case .taskAll:
                return "getReel"
                
            case .historyTask:
                return "getPastReel"
                
            case .teamInfo:
                return "GetUserTeamInfo"
                
            case .teamAllList:
                return "GetUserTeamAll"
                
            case .teamNotAuthList:
                return "NotRealNameAuthentication"
                
            case .teamAuthList:
                return "RealNameAuthentication"

            case .messsageList:
                return "getMessage"
                
            case .messageBadgeState:
                return "GetMessageStatus"
                
            case .refreshMessageBadgeState:
                return "ChangeMessageStatus"
                
                
                
            //video
            case .getUploadAuthAndAddress:
                return "CreateUploadVideo"
                
            case .getVideoSTS:
                return "GetVideoPlaySts"
                
            case .videoList:
                return "GetVideoList"
                
            case .attention:
                return "follow"
                
            case .videoLike:
                return "VideoThumbup"
                
            case .videoCommentList:
                return "GetCommentList"
                
            case .videoReport:
                return "Report"
                
            case .videoCommentLike:
                return "CommentThumbup"
                
            case .deleteVideo:
                return "deleteVideo"
                
            case .setVideoSecurity:
                return "setUpPrivacyVideo"
                
            case .videoComment:
                return "AddComment"
        
            case .twiceComment:
                return "AddCommentReply"
                
            case .getInviteCode:
                return "GetShareUserInfo"
                
                
            //交换中心
            case .exchangeInfo:
                return "GetXchgMarketOverview"
                
            case .exchangeInfoList:
                return "GetXchgMarketOrderList"
                
            case .readySendBuyOrder:
                return "PrepareBidXchgOrder"
                
            case .readySendSellOrder:
                return "PrepareAskXchgOrder"
                
            case .sendBuyOrder:
                return "BidXchgOrder"
                
            case .sendSellOrder:
                return "AskXchgOrder"
                
            case .readyAcceptOrder:
                return "PrepareAcceptXchgOrder"
                
            case .acceptOrder:
                return "AcceptXchgOrder"
                
            case .recordList:
                return "GetXchgOrderList"
                
            case .recordDetail:
                return "GetXchgOrderDetail"
                
            case .cancelOrder:
                return "CancelXchgOrder"
                
            case .payOrder:
                return "PayXchgOrder"
                
                
                
            //我的
            case .userInfo:
                return "getUserCenterInfo"

            case .about:
                return "/api/base/introduction.do"
                
            case .userInfoVideo:
                return "GetUserVideoInfo"
                
            case .feedback:
                return "Feedback"
                
            case .myFeedback:
                return "FeedbackDetail"
                
            case .editUserInfo:
                return "updateUserProfile"
                
            case .getUserValidateToken:
                return "GetVerifyToken"
           
            case .getAuthWithUploadImage:
                return "CreateUploadImage"
                
            case .getUserValidateStatus:
                return "GetUserVerifyStatus"
                
            case .userValidate:
                return "VerifyUserNonFace"
                
            case .editBackgroundImage:
                return "UpdateBackgroundImage"
                
            case .attentionAndFansList:
                return "GetFollowFansList"
                
            case .setExchangePassword:
                return "ResetXchgPassword"
                
            case .setPayWay:
                return "SetXchgMoneyAcctApiSpec"
                
            }
          
        }
        
        
        //MARK: - param
        var param: [String: Any]?
        
//        var singleParam: Any?
        
        
        switch self {
        //
        case .visitorLogin(let deviceId):
            param = [
                "deviceId": deviceId
            ]
            
        case .register(let phone, let msgcode, let inviteCode):
            param = [
                "mobile": phone,
                "msgcode": msgcode,
                "inviteCode": inviteCode
            ]
            
        case .login(let phone, let psd, let msgcode):
            param = [
                "mobile": phone,
                "password": psd,
                "msgcode": msgcode
            ]

        case .getAuthCode(let phone):
            param = [
                "mobile": phone
            ]
            
        case .validateAuthCode(let phone, let code):
            param = [
                "mobile": phone,
                "msgcode": code
            ]

        case .changePsd(let userId, let phone, let password):
            param = [
                "userId": userId,
                "mobile": phone,
                "password": password
            ]
        
        case .loginOut: break
            
        case .getVersion:
            param = [
                "type": "iOS"
            ]
            
            
        //home
        case .homePage: break
            
        case .homeRecommendVideoList(let page):
            param = [
                "next": page
            ]
            
        case .homeAttentionVideoList(let page):
            param = [
                "next": page
            ]
            
        case .userLevel(let nextPage):
            param = [
                "next": nextPage
            ]
            
        case .currentUserLevel: break
            
        case .userLevelDetail: break
            
            
        case .activenessDetail(let page):
            param = [
                "skip": page
            ]
            
        case .fruitDetail(let page):
            param = [
                "skip": page
            ]
            
        case .schoolVideoList(let page):
            param = [
                "skip": page
            ]
            
        case .schoolUserGuide(let page):
            param = [
                "skip": page
            ]
            
        case .myTask(let page):
            param = [
                "skip": page
            ]
            
        case .taskAll(let page):
            param = [
                "skip": page
            ]
            
        case .historyTask(let page):
            param = [
                "skip": page
            ]
            
            
        case .teamInfo: break
            
        case .teamAllList(let page):
            param = [
                "skip": page
            ]
            
        case .teamNotAuthList(let page):
            param = [
                "skip": page
            ]
            
        case .teamAuthList(let page):
            param = [
                "skip": page
            ]
            
        case .messsageList(let page, let category):
            param = [
                "skip": page,
                "category": category
            ]
            
        case .messageBadgeState: break
            
        case .refreshMessageBadgeState(let category):
            param = [
                "category": category
            ]
        
            
        //video
        case .getUploadAuthAndAddress(let description, let fileName):
            param = [
                "title": description,
                "fileName": fileName,
                "description": ""
            ]
            
        case .getVideoSTS: break
            
        case .videoList(let type, let videoIndex, let videoId):
            param = [
                "type": type,
                "nextPos": videoIndex,
                "videoId": videoId
            ]
            
        case .attention(let id, let action):
            param = [
                "followeeId": id,
                "action": action
            ]
            
        case .videoLike(let id, let action):
            param = [
                "videoId": id,
                "action": action
            ]
            
        case .videoCommentList(let videoId, let page):
            param = [
                "videoId": videoId,
                "skip": page
            ]
            
        case .videoReport(let videoId, let type, let content):
            param = [
                "videoId": videoId,
                "type": type,
                "content": content
            ]
            
        case .videoCommentLike(let videoId, let commentId, let action):
            param = [
                "videoId": videoId,
                "commentId": commentId,
                "action": action
            ]
            
        case .deleteVideo(let videoId):
            param = [
                "videoId": videoId
            ]
            
        case .setVideoSecurity(let videoId, let security):
            param = [
                "videoId": videoId,
                "isPrivcy": security
            ]
            
        case .videoComment(let videoId, let content):
            param = [
                "videoId": videoId,
                "content": content
            ]
            
        case .twiceComment(let id, let videoId, let content):
            param = [
                "id": id,
                "videoId": videoId,
                "content": content
            ]
            
        case .getInviteCode: break
            
        
        //交换中心
        case .exchangeInfo: break
            
        case .exchangeInfoList(let isBuyOrder, let phone, let page):
            param = [
                "type": isBuyOrder ? "BID" : "ASK",
                "mobile": phone,
                "skip": page
            ]
            
        case .readySendBuyOrder: break
            
        case .readySendSellOrder: break
            
        case .sendBuyOrder(let price, let count, let password):
            param = [
                "price": price,
                "volume": count,
                "xchgPassword": password
            ]
            
        case .sendSellOrder(let price, let count, let password):
            param = [
                "price": price,
                "volume": count,
                "xchgPassword": password
            ]
            
        case .readyAcceptOrder(let orderId):
            param = [
                "orderId": orderId
            ]
            
        case .acceptOrder(let orderId, let password, let count):
            param = [
                "orderId": orderId,
                "xchgPassword": password,
                "amount": count
            ]
            
        case .recordList(let type, let nextPage):
            param = [
                "orderCategory": type.rawValue,
                "next": nextPage
            ]
            
        case .recordDetail(let orderId):
            param = [
                "orderId": orderId
            ]
            
        case .cancelOrder(let orderId):
            param = [
                "orderId": orderId
            ]
            
        case .payOrder(let orderId, let screenshot):
            param = [
                "orderId": orderId,
                "paymentImageUrl": screenshot
            ]
            
            
        
        //我的
        case .userInfo(let userId, let page):
            param = [
                "userId": userId,
                "skip": page
            ]
            
        case .about: break
            
        case .userInfoVideo(let userId, let type, let page):
            param = [
                "userId": userId,
                "type": type,
                "skip": page
            ]
            
        case .feedback(let type, let name, let phone, let idCard, let imageUrl, let content):
            param = [
                "type": type,
                "name": name,
                "tel": phone,
                "idCard": idCard,
                "imageUrl": imageUrl,
                "content": content
            ]
            
        case .myFeedback(let page):
            param = [
                "skip": page
            ]
            
        case .editUserInfo(let name, let avatarUrl, let sign, let gender):
            param = [
                "nickName": name,
                "avatarUrl": avatarUrl,
                "autograph": sign,
                "gender": gender
            ]
            
        case .getUserValidateToken(let idCard, let name):
            param = [
                "idNo": idCard,
                "name": name
            ]
            
        case .getAuthWithUploadImage(let imageExt):
            param = [
                "imageExt": imageExt
            ]
            
        case .getUserValidateStatus: break
            
        case .userValidate(let name, let idCard, let deviceId):
            param = [
                "name": name,
                "idNo": idCard,
                "verifyId": deviceId,
                "platform": "iOS"
            ]
            
        case .editBackgroundImage(let imagePath):
            param = [
                "backgroundImageUrl": imagePath
            ]

        case .attentionAndFansList(let type, let userId, let content, let page):
            param = [
                "type": type,
                "userId": userId,
                "content": content,
                "skip": page
            ]
            
        case .setExchangePassword(let phone, let authCode, let password):
            param = [
                "mobile": phone,
                "checkCode": authCode,
                "xchgPassword": password
            ]
            
        case .setPayWay(let name, let account):
            param = [
                "name": name,
                "account": account,
                "type": "ALIPAY"
            ]
            
        }
        
        
        
        if param != nil { param = ["object": param!] }
        else { param = [String: Any]() }
        //add path
        param?["action"] = path
        
        
        
        //MARK: - setting
        let url = try kBaseURLString.asURL()
//        var urlReq = URLRequest(url: url.appendingPathComponent(path))
        var urlReq = URLRequest(url: url)
        
        
        //post
        urlReq.httpMethod = HTTPMethod.post.rawValue
        //超时时间
        urlReq.timeoutInterval = 15
        
        //MARK: - add token
        switch self {
//        case .login, .visitorLogin, .register:
//            break

        default:
            let token = UserDefaults.standard.string(forKey: kToken)
            if token != nil {
                if token!.count > 0 { urlReq.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization") }
            }
            break
        }
        
        
        
        //MARK: - Content-Type
        switch self {
//        case .getAuthCode:
//            urlReq.setValue("multipart/form-data;text/xml", forHTTPHeaderField: "Content-Type")
//
//        case .uploadLogo, .uploadLogFile:
//            urlReq.setValue("multipart/form-data;application/json", forHTTPHeaderField: "Content-Type")
        default:
            urlReq.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            
        }
 

        //MARK: - encoding http body
        switch self {
//        case .addClientNotice, .addClientMaintain, .commitMeWorkLog:
//            if let single = singleParam {
//                //                print("single param: \(single)")
//                urlReq = try JSONEncoding.default.encode(urlReq, withJSONObject: single)
//            }
//            break
//        case .userInfoEdit, .feedback:
//            if let single = singleParam {
//                urlReq =  try JSONEncoding.default.encode(urlReq, withJSONObject: single)
//            }
//            break
            
        default:
            if let param = param {
                //                print(param.getJSONStringFromDictionary())
                do{
                    urlReq = try JSONEncoding.default.encode(urlReq, with: param)
//                    urlReq = try URLEncoding.default.encode(urlReq, with: param)
                    
                }catch{
                    print(error.localizedDescription)
                }
                
            }
            break
        }
        
        return urlReq
    }
    
}



