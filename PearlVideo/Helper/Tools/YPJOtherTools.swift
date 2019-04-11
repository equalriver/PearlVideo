//
//  YPJOtherTools.swift


import Foundation
import SVProgressHUD
import CFNetwork
import LocalAuthentication
import CommonCrypto


struct YPJOtherTool {
    
    public static let ypj: YPJOtherTool = {
        return YPJOtherTool.init()
    }()
}

//MARK: -
extension YPJOtherTool {
    
    //MARK: - AES128加密
    ///AES128加密
    func aes128cbc(content: String) throws -> String? {
        guard let contentData = content.data(using: .utf8) else { return nil }
        
        //kCCEncrypt 加密  kCCDecrypt 解密
        //kCCOptionPKCS7Padding   = 0x0001      --> 需要iv
        //kCCOptionECBMode        = 0x0002      --> 不需要iv
        //key：加密密钥（指针）  -------  keyLength：密钥长度
        //dataIn：要加密的数据（指针）  ------  dataInLength：数据的长度
        //dataOut：加密后的数据（指针）  ------  dataOutAvailable：数据接收的容器长度
        //dataOutMoved：数据接收
        guard let key = kAES_KEY.data(using: .utf8)?.withUnsafeBytes({ (bytes: UnsafePointer<UInt8>) -> UnsafePointer<UInt8> in
            return bytes
        }) else { return nil }
        let keyLength = size_t(kCCKeySizeAES128)
        
        guard let iv = kInitVector.data(using: .utf8)?.withUnsafeBytes({ (bytes: UnsafePointer<UInt8>) -> UnsafePointer<UInt8> in
            return bytes
        }) else { return nil }
        
        let dataIn = contentData.withUnsafeBytes({ (bytes: UnsafePointer<UInt8>) -> UnsafePointer<UInt8> in
            return bytes
        })
        let dataLength = size_t(contentData.count)
        
        var data = Data(count: dataLength + Int(kCCBlockSizeAES128))
        let dataOut = data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> in
            return bytes
        }
        let dataOutAvailable = size_t(data.count)
        
        var dataOutMoved: size_t = 0
        
        let cryptStatus = CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(kCCKeySizeAES128), CCOptions(kCCOptionPKCS7Padding), key, keyLength, iv, dataIn, dataLength, dataOut, dataOutAvailable, &dataOutMoved)
        
        if cryptStatus == kCCSuccess {
            data.count = dataOutMoved
            return data.base64EncodedString()
        }
        return nil
    }
    
    //MARK: - 指纹识别
    ///指纹识别
    func authWithTouchID(callback: @escaping (_ isSuccess: Bool) -> Void) {
        let context = LAContext.init()
        
        var error: NSError?
        
        let support = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        
        if support == true {
            var rea = "指纹"
            if #available(iOS 11.0, *) {
                if context.biometryType == LABiometryType.faceID { rea = "FaceID" }
            }
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "请使用\(rea)解锁") { (isSuccess, err) in
                if isSuccess == false && err != nil {
                    print(err!.localizedDescription)
                }
                DispatchQueue.main.async {
                    callback(isSuccess)
                }
                
            }
        }
        else {
            if let error = error {
                //没有设置指纹（没有设置密码也会走到这），但是支持指纹识别
                if error.code == kLAErrorTouchIDNotEnrolled || error.code == kLAErrorPasscodeNotSet {
                    showAlert(title: nil, message: "没有设置指纹", style: .alert, isNeedCancel: false, handle: nil)
                }
            }
        }
        
    }
    
    //MARK: - alert controller
    ///alert
    func showAlert(title: String?, message: String?, style: UIAlertController.Style, isNeedCancel: Bool, handle: ((_ : UIAlertAction) -> Void)?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: style)
        
        let ac = UIAlertAction.init(title: "确定", style: .default) { (act) in
            handle?(act)
        }
        
        let cancel = UIAlertAction.init(title: isNeedCancel == true ? "取消" : "好", style: .cancel) { (act) in
            handle?(act)
        }
        
        alert.addAction(cancel)
        if isNeedCancel == true { alert.addAction(ac) }
        
        if let vc = currentViewController() {
            DispatchQueue.main.async {
                vc.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - 检测网络
    ///检测网络
    func checkNetwork() -> Bool {
        switch YYReachability.init().status {
        case .none:
            SVProgressHUD.showInfo(withStatus: "咦～竟然没有检测到网络")
            return false
        default:
            return true
        }
    }
    
    //MARK: - 检测是否是WIFI
    ///检测是否是WIFI
    func isWIFI() -> Bool {
        switch YYReachability.init().status {
        case .none:
            SVProgressHUD.showInfo(withStatus: "咦～竟然没有检测到网络")
            return false
            
        case .wiFi:
            return true
            
        default:
            return false
        }
    }
    
    //MARK: - 是否使用了代理
    ///是否使用了代理
    func getProxyStatus() -> Bool {
        
        guard let url = URL.init(string: "http://www.baidu.com") as CFURL? else { return false }
        
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() else { return false }
        
        guard let proxies = CFNetworkCopyProxiesForURL(url, proxySettings).takeRetainedValue() as? Array<Any> else { return false }
        
        if let dic = proxies.first as? Dictionary<String, Any> {
            
            guard let kCFProxyTypeKey = dic["kCFProxyTypeKey"] as? String else { return false }
            
            if kCFProxyTypeKey == "kCFProxyTypeNone" { return false }
            else { return true }
        }
        return false
        
    }
    /*
    - (BOOL)getProxyStatus {
    NSDictionary *proxySettings =  (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
    //没有设置代理
    return NO;
    }else{
    //设置代理了
    return YES;
    }
    }
    */

    //MARK: - 登录验证
    ///登录验证
    public func loginValidate(currentVC: UIViewController, isLogin: ((_ isLogin: Bool) -> Void)?) {
        
        switch YYReachability.init().status {
        case .none:
            SVProgressHUD.showInfo(withStatus: "咦～竟然没有检测到网络")
            return
        default:
            break
        }
        guard UserDefaults.standard.string(forKey: "token") != nil else {
            
            let vc = PVBaseRootNaviVC.init(rootViewController: PVLoginVC())
            currentVC.present(vc, animated: true, completion: nil)
            isLogin?(false)
            return
        }
        isLogin?(true)
        
    }
    
    /*
     //MARK: - 崩溃日志
     ///崩溃日志上传
     public func uploadCrashLogFile() {
     
     let path = NSHomeDirectory() + "/Documents/error.txt"
     guard let token = UserDefaults.standard.string(forKey: "token") else { return }
     do {
     let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path))
     PVNetworkTool.upLoadFileRequest(fileName: token, data: data, filePath: path, router: .uploadLogFile(), success: { (resp) in
     
     }) { (error) in
     print(error.localizedDescription)
     }
     
     } catch {
     print(error.localizedDescription)
     }
     
     }
     */
    
    
    ///保存崩溃日志到本地
    func saveCrashLog(exception: NSException) {
        
        let stackArr = exception.callStackSymbols
        
        let reason = exception.reason
        
        let name = exception.name
        
        let info = "exception name: \(name)  \n" + "reason: \(reason ?? "无")  \n" + "stack: \(stackArr)"
        
        do {
            try info.write(toFile: NSHomeDirectory() + "/Documents/error.txt", atomically: true, encoding: String.Encoding.utf8)
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    /*
     ARK: - 获取某个月的天数
     ///获取某个月的天数
     public func getSumOfDaysInMonth(year: String, month: String) -> Int {
     
     let formatter = DateFormatter()
     formatter.dateFormat = "yyyy-MM"
     
     let dateStr = year + "-" + month
     guard let date = formatter.date(from: dateStr) else { return 0 }
     
     let ca = Calendar.init(identifier: .gregorian)
     if let range = ca.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date){
     return range.count
     }
     return 0
     
     }
     */
    
    //MARK: - 跳转到app权限设置页面
    ///跳转到app权限设置页面
    func gotoAuthorizationView(type: String, vc: UIViewController) {
        
        let alert = UIAlertController.init(title: nil, message: "app需要获取\(type)权限,点击确定跳转设置页面", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "确定", style: .default) { (ac) in
            if let url = URL.init(string: UIApplication.openSettingsURLString){
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.openURL(url)
                }
            }
            else {
                SVProgressHUD.showInfo(withStatus: "跳转设置页面失败")
            }
        }
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - 获取相册权限
    ///获取相册权限
    func getPhotosAuth(target: UIViewController, _ auth: @escaping () -> Void) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized, .notDetermined: auth()
            
        default:
            PHPhotoLibrary.requestAuthorization { (s) in
                switch s {
                case .authorized, .notDetermined:
                    DispatchQueue.main.async { auth() }
                    
                default: self.gotoAuthorizationView(type: "相册", vc: target)
                }
            }
        }
    }
    
    //MARK: - debug string
    ///debug string
    func debugString(debugStr: String) -> String {
        #if DEBUG
        return debugStr
        #else
        return ""
        #endif
    }
    
    
    //MARK: - 获取当前显示的controller
    ///获取当前显示的controller
    func currentViewController() -> UIViewController? {
        
        var result: UIViewController?
        
        var rootVC = UIApplication.shared.keyWindow?.rootViewController
        
        repeat {
            
            guard rootVC != nil else { return result }
            
            if rootVC!.isKind(of: UINavigationController.self) {
                let navi = rootVC as! UINavigationController
                let vc = navi.viewControllers.last
                result = vc
                rootVC = vc?.presentedViewController
                continue
            }
            else if rootVC!.isKind(of: UITabBarController.self) {
                let tab = rootVC as! UITabBarController
                result = tab
                rootVC = tab.viewControllers?[tab.selectedIndex]
                continue
            }
            else if rootVC!.isKind(of: UIViewController.self) {
                result = rootVC
                rootVC = nil
            }
            
        }while rootVC != nil
        
        return result
    }
    
    //MARK: - 判断是不是首次登录或者版本更新
    ///判断是不是首次登录或者版本更新
    func isAPPFirstLauch() -> Bool {
        //获取当前版本号
        guard let infoDic = Bundle.main.infoDictionary else { return false }
        guard let currentVersion: String = infoDic["CFBundleShortVersionString"] as? String else { return false }
        
        let version = UserDefaults.standard.string(forKey: "PV_app_version") ?? ""
        
        if version == "" || version != currentVersion {
            UserDefaults.standard.set(currentVersion, forKey: "PV_app_version")
            UserDefaults.standard.synchronize()
            return true
        }
        
        return false
    }
    
    
    //MARK: - 获取当前版本号
    ///获取当前版本号
    var currentVersion: String? {
        
        guard let infoDic = Bundle.main.infoDictionary else { return nil }
        let currentVersion = infoDic["CFBundleShortVersionString"] as? String
        
        return currentVersion
    }
    
    
    /*
     func createQRForString(qrString: String?, qrImageName: String) -> UIImage? {
     if let sureQRString = qrString{
     let stringData = sureQRString.data(using: String.Encoding.utf8, allowLossyConversion: false)
     //创建一个二维码的滤镜
     let qrFilter = CIFilter(name: "CIQRCodeGenerator")
     qrFilter?.setValue(stringData, forKey: "inputMessage")//通过kvo方式给一个字符串，生成二维码
     qrFilter?.setValue("H", forKey: "inputCorrectionLevel")//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
     let qrCIImage = qrFilter?.outputImage//拿到二维码图片
     
     // 创建一个颜色滤镜,黑白色
     let colorFilter = CIFilter(name: "CIFalseColor")!
     colorFilter.setDefaults()
     colorFilter.setValue(qrCIImage, forKey: "inputImage")
     colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
     colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
     // 返回二维码image
     let codeImage = UIImage(ciImage: (colorFilter.outputImage!.applying(CGAffineTransform(scaleX: 30, y: 30))))
     
     let context = CIContext(options: nil)
     let ciimg = qrCIImage?.applying(CGAffineTransform(scaleX: 30, y: 30))
     let cgimg = context.createCGImage(ciimg!, from: (ciimg?.extent)!)
     
     // 中间一般放logo
     if let iconImage = UIImage(named: qrImageName) {
     let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
     
     UIGraphicsBeginImageContext(rect.size)
     codeImage.draw(in: rect)
     let avatarSize = CGSize(width: rect.size.width*0.25, height: rect.size.height*0.25)
     
     let x = (rect.width - avatarSize.width) * 0.5
     let y = (rect.height - avatarSize.height) * 0.5
     iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
     
     let resultImage = UIGraphicsGetImageFromCurrentImageContext()
     
     UIGraphicsEndImageContext()
     return resultImage
     }
     
     //return codeImage
     return UIImage.init(cgImage: cgimg!)
     
     }
     return nil
     }
     */
    
}
