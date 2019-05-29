//
//  PVMePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import MJRefresh
import ObjectMapper

//MARK: - actions
extension PVMeViewController {
    
    //setting
    override func rightButtonsAction(sender: UIButton) {
        let vc = PVMeSettingVC()
        navigationController?.pushViewController(vc, animated: true)
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
        PVNetworkTool.Request(router: .userInfo(userId: UserDefaults.standard.string(forKey: kUserId) ?? "", page: 0), success: { (resp) in
            if let d = Mapper<PVMeModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                self.headerView.data = d
                self.updateMenuItemAttributeText(index: Int(self.selectIndex))
            }
            
        }) { (e) in
            
        }
    }
    
    func updateMenuItemAttributeText(index: Int) {
        var color_0 = UIColor.white
        var color_1 = UIColor.white
        var color_2 = UIColor.white
        var color_00 = kColor_border!
        var color_11 = kColor_border!
        var color_22 = kColor_border!
        if index == 0 {
            color_0 = kColor_pink!
            color_00 = kColor_pink!
        }
        if index == 1 {
            color_1 = kColor_pink!
            color_11 = kColor_pink!
        }
        if index == 2 {
            color_2 = kColor_pink!
            color_22 = kColor_pink!
        }
        
        let att_1 = NSMutableAttributedString.init(string: "\(data.videoTotal)\n" + "作品")
        att_1.addAttributes([.font: kFont_btn_weight, .foregroundColor: color_0], range: NSMakeRange(0, "\(data.videoTotal)".count))
        att_1.addAttributes([.font: kFont_text_2, .foregroundColor: color_00], range: NSMakeRange("\(data.videoTotal)".count, 3))
        updateAttributeTitle(att_1, at: 0)
        
        let att_2 = NSMutableAttributedString.init(string: "\(data.likeTotal)\n" + "喜欢")
        att_2.addAttributes([.font: kFont_btn_weight, .foregroundColor: color_1], range: NSMakeRange(0, "\(data.likeTotal)".count))
        att_2.addAttributes([.font: kFont_text_2, .foregroundColor: color_11], range: NSMakeRange("\(data.likeTotal)".count, 3))
        updateAttributeTitle(att_2, at: 1)
        
        let att_3 = NSMutableAttributedString.init(string: "\(data.privacyCount)\n" + "私密")
        att_3.addAttributes([.font: kFont_btn_weight, .foregroundColor: color_2], range: NSMakeRange(0, "\(data.privacyCount)".count))
        att_3.addAttributes([.font: kFont_text_2, .foregroundColor: color_22], range: NSMakeRange("\(data.privacyCount)".count, 3))
        updateAttributeTitle(att_3, at: 2)
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
    //编辑or登录
    func didSelectedEdit() {
        if YPJOtherTool.ypj.loginValidate(currentVC: self, isLogin: nil) {
            let vc = PVMeUserinfoEditVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    //会员等级
    func didSelectedLevel() {
        let vc = PVHomeUserLevelVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    //活跃度
    func didSelectedActiveness() {
        let vc = PVHomeActivenessVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    //平安果
    func didSelectedFruit() {
        let vc = PVHomeFruitVC()
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - 作品, 喜欢, 私密
extension PVMeViewController: PVMeProductionDelegate, PVMeLikeDelegate, PVMeSecureDelegate {
    
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
            return likeVC
        }
        if index == 2 {//私密
            return secureVC
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

    override func pageController(_ pageController: WMPageController, didEnter viewController: UIViewController, withInfo info: [AnyHashable : Any]) {
        guard let index = info["index"] as? Int else { return }
        
        updateMenuItemAttributeText(index: index)

    }
}
