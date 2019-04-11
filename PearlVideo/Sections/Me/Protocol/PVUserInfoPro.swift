//
//  PVUserInfoPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - actions
extension PVUserInfoVC {
    
    override func rightButtonsAction(sender: UIButton) {
        //分享
        if sender == shareBtn {
            
            return
        }
    }
    
    func loadData() {
        
    }
}



//MARK: - HeaderViewDelegate
extension PVUserInfoVC: PVUserInfoViewDelegate {
    
    func didSelectedAttention() {
        
    }
    
}


//MARK: - page controller delegate
extension PVUserInfoVC: PVMeProductionDelegate {
    
    func listViewShow(isShow: Bool) {
        isShowMoreList = isShow
    }
    
}


//MARK: - page controller delegate
extension PVUserInfoVC {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return 2
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["作品", "喜欢"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//作品
            let vc = PVMeProductionVC()
            vc.delegate = self
            return vc
        }
        if index == 1 {//喜欢
            let vc = PVMeLikeVC()
            vc.delegate = self
            return vc
        }
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        var y = isShowMoreList ? 0 : 330 * KScreenRatio_containX
        y += kNavigationBarAndStatusHeight + 20
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: 40 * KScreenRatio_containX)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        var y = isShowMoreList ? 0 : 330 * KScreenRatio_containX
        y += kNavigationBarAndStatusHeight + 20 + 40 * KScreenRatio_6
        let h = kScreenHeight - y - kTabBarHeight
        
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: h)
    }
    
}
