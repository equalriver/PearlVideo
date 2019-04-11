//
//  PVNetworkRouter.swift


import Alamofire
import SwiftyJSON

enum Router: URLRequestConvertible {
    
    ///登录
    case login(name: String, psd: String)
    
    ///获取验证码
    case getAuthCode(email: String)
    
    ///忘记密码
    case forgetPsd(email: String, newPsd: String, authCode: String)
    
    ///修改密码
    case changePsd(oldPsd: String, newPsd: String)
    
    ///退出登录
    case loginOut()
    
    
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
    case userInfo()
    
    ///关于我们
    case about()
    
    ///用户信息编辑
    case userInfoEdit(json: Any)
    
    ///意见反馈
    case feedback(json: Any)
    
    
    
    //MARK: -
    func asURLRequest() throws -> URLRequest {
        
        var path: String {
            switch self {
            //
            case .login:
                return "/api/common/token/login"

            case .getAuthCode:
                return "/api/base/getAuthCode"
                
            case .forgetPsd:
                return "/api/base/forgetPsd"
                
            case .changePsd:
                return "/api/base/changePsd.do"
                
            case .loginOut:
                return "/api/common/token/logout"
                
                
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
                return "/api/base/userInfo"

            case .about:
                return "/api/base/introduction.do"
                
            case .userInfoEdit:
                return "/api/base/editUserInfo"
                
            case .feedback:
                return "/api/base/feedback.do"
            }
          
        }
        
        
        //MARK: - param
        var param: [String: Any]? = [:]
        
        var singleParam: Any?
        
        
        switch self {
        //
        case .login(let name, let psd):
            param = [
                "username": name,
                "password": psd
            ]

        case .getAuthCode(let email):
            param = [
                "email": email
            ]
            
        case .forgetPsd(let email, let newPsd, let authCode):
            param = [
                "email": email,
                "newPsd": newPsd,
                "authCode": authCode
            ]

        case .changePsd(let oldPsd, let newPsd):
            param = [
                "oldPsd": oldPsd,
                "newPsd": newPsd
            ]
        
        case .loginOut: break
            
        
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
        case .userInfo: break
            
        case .about: break
            
        case .userInfoEdit(let json):
            singleParam = json
            
        case .feedback(let json):
            singleParam = json

        }
        
        
        //MARK: - setting
        let url = try kBaseURLString.asURL()
        var urlReq = URLRequest(url: url.appendingPathComponent(path))
        //post
        urlReq.httpMethod = HTTPMethod.post.rawValue
        //超时时间
        urlReq.timeoutInterval = 15
        
        //MARK: - add token
        switch self {
        case .login, .getAuthCode, .forgetPsd, .about:
            break

        default:
            let token = UserDefaults.standard.string(forKey: "token")
            if token != nil {
                if token!.count > 0 { urlReq.setValue(token, forHTTPHeaderField: "token") }
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
        case .userInfoEdit, .feedback:
            if let single = singleParam {
                urlReq =  try JSONEncoding.default.encode(urlReq, withJSONObject: single)
            }
            break
            
        default:
            if let param = param {
                //                print(param.getJSONStringFromDictionary())
                do{
//                    urlReq = try JSONEncoding.default.encode(urlReq, with: param)
                    urlReq = try URLEncoding.default.encode(urlReq, with: param)
                    
                }catch{
                    print(error.localizedDescription)
                }
                
            }
            break
        }
        
        return urlReq
    }
    
}



