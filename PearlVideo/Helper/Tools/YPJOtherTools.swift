//
//  YPJOtherTools.swift


import Foundation
import SVProgressHUD
import CFNetwork
import LocalAuthentication
import CommonCrypto
import Photos
import Security

struct YPJOtherTool {
    
    public static let ypj: YPJOtherTool = {
        return YPJOtherTool.init()
    }()
}

//MARK: -
extension YPJOtherTool {
    
    //MARK: - 获取key chain中的uuid
    ///获取key chain中的uuid
    func getUUIDWithkeyChain() -> String {
        guard let uid = YYKeychain.getPasswordForService(kKeyChainService, account: "uuid") else {
            let uuid = UUID.init().uuidString
            let isSuccess = YYKeychain.setPassword(uuid, forService: kKeyChainService, account: "uuid")
            if isSuccess == false { print("*********** 设置uuid失败 **********") }
            return uuid
        }
        return uid
    }
    
    
    //MARK: - 获取文件夹大小(返回M)
    ///获取文件夹大小(返回M)
    func getLocalFolderSize(path: String) -> Double {
        let isContainFile = FileManager.default.fileExists(atPath: path)
        if isContainFile == false { return 0 }
        guard let subPaths = FileManager.default.subpaths(atPath: path) else { return 0}
        var size: Double = 0
        for v in subPaths {
            let fileAbsolutePath = path + "/" + v
            if FileManager.default.fileExists(atPath: fileAbsolutePath) {
                guard let dic = try? FileManager.default.attributesOfItem(atPath: fileAbsolutePath) else { continue }
                guard let s = dic[.size] as? Double else { continue }
                size += s
            }
        }
        return size / (1024.0 * 1024.0)
    }
    
    //MARK: - 清除缓存
    ///清除缓存
    func removeCache() {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        let isContainFile = FileManager.default.fileExists(atPath: path)
        if isContainFile == false { return }
        guard let files = FileManager.default.subpaths(atPath: path) else { return }
        
        for v in files {
            let fileAbsolutePath = path + "/" + v
            if FileManager.default.fileExists(atPath: fileAbsolutePath) {
                do { try FileManager.default.removeItem(atPath: fileAbsolutePath) }
                catch { print("清除缓存错误: ", error.localizedDescription) }
            }
        }
    }
  
    //MARK: - 3DES的加密过程 和 解密过程
    /**
     3DES的加密过程 和 解密过程
     
     - parameter op : CCOperation： 加密还是解密
     CCOperation（kCCEncrypt）加密
     CCOperation（kCCDecrypt) 解密
     
     - parameter key: 加解密key
     - parameter iv : 可选的初始化向量，可以为nil
     - returns      : 返回加密或解密的参数
     */
    func tripleDESEncryptOrDecrypt(content: String, op: CCOperation, key: String, iv: String?) -> String? {
        // Key
        guard let keyData = key.data(using: String.Encoding.utf8, allowLossyConversion: true) else { return nil }
        let keyBytes = (keyData as NSData).bytes
        
        var data: NSData!
        if op == CCOperation(kCCEncrypt) {//加密内容
            data = content.data(using: String.Encoding.utf8, allowLossyConversion: true) as NSData?
        }
        else {//解密内容
            data =  NSData(base64Encoded: content, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        }
        
        let dataLength    = size_t(data.length)
        let dataBytes     = UnsafeMutableRawPointer(mutating: data.bytes)
        
        // 返回数据
        let cryptData    = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)
        let cryptPointer = UnsafeMutableRawPointer(mutating: cryptData?.bytes)
        let cryptLength  = size_t(cryptData!.length)
        
        //  可选的初始化向量
        let viData: NSData? = iv?.data(using: String.Encoding.utf8, allowLossyConversion: true) as NSData?
        let viDataBytes: UnsafeMutableRawPointer? = UnsafeMutableRawPointer(mutating: viData?.bytes)
        
        // 特定的几个参数
        let keyLength              = size_t(kCCKeySize3DES)
        let operation: CCOperation = UInt32(op)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding | kCCOptionECBMode)
        
        var numBytesCrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation, // 加密还是解密
            algoritm, // 算法类型
            options,  // 密码块的设置选项
            keyBytes, // 秘钥的字节
            keyLength, // 秘钥的长度
            viDataBytes, // 可选初始化向量的字节
            dataBytes, // 加解密内容的字节
            dataLength, // 加解密内容的长度
            cryptPointer, // output data buffer
            cryptLength,  // output data length available
            &numBytesCrypted) // real output data length
        
        if cryptStatus == kCCSuccess {
            
            cryptData!.length = Int(numBytesCrypted)
            if op == CCOperation(kCCEncrypt)  {
                let base64cryptString = cryptData?.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
                free(cryptPointer)
                return base64cryptString
            }
            else {
                let base64cryptString = String.init(data: cryptData! as Data, encoding: .utf8)
                free(cryptPointer)
                return base64cryptString
            }
        } else {
            free(cryptPointer)
            print("Error: \(cryptStatus)")
        }
        return nil
    }
    
    //MARK: - AES128加密
    ///AES128加密
    func aes128cbcEncrypt(content: String) -> String? {
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
        
        let cryptStatus = CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(kCCKeySizeAES128), CCOptions(kCCOptionPKCS7Padding), key, kCCKeySizeAES128, iv, dataIn, dataLength, dataOut, dataOutAvailable, &dataOutMoved)
        
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
                    showAlert(title: "未设置密码", message: "请到“系统设置”设置密码或指纹", style: .alert, isNeedCancel: false, handle: nil)
                }
            }
        }
        
    }
    
    //MARK: - alert controller
    ///alert
    func showAlert(title: String?, message: String?, style: UIAlertController.Style, isNeedCancel: Bool, handle: ((_ : UIAlertAction) -> Void)?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: style)
        
        let ac = UIAlertAction.init(title: "确定", style: .default) { (act) in
            DispatchQueue.main.async {
                handle?(act)
            }
        }
        
        let cancel = UIAlertAction.init(title: isNeedCancel == true ? "取消" : "好", style: .cancel) { (act) in
            if isNeedCancel == false {
                DispatchQueue.main.async {
                    handle?(act)
                }
            }
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
    @discardableResult
    public func loginValidate(currentVC: UIViewController, isLogin: ((_ isLogin: Bool) -> Void)?) -> Bool {
        
        switch YYReachability.init().status {
        case .none:
            SVProgressHUD.showInfo(withStatus: "咦～竟然没有检测到网络")
            return false
        default:
            break
        }
        guard UserDefaults.standard.string(forKey: kToken) != nil else {
            let lvc = PVLoginVC()
            lvc.loginCallback = isLogin
            let vc = PVBaseRootNaviVC.init(rootViewController: lvc)
            currentVC.present(vc, animated: true, completion: nil)
            isLogin?(false)
            return false
        }
        isLogin?(true)
        return true
    }
    
    /*
     //MARK: - 崩溃日志
     ///崩溃日志上传
     public func uploadCrashLogFile() {
     
     let path = NSHomeDirectory() + "/Documents/error.txt"
     guard let token = UserDefaults.standard.string(forKey: kToken) else { return }
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
        let alert = UIAlertController.init(title: nil, message: "app需要获取“\(type)”权限,点击确定跳转设置页面", preferredStyle: .alert)
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
        case .authorized:
            auth()
            break
            
        default:
            PHPhotoLibrary.requestAuthorization { (s) in
                DispatchQueue.main.async {
                    switch s {
                    case .authorized, .notDetermined:
                        auth()
                        break
                        
                    default:
                        self.gotoAuthorizationView(type: "相册", vc: target)
                        break
                    }
                }
            }
        }
        
    }
    
    //MARK: - 获取摄像头权限
    ///获取摄像头权限
    func getCameraAuth(target: UIViewController, _ auth: @escaping () -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .authorized:
            DispatchQueue.main.async { auth() }
            break
            
        default:
            AVCaptureDevice.requestAccess(for: .video) { (isGranted) in
                DispatchQueue.main.async {
                    if isGranted {
                        auth()
                    }
                    else {
                        self.gotoAuthorizationView(type: "摄像头", vc: target)
                    }
                }
                
            }
            break
        }
    }
    
    //MARK: - 获取定位权限
    ///获取定位权限
    func getLocationAuth(target: UIViewController, manager: CLLocationManager) {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
            
        case .denied, .restricted:
            self.gotoAuthorizationView(type: "位置", vc: target)
            break

        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        }
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
    var isAPPFirstLauch: Bool {
        //获取当前版本号
        guard let infoDic = Bundle.main.infoDictionary else { return false }
        guard let currentVersion: String = infoDic["CFBundleShortVersionString"] as? String else { return false }
        
        let version = UserDefaults.standard.string(forKey: kAppVersion) ?? ""
        
        if version == "" || version != currentVersion {
            UserDefaults.standard.set(currentVersion, forKey: kAppVersion)
            UserDefaults.standard.synchronize()
            return true
        }
        
        return false
    }
    
    //MARK: - 获取当前版本号
    ///获取当前版本号
    var getCurrentVersion: String? {
        
        guard let infoDic = Bundle.main.infoDictionary else { return nil }
        let currentVersion = infoDic["CFBundleShortVersionString"] as? String
        
        return currentVersion
    }
    
}
