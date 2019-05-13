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
    
    ///忘记密码
    case forgetPsd(email: String, newPsd: String, authCode: String)
    
    ///修改密码
    case changePsd(userId: String, phone: String, psd: String)
    
    ///退出登录
    case loginOut()
    
    
    //首页
    ///首页
    case homePage()
    
    ///首页视频列表
    case homeVideoList(page: Int)
    
    ///会员等级详情
    case userLevelDetail()
    
    ///活跃度详情
    case activenessDetail(page: Int, count: Int)
    
    ///平安果详情
    case fruitDetail(page: Int, count: Int)
    
    ///商学院视频列表
    case schoolVideoList(page: Int, count: Int)
    
    ///商学院新手指南
    case schoolUserGuide(page: Int, count: Int)
    
    ///我的团队信息
    case teamInfo()
    
    ///全部团队成员列表
    case teamAllList(page: Int, count: Int)
    
    ///未实名认证团队成员列表
    case teamNotAuthList(page: Int, count: Int)
    
    ///实名认证团队成员列表
    case teamAuthList(page: Int, count: Int)
    
    
    
    //message
    ///消息列表
    case messsageList()
    
    ///待办事项列表
    case toDoList()
    
    
    //application
    ///获取应用列表
    case getApplicationList()
    
    //contact
    ///通讯录最近联系人
    case contactRecently()
    
    ///通讯录所有人
    case contactAll(pageIndex: String)
    
    ///通讯录同部门
    case contactDepartment()
    
    ///通讯录组织
    case contactOrganization()
    
    ///通讯录下属
    case contactUnderling()
    
    ///通讯录组织详情
    case contactOrgDetail(depId: String)
    
    ///通讯录人员详情
    case contactPersonDetail(userId: String)
    
    
    //我的
    ///用户信息
    case userInfo(userId: String, skip: Int, count: Int)
    
    ///关于我们
    case about()
    
    ///意见反馈
//    case feedback(json: Any)
    
    
    
    //MARK: -
    func asURLRequest() throws -> URLRequest {
        
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
                
            case .forgetPsd:
                return "retrievePassword"
                
            case .changePsd:
                return "/api/base/changePsd.do"
                
            case .loginOut:
                return "/api/common/token/logout"
                
            //home
            case .homePage:
                return "GetCarousel"
                
            case .homeVideoList:
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
                
            case .teamInfo:
                return "GetUserTeamInfo"
                
            case .teamAllList:
                return "GetUserTeamAll"
                
            case .teamNotAuthList:
                return "NotRealNameAuthentication"
                
            case .teamAuthList:
                return "RealNameAuthentication"
                
                
                
            //message
            case .messsageList:
                return "/api/base/receivedMsg.do"
                
            case .toDoList:
                return "/api/base/getToDoList.do"
                
                
            //application
            case .getApplicationList:
                return "/api/application/getApplicationMenu"
                
                
            //contact
            case .contactRecently:
                return "/api/base/getRecentUser"
                
            case .contactAll:
                return "/api/base/getAllUserInfo.do"
                
            case .contactDepartment:
                return "/api/base/getSameDepUserInfo.do"
                
            case .contactOrganization:
                return "/api/base/getOrgInfo.do"
                
            case .contactUnderling:
                return "/api/base/getSubUserInfo"
                
            case .contactOrgDetail:
                return "/api/base/getUserInfoByDep.do"
                
            case .contactPersonDetail:
                return "/api/base/getInfoByUserId"
                
                
            //我的
            case .userInfo:
                return "getUserCenterInfo"

            case .about:
                return "/api/base/introduction.do"
                
            
           
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
            
        case .forgetPsd(let email, let newPsd, let authCode):
            param = [
                "email": email,
                "newPsd": newPsd,
                "authCode": authCode
            ]

        case .changePsd(let userId, let mobile, let password):
            param = [
                "userId": userId,
                "mobile": mobile,
                "password": password
            ]
        
        case .loginOut: break
            
            
        //home
        case .homePage: break
            
        case .homeVideoList(let page):
            param = [
                "next": page
            ]
            
        case .userLevelDetail: break
            
        case .activenessDetail(let page, let count):
            param = [
                "skip": page,
                "count": count
            ]
            
        case .fruitDetail(let page, let count):
            param = [
                "skip": page,
                "count": count
            ]
            
        case .schoolVideoList(let page, let count):
            param = [
                "skip": page,
                "count": count
            ]
            
        case .schoolUserGuide(let page, let count):
            param = [
                "skip": page,
                "count": count
            ]
            
        case .teamInfo: break
            
        case .teamAllList(let page, let count):
            param = [
                "skip": page,
                "count": count
            ]
            
        case .teamNotAuthList(let page, let count):
            param = [
                "skip": page,
                "count": count
            ]
            
        case .teamAuthList(let page, let count):
            param = [
                "skip": page,
                "count": count
            ]
            
            
        
        //message
        case .messsageList:
            param = [
                "isRead": false
            ]
            
        case .toDoList: break
            
        
        //application
        case .getApplicationList: break
            
            
        //contact
        case .contactRecently: break
            
        case .contactAll(let pageIndex):
            param = [
                "pageIndex": pageIndex,
                "pageSize": "50"
            ]
            
        case .contactDepartment: break
            
        case .contactOrganization: break
            
        case .contactUnderling: break
            
        case .contactOrgDetail(let depId):
            param = [
                "depId": depId
            ]
            
        case .contactPersonDetail(let userId):
            param = [
                "userId": userId
            ]
            
        
        //我的
        case .userInfo(let userId, let skip, let count):
            param = [
                "userId": userId,
                "skip": skip,
                "count": count
            ]
            
        case .about: break
            
            
//        case .feedback(let json):
//            singleParam = json
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
        case .login, .visitorLogin, .register:
            break

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



