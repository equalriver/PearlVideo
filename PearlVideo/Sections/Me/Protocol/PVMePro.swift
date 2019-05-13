//
//  PVMePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController

//MARK: - actions
extension PVMeViewController {
    
    func loadData() {
        
    }
    
    @objc func headerViewPanAction(pan: UIPanGestureRecognizer) {
        guard let panView = pan.view else { return }
        if panView == headerView {
            let velocity_1 = pan.velocity(in: headerView.titlesCV)
            let velocity_2 = pan.velocity(in: headerView.titlesCV)
            
            if velocity_1.y / 1000 > 1 || velocity_2.y / 1000 > 1 {
                isShowMoreList = false
            }
            if velocity_1.y / 1000 < -1 || velocity_2.y / 1000 < -1 {
                isShowMoreList = true
            }
        }
    }
    
    func loginValidate() {
        guard let _ = UserDefaults.standard.value(forKey: kToken) else {
            YPJOtherTool.ypj.loginValidate(currentVC: self) { (isFinish) in
                if isFinish { self.loadData() }
            }
            return
        }
    }
    
    //noti
    @objc func refreshNotification() {
        loadData()
    }
    
}



//MARK: - PVMeHeaderViewDelegate
extension PVMeViewController: PVMeHeaderViewDelegate {
    
    func didSelectedEdit() {
        
    }
    
    func didSelectedSetting() {
        
    }

}

//MARK: - Recommend delegate
//extension PVHomeVC: PVHomeRecommendDelegate {
//
//    func listViewShow(isShow: Bool) {
//        isShowMoreList = isShow
//    }
//
//}

//MARK: - page controller delegate
extension PVMeViewController {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return 3
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["作品", "喜欢", "私密"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//作品
            
        }
        if index == 1 {//喜欢
            
        }
        if index == 2 {//私密
            
        }
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        var y = isShowMoreList ? 0 : headerViewHeight
        y += kNavigationBarAndStatusHeight
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        var y = isShowMoreList ? 0 : headerViewHeight
        y += 50 * KScreenRatio_6
        let h = kScreenHeight - y - kTabBarHeight
        
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: h)
    }
    
    override func menuView(_ menu: WMMenuView!, initialMenuItem: WMMenuItem!, at index: Int) -> WMMenuItem! {
//        initialMenuItem.attributedText = ""
        return initialMenuItem
    }

    override func pageController(_ pageController: WMPageController, didEnter viewController: UIViewController, withInfo info: [AnyHashable : Any]) {
        guard let index = info["index"] as? Int else { return }
//        let att_0 = NSMutableAttributedString.init()
        
        switch index {
        case 0: //作品
//            att_0.addAttributes([NSAttributedString.Key.font: kFont_btn_weight, .foregroundColor: kColor_pink!], range: NSMakeRange(0, 0))
//            att_0.addAttributes([NSAttributedString.Key.font: kFont_text_3, .foregroundColor: kColor_pink!], range: NSMakeRange(0, 0))
            break
            
        case 1: //喜欢
            
            break
            
        case 2: //私密
            
            break
            
        default:
            break
        }
//        updateAttributeTitle(att_0, at: 0)
    }
}
