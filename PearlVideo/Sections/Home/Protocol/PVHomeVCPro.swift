//
//  PVHomeVCPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import ObjectMapper
import MJRefresh

extension PVHomeVC {
    
    @objc func messageAction() {
        view.makeToast("暂未开放")
//        let vc = PVHomeMessageVC()
//        navigationController?.pushViewController(vc, animated: true)
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
        PVNetworkTool.Request(router: .homePage(), success: { (resp) in
            if let d = Mapper<PVHomeModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                self.headerView.data = d
                self.reloadData()
            }
            
        }) { (e) in
            
        }
    }
    
    func checkVersion(handle: @escaping () -> Void) {
        guard let version = UserDefaults.standard.string(forKey: kAppVersionCode) else { return }
        
        PVNetworkTool.Request(router: .getVersion(), success: { (resp) in
            if let d = Mapper<PVVersionModel>().map(JSONObject: resp["result"].object) {
                if d.versionCode != version {
                    UserDefaults.standard.setValue("\(d.versionCode)", forKey: kAppVersionCode)
                    YPJOtherTool.ypj.showAlert(title: nil, message: "有新版本需要更新", style: .alert, isNeedCancel: false, handle: { (ac) in
                        guard let url = URL.init(string: d.downloadURL) else { return }
                        UIApplication.shared.openURL(url)
                    })
                }
                else {
                    handle()
                }
            }
            
        }) { (e) in
            
        }
    }
    
    //scroll view delegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView {
            recommendVC.collectionView.isScrollEnabled = scrollView.contentOffset.y >= headerViewHeight - safeInset
            attentionVC.collectionView.isScrollEnabled = scrollView.contentOffset.y >= headerViewHeight - safeInset
            msgBtn.isHidden = scrollView.contentOffset.y >= 200
        }
        else {
            super.scrollViewDidScroll(scrollView)
        }
    }
    
}

//MARK: - Recommend Delegate
extension PVHomeVC: PVHomeRecommendDelegate {
    
    func didBeginHeaderRefresh(sender: UIScrollView?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender?.mj_header.endRefreshing()
            self.contentScrollView.setContentOffset(CGPoint.init(x: 0, y: -20), animated: true)
        }
        
    }
    
}

//MARK: - attention Delegate
extension PVHomeVC: PVHomeAttentionDelegate {
    
    func didBeginAttentionHeaderRefresh(sender: UIScrollView?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender?.mj_header.endRefreshing()
            self.contentScrollView.setContentOffset(CGPoint.init(x: 0, y: -20), animated: true)
        }
        
    }
    
}

//MARK: page controller delegate
extension PVHomeVC {
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return items[index]
    }
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return items.count
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 { return recommendVC }
        if index == 1 { return attentionVC }
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: headerViewHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let h = kScreenHeight - kTabBarHeight - 50 * KScreenRatio_6 - safeInset
        return CGRect.init(x: 0, y: 50 * KScreenRatio_6 + headerViewHeight, width: kScreenWidth, height: h)
    }
    
}

//MARK: - header view delegate
extension PVHomeVC: PVHomeHeaderDelegate {
    
    func didSelectedBanner(index: Int) {
        guard data.bannerList.count > index else { return }
        let url = data.bannerList[index].url
        let vc = PVAgreementWebVC.init(url: url, title: data.bannerList[index].title)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectedTitlesItem(index: Int) {
        view.makeToast("暂未开放")
//        switch index {
//        case 0: //会员等级
//            let vc = PVHomeUserLevelVC()
//            navigationController?.pushViewController(vc, animated: true)
//            break
//
//        case 1: //活跃度
//            let vc = PVHomeActivenessVC()
//            navigationController?.pushViewController(vc, animated: true)
//            break
//
//        case 2: //总平安果
//            let vc = PVHomeFruitVC()
//            navigationController?.pushViewController(vc, animated: true)
//            break
//
//        case 3: //当前收益
//
//            break
//
//        default:
//            break
//        }
    }
    
    func didSelectedActionItem(index: Int) {
        switch index {
        case 0: //任务
            view.makeToast("暂未开放")
//            let vc = PVHomeTaskVC()
//            navigationController?.pushViewController(vc, animated: true)
            break
            
        case 1: //资讯
            view.makeToast("暂未开放")
            break
            
        case 2: //团队
            let vc = PVHomeMyTeamVC()
            navigationController?.pushViewController(vc, animated: true)
            break
            
        case 3: //商学院
            view.makeToast("暂未开放")
//            let vc = PVHomeSchoolVC()
//            navigationController?.pushViewController(vc, animated: true)
            break
            
        default:
            break
        }
    }
    
}

