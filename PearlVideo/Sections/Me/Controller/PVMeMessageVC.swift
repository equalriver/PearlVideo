//
//  PVMeMessageVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeMessageVC: PVBaseWMPageVC {
    
    let items = ["通知", "评论", "点赞", "关注"]

    override func viewDidLoad() {
        super.viewDidLoad()
        isNeedBackButton = false
        title = "消息"
        view.backgroundColor = UIColor.white
        titleColorNormal = kColor_text!
        titleColorSelected = kColor_pink!
        titleSizeNormal = 16 * KScreenRatio_6
        titleSizeSelected = 18 * KScreenRatio_6
        menuViewStyle = .line
        
        
    }
    
}


//MARK: - page controller delegate
extension PVMeMessageVC {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return items.count
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return items[index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//通知
            
        }
        if index == 1 {//评论
           
        }
        if index == 2 {//点赞
            
        }
        if index == 3 {//关注
            
        }
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight, width: kScreenWidth, height: 60 * KScreenRatio_containX)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let h = kScreenHeight - kNavigationBarAndStatusHeight - 60 * KScreenRatio_6
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight + 60 * KScreenRatio_6, width: kScreenWidth, height: h)
    }
    
}
