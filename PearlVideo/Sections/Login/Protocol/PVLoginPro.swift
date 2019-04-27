//
//  PVLoginPro.swift
//  yjkj-PV-ios
//
//  Created by equalriver on 2019/1/21.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController


//MARK: - action
extension PVLoginVC {
    
    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return 2
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["登录", "注册"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//登录
            let vc = PVPhoneLoginVC()
            return vc
        }
        if index == 1 {//注册
            let vc = PVRegisterVC()
            return vc
        }
       
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: 200 * KScreenRatio_containX, width: kScreenWidth, height: 40 * KScreenRatio_containX)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let h = kScreenHeight - 240 * KScreenRatio_containX
        
        return CGRect.init(x: 0, y: 240 * KScreenRatio_containX, width: kScreenWidth, height: h)
    }
    
    
    
}

