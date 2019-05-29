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
    case loginOut()
    
    
    //首页
    ///首页
    case homePage()
    
    ///首页推荐视频列表
    case homeRecommendVideoList(page: Int)
    
    ///首页关注视频列表
    case homeAttentionVideoList(page: Int)
    
    ///会员等级详情
    case userLevelDetail()
    
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
    case teamInfo()
    
    ///全部团队成员列表
    case teamAllList(page: Int)
    
    ///未实名认证团队成员列表
    case teamNotAuthList(page: Int)
    
    ///实名认证团队成员列表
    case teamAuthList(page: Int)

    ///消息列表category：NOTICEMESSAGE(通知)，COMMENTMESSAGE（评论），FOLLOWMESSAGE（关注），THUMBUPMESSAGE（点赞）
    case messsageList(page: Int, category: String)
    
    ///获取消息状态
    case messageBadgeState()
    
    ///更新消息状态category：NOTICEMESSAGE(通知)，COMMENTMESSAGE（评论），FOLLOWMESSAGE（关注），THUMBUPMESSAGE（点赞）
    case refreshMessageBadgeState(category: String)
    
    
    
    //video
    ///获取上传地址和凭证
    case getUploadAuthAndAddress(description: String, fileName: String)
    
    ///获取播放STS
    case getVideoSTS()
    
    ///所有视频播放列表 1: 推荐, 2: 关注, 3: 我的作品, 4: 我的喜欢视频, 5: 私密视频
    case videoList(type: Int, videoIndex: Int, videoId: String)
    
    ///视频关注 action: 1关注 2取消
    case videoAttention(id: String, action: Int)
    
    ///视频点赞 action: 1点赞 2取消
    case videoLike(id: String, action: Int)
    
    ///视频评论列表
    case videoCommentList(videoId: String, page: Int)
    
    ///视频举报
    case videoReport()
    
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
    case getInviteCode()
    
    
    
    //我的
    ///用户信息
    case userInfo(userId: String, page: Int)
    
    ///关于我们
    case about()
    
    ///视频 type: 3作品 4喜欢 5私密
    case userInfoVideo(userId: String, type: Int, page: Int)
    
    ///意见反馈
    case feedback()
    
    ///我的反馈
    case myFeedback(page: Int)
    
    ///修改用户信息  autograph签名
    case editUserInfo()
    
    ///获取实人认证token
    case getUserValidateToken()
    
    
    
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
                
            //home
            case .homePage:
                return "GetCarousel"
                
            case .homeRecommendVideoList:
                return "GetRecommendVideoList"
                
            case .homeAttentionVideoList:
                return "GetFollowVideoList"
                
            case .userLevelDetail:
                return "getUserLevel"
                
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
                
            case .videoAttention:
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
                return "getInviteCode"
                
                
                
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
            
        case .videoAttention(let id, let action):
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
            
        case .videoReport: break
            
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
            
        case .feedback: break
            
        case .myFeedback(let page):
            param = [
                "skip": page
            ]
            
        case .editUserInfo: break
            
        case .getUserValidateToken: break

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
            let token = UserDefaults.standard.string(forKey: kToken) ?? UserDefaults.standard.string(forKey: kVisitorToken)
            if token != nil {
                if token!.count > 0 { urlReq.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization") }
            }
            break
        }
        
        
        
        //MARK: - Content-Type
//        switch self {
//        case .getAuthCode:
//            urlReq.setValue("multipart/form-data;text/xml", forHTTPHeaderField: "Content-Type")
//
//        case .uploadLogo, .uploadLogFile:
//            urlReq.setValue("multipart/form-data;application/json", forHTTPHeaderField: "Content-Type")
//        default:
//            urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
//        }
 

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



