//
//  AppDelegateEx.swift


import Foundation
import Toast_Swift
import IQKeyboardManagerSwift
import SVProgressHUD
import UserNotifications


extension AppDelegate: WXApiDelegate {
    
    public func appSetup(options: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        
        libSetup(options: options)
        setupAppearance()
        
        
        
    }
    
    public func handleAPNs(info: [AnyHashable : Any]) {
        //取得 APNs 标准信息内容
        if let aps = info["aps"] as? [AnyHashable : Any] {
            //推送显示的内容
            if let _ = aps["alert"] as? String {
//                if content.contains("") { NotificationCenter.default.post(name: .kNotiUserShouldRefreshData, object: nil) }
            }
    
        }
    }
    
    private func libSetup(options: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        
        var isProduction = true
        
        #if DEBUG
        isProduction = false
        #else
        isProduction = true
//        JMessage.setLogOFF()
        #endif
        
        //weixin
        WXApi.registerApp(kWeixinAppId)
        
        //实人认证
//        RPSDK.initialize(RPSDKEnv.online)
        
        //toast
        ToastManager.shared.position = .center
        var style = ToastStyle.init()
        style.backgroundColor = UIColor.white
        style.titleColor = UIColor.black
        style.messageColor = UIColor.black
        ToastManager.shared.style = style
        
        //keyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        //SVProgressHUD
        SVProgressHUD.setMaximumDismissTimeInterval(2)
        
   
       
        /*
        //JPush
        let entity = JPUSHRegisterEntity.init()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue)
        
        JPUSHService.setup(withOption: options, appKey: kJPushKey, channel: nil, apsForProduction: isProduction)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        //获取JPush服务器推送
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidReceiveMessage(noti:)), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
        */
     
    }
    
    private func setupAppearance() {
        
        UILabel.appearance().backgroundColor = .white
        UITextField.appearance().tintColor = kColor_subText
        UITextField.appearance().clearButtonMode = .whileEditing
        
        //patternImage导致第三方输入法崩溃
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12 * KScreenRatio_6), .foregroundColor: UIColor.init(patternImage: UIImage.init(named: "gradient_bg")!)], for: UIControl.State.selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12 * KScreenRatio_6),
                                                          .foregroundColor: kColor_border!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12 * KScreenRatio_6),
                                                          .foregroundColor: kColor_border!], for: .selected)
        
        
    }
    
    //处理JPush服务器推送
    @objc private func networkDidReceiveMessage(noti: Notification) {
        
        guard let info = noti.userInfo else { return }
        print(info)
        
    }
    
    private func localizeNotification() {
        let setting = UIUserNotificationSettings.init(types: [UIUserNotificationType.alert, UIUserNotificationType.sound, UIUserNotificationType.badge], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(setting)
    }
    
    //微信delegate
    func onResp(_ resp: BaseResp) {
        
    }
    
}

//MARK: - JPUSHRegisterDelegate
//extension AppDelegate: JPUSHRegisterDelegate {
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
//        let info = notification.request.content.userInfo
//        if let trigger = notification.request.trigger {
//            if trigger.isKind(of: UNPushNotificationTrigger.self) {
//                JPUSHService.handleRemoteNotification(info)
//                handleAPNs(info: info)
//            }
//        }
//        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
//    }
//
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
//        let info = response.notification.request.content.userInfo
//        if let trigger = response.notification.request.trigger {
//            if trigger.isKind(of: UNPushNotificationTrigger.self) {
//                JPUSHService.handleRemoteNotification(info)
//                handleAPNs(info: info)
//            }
//        }
//        completionHandler()
//    }
//
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
//
//    }
//}

