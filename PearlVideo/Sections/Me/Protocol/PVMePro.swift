//
//  PVMePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import MJRefresh

//MARK: - actions
extension PVMeViewController {
    
    override func rightButtonsAction(sender: UIButton) {
        UserDefaults.standard.set(nil, forKey: kToken)
        UserDefaults.standard.synchronize()
        YPJOtherTool.ypj.loginValidate(currentVC: self, isLogin: nil)
    }
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: contentScrollView) {[weak self] in
            self?.loadData()
        }
        if let header = contentScrollView.mj_header as? MJRefreshNormalHeader {
            header.arrowView.image = nil
        }
    }
    
    func loadData() {
        
    }
    
    //noti
    @objc func refreshNotification() {
        loadData()
    }
    
    //scroll view delegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        if scrollView == contentScrollView {
            productionVC.collectionView.isScrollEnabled = scrollView.contentOffset.y >= headerViewHeight - kNavigationBarAndStatusHeight - safeInset
            let alpha: CGFloat = scrollView.contentOffset.y >= headerViewHeight - kNavigationBarAndStatusHeight ? 1.0 : scrollView.contentOffset.y / (headerViewHeight - kNavigationBarAndStatusHeight)
            effectView.alpha = alpha
            naviBar.titleView.alpha = alpha
        }
        else {

        }
       
    }
 
    
    
}

//MARK: - PVMeHeaderViewDelegate
extension PVMeViewController: PVMeHeaderViewDelegate {
    
    func didSelectedEdit() {
        
    }

}

//MARK: - 作品
extension PVMeViewController: PVMeProductionDelegate {
    
    func didBeginHeaderRefresh(sender: UIScrollView?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender?.mj_header.endRefreshing()
            self.effectView.alpha = 0
            self.naviBar.titleView.alpha = 0
            self.contentScrollView.setContentOffset(CGPoint.init(x: 0, y: -20), animated: true)
        }
    }
    
}


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
            return productionVC
        }
        if index == 1 {//喜欢
            
        }
        if index == 2 {//私密
            
        }
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: headerViewHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let h = kScreenHeight - kTabBarHeight - 50 * KScreenRatio_6 - kNavigationBarAndStatusHeight - safeInset
        return CGRect.init(x: 0, y: headerViewHeight + 50 * KScreenRatio_6, width: kScreenWidth, height: h)
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
