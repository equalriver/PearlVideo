//
//  KeysMacro.swift


import Foundation


///客户数据路径
public let kClientDataFilePath = NSHomeDirectory() + "/Documents/xxxx.plist"

///上一次输入的IP
public let kLastInputIP = "kLastInputIP"

///上一次输入的帐号
public let kLastInputAccount = "kLastInputAccount"

///base url
public let kBaseURLString = UserDefaults.standard.string(forKey: kLocalIP) ?? "http://192.168.0.137:8080/api/"

///local text ip
public let kLocalIP = "kLocalIP"

///获取app version url  k: ["results"][0]["version"]
public let kAppVersionURL = "http://itunes.apple.com/lookup?id=你的AppStoreid"


//js handler
public let kPVAppJSName_none = ""
public let kPVMsgJSName_none = ""


///极光推送 key
public let kJPushKey = ""

///key chain service
public let kKeyChainService = "com.lzmingsi.PearlVideo.keyChainService"


//AES
public let kInitVector = "16-Bytes--String"
public let kAES_KEY = "kPVPsd"


//MARK: - noti
extension Notification.Name {
    
    ///主题颜色变化
    public static let kNotiName_themeColorChange = Notification.Name.init("kNotiName_themeColorChange")
    
    ///token过期刷新页面
    public static let kNotiName_pageRefreshByToken = Notification.Name.init("kNotiName_pageRefreshByToken")
    
    
    
    
    
    
    

}
