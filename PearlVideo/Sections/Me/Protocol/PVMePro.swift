//
//  PVMePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - actions
extension PVMeViewController {
    
    override func leftButtonsAction(sender: UIButton) {
        //setting
        
    }
    
    override func rightButtonsAction(sender: UIButton) {
        //消息
        if sender == messageBtn {
            
            return
        }
        //分享
        if sender == shareBtn {
            
            return
        }
    }
    
    func loadData() {
        
    }
}



//MARK: - PVMeHeaderViewDelegate
extension PVMeViewController: PVMeHeaderViewDelegate {
    //我的邀请码
    func didSelectedInvitation() {
        
    }
    
    //团队
    func didSelectedTeam() {
        
    }
    
    //编辑
    func didSelectedEdit() {
        
    }

}


//MARK: - page controller delegate
extension PVMeViewController: PVMeProductionDelegate {
    
    func listViewShow(isShow: Bool) {
        isShowMoreList = isShow
    }

}


//MARK: - page controller delegate
extension PVMeViewController {
    
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
        var y = isShowMoreList ? 0 : headerViewHeight
        y += kNavigationBarAndStatusHeight
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: 40 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        var y = isShowMoreList ? 0 : headerViewHeight
        y += kNavigationBarAndStatusHeight + 40 * KScreenRatio_6
        let h = kScreenHeight - y - kTabBarHeight
        
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: h)
    }
    
}
