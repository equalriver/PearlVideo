//
//  AppDelegate.swift
//  PearlVideo
//
//  Created by equalriver on 2019/3/30.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit
import Kingfisher


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = PVTabBarController()
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        appSetup(options: launchOptions)
        //从远程通知打开app
        if let _ = launchOptions?[.remoteNotification] {
            resetBadge(application)
        }
        
        
        return true
    }
    
    private func resetBadge(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
        JPUSHService.resetBadge()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//        handleAPNs(info: userInfo)
//        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        handleAPNs(info: userInfo)
//        JPUSHService.handleRemoteNotification(userInfo)
//        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
//        resetBadge(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
//        resetBadge(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

