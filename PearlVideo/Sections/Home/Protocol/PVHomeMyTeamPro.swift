//
//  PVHomeMyTeamPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController

extension PVHomeMyTeamVC {
    //邀请好友
    override func rightButtonsAction(sender: UIButton) {
        
    }
    
}

//page controller delegate
extension PVHomeMyTeamVC {
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["全部队员", "实名队员", "未实名队员"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 { //全部队员
            return PVHomeMyTeamAllVC()
        }
        if index == 1 { //实名队员
            return PVHomeMyTeamAuthVC()
        }
        if index == 2 { //未实名队员
            return PVHomeMyTeamNotAuthVC()
        }
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: 220 * KScreenRatio_6 + kNavigationBarAndStatusHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let y = 270 * KScreenRatio_6 + kNavigationBarAndStatusHeight
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: kScreenHeight - y)
    }
    
}


//MARK: - 全部队员
extension PVHomeMyTeamAllVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMyTeamListCell") as? PVHomeMyTeamListCell
        if cell == nil {
            cell = PVHomeMyTeamListCell.init(style: .default, reuseIdentifier: "PVHomeMyTeamListCell")
        }
        
        return cell!
    }
    
}

//MARK: - 实名队员
extension PVHomeMyTeamAuthVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMyTeamListCell") as? PVHomeMyTeamListCell
        if cell == nil {
            cell = PVHomeMyTeamListCell.init(style: .default, reuseIdentifier: "PVHomeMyTeamListCell")
        }
        cell?.statusIV.isHidden = true
        
        return cell!
    }
    
}

//MARK: - 未实名队员
extension PVHomeMyTeamNotAuthVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMyTeamListCell") as? PVHomeMyTeamListCell
        if cell == nil {
            cell = PVHomeMyTeamListCell.init(style: .default, reuseIdentifier: "PVHomeMyTeamListCell")
        }
        cell?.statusIV.isHidden = true
        
        return cell!
    }
    
}
