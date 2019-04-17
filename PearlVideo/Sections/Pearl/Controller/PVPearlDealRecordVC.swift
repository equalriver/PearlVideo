//
//  PVPearlDealRecordVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/15.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVPearlDealRecordVC: PVBaseWMPageVC {
    
    let items = ["买单", "卖单", "交易中", "交易完成"]
    
    override func viewDidLoad() {
        titleColorNormal = kColor_text!
        titleColorSelected = kColor_pink!
        menuViewStyle = .line
        super.viewDidLoad()
    }
    
}

extension PVPearlDealRecordVC {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return items.count
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {
            let vc = PVPearlDealRecordBuyVC()
            return vc
        }
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight, width: kScreenWidth, height: 40 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight + 40 * KScreenRatio_6, width: kScreenWidth, height: kScreenHeight - kNavigationBarAndStatusHeight - 40 * KScreenRatio_6)
    }
    
}
