//



import Foundation
import Alamofire
import SwiftyJSON
import CoreTelephony
import SVProgressHUD

typealias responseCallback = (_ response : JSON) -> Void
typealias errorCallback = (_ error : Error) -> Void

class PVNetworkTool: SessionManager {
    
    public static let shared: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.timeoutIntervalForResource = 15
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        //        config.httpAdditionalHeaders = ["content-Type": "application/json"]
        let manager = SessionManager(configuration: config)
        
        return manager
        
    }()
    
    
    public class func Request(router: Router, success: @escaping responseCallback, failure: @escaping errorCallback) {
        
        DispatchQueue.global().async {
            //check login
//            if UserDefaults.standard.string(forKey: kToken) == nil {
//                switch router {
//                case .login:
//                    break
//
//                default:
//                    return
//                }
//            }
 
            //检查是否使用代理
            if YPJOtherTool.ypj.getProxyStatus() == true {
                DispatchQueue.main.async {
                    SVProgressHUD.showError(withStatus: "使用了代理或网络连接错误")
                }
                return
            }
            
            //检查网络状态
            if UserDefaults.standard.string(forKey: "PV_isFirstLogin") != nil {
                
                DispatchQueue.ypj_once(token: "PV_checkNetwork", block: {
                    checkNetwork { (isOpen) in
                        if isOpen == false {  }
                    }
                })
                
            }
            
            PVNetworkTool.shared.request(router).validate().responseJSON { (resp) in
                
                //第一次登录不提示网络权限
                DispatchQueue.ypj_once(token: "PV_isFirstLogin", block: {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 30, execute: {
                        UserDefaults.standard.set("PV_isFirstLogin", forKey: "PV_isFirstLogin")
                    })
                })
                
                //token过期重登录
                DispatchQueue.main.async {
                    if let r = resp.response {
                        if r.statusCode == 401 {
                            if let vc = YPJOtherTool.ypj.currentViewController() {
                                guard vc.isKind(of: PVLoginVC.self) == false else { return }
                                UserDefaults.standard.set(nil, forKey: kToken)
                                UserDefaults.standard.synchronize()
                                YPJOtherTool.ypj.loginValidate(currentVC: vc, isLogin: nil)
                                return
                            }
                        }
                    }
                }
                
                
                switch resp.result {
                    
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    DispatchQueue.main.async { success(json) }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    //超时重连
//                    if error.localizedDescription.contains("The request timed out.") {
//                        print(error.localizedDescription)
//                        if YYReachability.init().status == .none { return }
//                        DispatchQueue.global().asyncAfter(deadline: .now() + 10, execute: {
//                            PVNetworkTool.Request(router: router, success: success, failure: failure)
//                        })
//                    }
                    DispatchQueue.main.async {
                        
                        if error.localizedDescription.contains("The request timed out.") {
                            SVProgressHUD.showInfo(withStatus: "连接超时")
                            return
                        }
                        
                        if error.localizedDescription.contains("E.NEED_REGISTER_USER_PRIVILEGE") {
                            DispatchQueue.ypj_once(token: "login", block: {
                                DispatchQueue.main.async {
                                    guard let vc = YPJOtherTool.ypj.currentViewController() else { return }
                                    if vc.isKind(of: PVLoginVC.self) { return }
                                    YPJOtherTool.ypj.loginValidate(currentVC: vc, isLogin: nil)
                                }
                            })
                            
                        }
                        if error.localizedDescription.contains("没实名认证") {
                            DispatchQueue.main.async {
                                guard let vc = YPJOtherTool.ypj.currentViewController() else { return }
                                let validateVC = PVMeNameValidateVC()
                                YPJOtherTool.ypj.showAlert(title: nil, message: "未实名认证，点击前往认证页面", style: .alert, isNeedCancel: false, handle: { (ac) in
                                    vc.navigationController?.pushViewController(validateVC, animated: true)
                                })
                                
                            }
                            return
                        }
                        if error.localizedDescription.contains("E.NEED_REGISTER_USER_PRIVILEGE") {
                            failure(error)
                            UserDefaults.standard.set(nil, forKey: kToken)
                            UserDefaults.standard.synchronize()
                            return
                        }
                        if error.localizedDescription.contains("E.NEED_VISITOR_PRIVILEGE") || error.localizedDescription.contains("E") {
                            failure(error)
                            return
                        }
                        SVProgressHUD.showError(withStatus: error.localizedDescription)
                        failure(error)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                            SVProgressHUD.dismiss()
                        })
                    }
                    
                }
            }
        }
        
        
    }
    
    //上传图片
    public class func upLoadImageRequest(images: [UIImage], imagesName: String, params: [String : Any], router: Router, success : @escaping responseCallback, failure : @escaping errorCallback) {
        
        PVNetworkTool.shared.upload(multipartFormData: { (multipartFormData) in
        
            for (index, img) in images.enumerated() {
                if let imgData = img.ypj.compressImage(maxLength: 2048 * 1024){//2M
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyyMMddHHmmss"
                    let str = formatter.string(from: Date())
                    let fileName = str + "upload" + "\(index)" + ".jpg"
                    // 以文件流格式上传
                    // 批量上传与单张上传，后台语言为java或.net等
                    multipartFormData.append(imgData, withName: imagesName, fileName: fileName, mimeType: "image/jpeg")
//                    guard let d = fileName.data(using: String.Encoding.utf8) else { break }
//                    multipartFormData.append(d, withName: "logoName")
                    
                    //                    // 单张上传，后台语言为PHP
                    //                    multipartFormData.append(imageData!, withName: "fileupload", fileName: fileName, mimeType: "image/jpeg")
                    //                    // 批量上传，后台语言为PHP。 注意：此处服务器需要知道，前台传入的是一个图片数组
                    //                    multipartFormData.append(imageData!, withName: "fileupload[\(index)]", fileName: fileName, mimeType: "image/jpeg")
                }
            }
            for (key ,value) in params {
                if var d = value as? Int {
                    let data = Data.init(bytes: &d, count: MemoryLayout.size(ofValue: d))
                    multipartFormData.append(data, withName: key)
                    continue
                }
                if let s = value as? String {
                    guard let d = s.data(using: String.Encoding.utf8) else { break }
                    multipartFormData.append(d, withName: key)
                    continue
                }
            }
            
        }, with: router
        ) { (encodingResult) in
            switch encodingResult {
            case .success(let request,  _,  _):
                request.responseJSON(completionHandler: { (resp) in
                    if resp.result.isSuccess {
                        guard resp.value != nil else { return }
                        let json = JSON(resp.value!)
                        success(json)
                    }
                    else {
                        failure(resp.result.error ?? PVError.networkError(message: nil))
                    }
                })
                
            case .failure(let error):
                print(error.localizedDescription)
                failure(error)
                
            }
        }
        
    }
    
    
    //上传文件
    public class func upLoadFileRequest(fileName: String, data: Data, filePath: String, router: Router, success : @escaping responseCallback, failure : @escaping errorCallback) {
        
        PVNetworkTool.shared.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: "txt")
            
            
        }, with: router
        ) { (encodingResult) in
            switch encodingResult {
            case .success(_,  _,  _):
                //删除文件
                do {
                    try FileManager.default.removeItem(atPath: filePath)
                }
                catch { print(error.localizedDescription) }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                failure(error)
                
            }
        }
        
    }
    
    ///上传至阿里云
    public class func uploadFileWithAliyun(description: String, auth: String, address: String, filePath: String, handle:@escaping (_ isSuccess: Bool) -> Void) {
        SVProgressHUD.show(withStatus: "正在上传...")
        let uploadManager = VODUploadClient.init()
        let listener = VODUploadListener()
        //开始上传回调
        listener.started = { (fileInfo) in
            // fileInfo 上传文件信息
            uploadManager.setUploadAuthAndAddress(fileInfo, uploadAuth: auth, uploadAddress: address)
        }
        listener.progress = { (fileInfo, uploadedSize, totalSize) in
            
        }
        //上传完成回调
        listener.finish = { (fileInfo, result) in
            // fileInfo 上传文件信息
            // result 上传结果信息
            SVProgressHUD.dismiss()
            if let info: UploadFileInfo = fileInfo {
                DispatchQueue.main.async {
                    if info.state == .success {
                        handle(true)
                    }
                    if info.state == .failure {
                        uploadManager.stop()
                        handle(false)
                    }
                }
            }
            if let result: VodUploadResult = result {
                print("上传结果信息: ", result)
            }
        }
        //上传失败回调
        listener.failure = { (fileInfo, code, message) in
            // fileInfo 上传文件信息
            // code 错误码
            // message 错误描述
            uploadManager.stop()
            print(message ?? "")
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                handle(false)
            }
        }
        uploadManager.setListener(listener)
        
        let vodInfo = VodInfo.init()
        vodInfo.title = description
        
        uploadManager.addFile(filePath, vodInfo: vodInfo)
        uploadManager.start()
    }
    
    
    ///检查wifi或wwan是否打开
    private class func checkNetwork(handle: @escaping (_ isOpen: Bool) -> Void) {
        
        let reach = YYReachability.init()
        
        let cellularData = CTCellularData.init()
        cellularData.cellularDataRestrictionDidUpdateNotifier = { (state) in
            
            switch state {
            case .notRestricted://蜂窝移动网和WLAN
                handle(true)
                break
                
            case .restrictedStateUnknown://未知
                handle(true)
                break
                
            case .restricted://关闭 或 WLAN
                
                if reach.status == .wiFi {
                    handle(true)
                    break
                }
                DispatchQueue.ypj_once(token: "bj_checkNetwork", block: {
                    let alert = UIAlertController.init(title: nil, message: "无法访问网络，未打开无线数据访问权限，是否现在打开?", preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "是", style: .default, handler: { (ac) in
                        
                        DispatchQueue.main.async {
                            if let url = URL.init(string: UIApplication.openSettingsURLString) {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                        }
                        
                    })
                    let cancel = UIAlertAction.init(title: "否", style: .cancel, handler: nil)
                    alert.addAction(action)
                    alert.addAction(cancel)
                    DispatchQueue.main.async {
                        if let vc = YPJOtherTool.ypj.currentViewController() {
                            vc.present(alert, animated: true, completion: nil)
                        }
                    }
                })
                
                handle(false)
                break
            }
            
        }
        
    }
    
    
}
















