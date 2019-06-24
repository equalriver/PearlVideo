//
//  KeysMacro.swift


import Foundation

///登录用户token
public let kToken = "kToken"

///user id
public let kUserId = "kUserId"

///app id
public let kAPPID = "1466058668"

///获取app version url  k: ["results"][0]["version"]
public let kAppVersionURL = "http://itunes.apple.com/lookup?id=\(kAPPID)"

//app version
public let kAppVersion = "PV_app_version"
public let kAppUpdateVersionValue = "5" //FIX: 打包更新时修改

///上一次输入的IP
public let kLastInputIP = "kLastInputIP"

///上一次输入的帐号
public let kLastInputAccount = "kLastInputAccount"

///客户数据路径
public let kClientDataFilePath = NSHomeDirectory() + "/Documents/xxxx.plist"

///用户位置
public let kUserLocation = "kUserLocation"




///base url
public let kBaseURLString = "http://192.168.0.136:8088/api/"
//public let kBaseURLString = "http://192.168.2.11:8088/api/"
//public let kBaseURLString = "http://www.lzmingsi.com:8080/api/"
//public let kBaseURLString = "https://yjhfuyin.lzmingsi.com/api/"

///用户协议
public let kUserAgreementURL = "http://www.lzmingsi.com/?formal=%e7%94%a8%e6%88%b7%e5%8d%8f%e8%ae%ae"

///隐私政策
public let kSecureURL = "http://www.lzmingsi.com/?formal=%e9%9a%90%e7%a7%81%e6%94%bf%e7%ad%96"

///认证协议
public let kValidateURL = "http://www.lzmingsi.com/?formal=%e7%a6%8f%e9%9f%b3app%e8%ae%a4%e8%af%81%e6%8a%80%e6%9c%af%e6%9c%8d%e5%8a%a1%e5%8d%8f%e8%ae%ae"

///社区管理
public let kCommunityURL = "http://www.lzmingsi.com/?formal=%e7%a4%be%e5%8c%ba%e7%ae%a1%e7%90%86%e8%a7%84%e5%ae%9a"





//AES
public let kInitVector = "16-Bytes--String"
public let kAES_KEY = "kPVPsd"

//3DES
public let k3DES_KEY = "fuyin"
public let k3DES_iv = "01234567"

///key chain service
public let kKeyChainService = "com.lzmingsi.PearlVideo.keyChainService"





//点播STS
public let kAccessKeyId = "kAccessKeyId"
public let kAccessKeySecret = "kAccessKeySecret"
public let kSecurityToken = "kSecurityToken"

//微信
public let kWeixinAppId = "wxe29565366a03f638"

//支付宝
public let kAlipayScheme = "2019052365384112"







//MARK: - noti
extension Notification.Name {
    
    //
    ///主题颜色变化
    public static let kNotiName_themeColorChange = Notification.Name.init("kNotiName_themeColorChange")
    
    ///token过期刷新页面
    public static let kNotiName_pageRefreshByToken = Notification.Name.init("kNotiName_pageRefreshByToken")
    
    ///实名认证成功
    public static let kNotiName_userValidateSuccess = Notification.Name.init("kNotiName_userValidateSuccess")
    
    ///alipay支付成功
    public static let kNotiName_alipaySuccess = Notification.Name.init("kNotiName_alipaySuccess")
    
    
    
    //home
    ///刷新"我的任务"
    public static let kNotiName_refreshMyTask = Notification.Name.init("kNotiName_refreshMyTask")
    
    ///刷新“关注视频”
    public static let kNotiName_refreshAttention = Notification.Name.init("kNotiName_refreshAttention")
    
    
    
    //交换中心
    ///刷新"交换记录--买单"
    public static let kNotiName_refreshRecordBuy = Notification.Name.init("kNotiName_refreshRecordBuy")
    
    ///刷新"交换记录--卖单"
    public static let kNotiName_refreshRecordSell = Notification.Name.init("kNotiName_refreshRecordSell")
    
    ///刷新"交换记录--交换中"
    public static let kNotiName_refreshRecordExchanging = Notification.Name.init("kNotiName_refreshRecordExchanging")
    
    
    
    //me
    ///刷新“我的”页面
    public static let kNotiName_refreshMeVC = Notification.Name.init("kNotiName_refreshMeVC")
    
    ///刷新“我的作品”
    public static let kNotiName_refreshMeProductionVC = Notification.Name.init("kNotiName_refreshMeProductionVC")

    ///刷新“我的喜欢”
    public static let kNotiName_refreshMeLikeVC = Notification.Name.init("kNotiName_refreshMeLikeVC")
    
    ///刷新“我的私密”
    public static let kNotiName_refreshMeSecrityVC = Notification.Name.init("kNotiName_refreshMeSecrityVC")
    
}
