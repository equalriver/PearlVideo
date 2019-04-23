//
//  PVMeTeamVCPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/8.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController


//MARK: - actions
extension PVMeTeamVC {
    
    @objc func popAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func meRecommend(sender: UIButton) {
        sender.isSelected = true
        friendRecommendBtn.isSelected = false
        selectIndex = 0
    }
    
    @objc func friendRecommend(sender: UIButton) {
        sender.isSelected = true
        meRecommendBtn.isSelected = false
        selectIndex = 1
    }
    
}

//MARK: - page controller delegate
extension PVMeTeamVC {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return 3
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["我推荐的", "好友推荐", "已认证"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//我推荐的
            let vc = PVMeTeamMeCommendVC()
            return vc
        }
        if index == 1 {//好友推荐
            let vc = PVMeTeamFriendCommendVC()
            return vc
        }
        if index == 2 {//认证
            let vc = PVMeTeamAuthVC()
            return vc
        }
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: 200 * KScreenRatio_6, width: kScreenWidth, height: 40 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let h = kScreenHeight - 240 * KScreenRatio_6
        return CGRect.init(x: 0, y: 240 * KScreenRatio_6, width: kScreenWidth, height: h)
    }
    
    override func menuView(_ menu: WMMenuView!, shouldSelesctedIndex index: Int) -> Bool {
        if index == 2 {//认证 popover
            let vc = PVMeTeamAuthPopoverVC()
            vc.delegate = self
            vc.preferredContentSize = CGSize.init(width: 110 * KScreenRatio_6, height: 60 * KScreenRatio_6)
            vc.modalPresentationStyle = .popover
            vc.currentIndex = popoverIndex
            if let pop = vc.popoverPresentationController {
                pop.delegate = self
                pop.backgroundColor = UIColor.white
                pop.permittedArrowDirections = .up
                pop.sourceView = menu.progressView
                pop.sourceRect = menu.progressView.bounds
                present(vc, animated: true, completion: nil)
            }
        }
        
        let isSelected = super.responds(to: #selector(menuView(_:shouldSelesctedIndex:)))
        return isSelected == true ? super.menuView(menu, shouldSelesctedIndex: index) : true
    }
    
}


//MARK: - 认证popover delegate
extension PVMeTeamVC: PVMeTeamAuthPopoverDelegate {
    
    func didSelectedPopoverItem(index: Int) {
        let items = ["已认证", "未认证"]
        popoverIndex = index
        updateTitle(items[index], at: 2)
        //reload data
        
    }
    
}

extension PVMeTeamVC: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
