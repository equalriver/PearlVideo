//
//  PVHomeVCPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import ObjectMapper

extension PVHomeVC {
    
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
    
    @objc func headerViewPanAction(pan: UIPanGestureRecognizer) {
        guard let panView = pan.view else { return }
        if panView == headerView {
            let velocity_1 = pan.velocity(in: headerView.titlesCV)
            let velocity_2 = pan.velocity(in: headerView.actionItemsCV)
            
            if velocity_1.y / 1000 > 1 || velocity_2.y / 1000 > 1 {
                isShowMoreList = false
            }
            if velocity_1.y / 1000 < -1 || velocity_2.y / 1000 < -1 {
                isShowMoreList = true
            }
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
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        let y = isShowMoreList ? 0 : headerViewHeight
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        var y = isShowMoreList ? 0 : headerViewHeight
        y += 50 * KScreenRatio_6
        let h = kScreenHeight - y - kTabBarHeight
        
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: h)
    }
    
}

//MARK: - header view delegate
extension PVHomeVC: PVHomeHeaderDelegate {
    
    func didSelectedMessage() {
        
    }
    
    func didSelectedBanner(index: Int) {
        
    }
    
    func didSelectedTitlesItem(index: Int) {
        switch index {
        case 0: //会员等级
            let vc = PVHomeUserLevelVC()
            navigationController?.pushViewController(vc, animated: true)
            break
            
        case 1: //活跃度
            let vc = PVHomeActivenessVC()
            navigationController?.pushViewController(vc, animated: true)
            break
            
        case 2: //总平安果
            let vc = PVHomeFruitVC()
            navigationController?.pushViewController(vc, animated: true)
            break
            
        case 3: //当前收益
            
            break
            
        default:
            break
        }
    }
    
    func didSelectedActionItem(index: Int) {
        switch index {
        case 0: //任务
            
            break
            
        case 1: //组队
            
            break
            
        case 2: //团队
            let vc = PVHomeMyTeamVC()
            navigationController?.pushViewController(vc, animated: true)
            break
            
        case 3: //商学院
            let vc = PVHomeSchoolVC()
            navigationController?.pushViewController(vc, animated: true)
            break
            
        default:
            break
        }
    }
    
}

//MARK: - Recommend delegate
extension PVHomeVC: PVHomeRecommendDelegate {
    
    func listViewShow(isShow: Bool) {
        isShowMoreList = isShow
    }
    
}
