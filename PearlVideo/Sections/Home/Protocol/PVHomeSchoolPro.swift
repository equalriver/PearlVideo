//
//  PVHomeSchoolPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController

//MARK: - 商学院
extension PVHomeSchoolVC {
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["视频区", "新手指南"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//视频区
            return PVHomeSchoolVideoVC()
        }
        if index == 1 {//新手指南
            return PVHomeSchoolGuideVC()
        }
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let y = kNavigationBarAndStatusHeight + 50 * KScreenRatio_6
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: kScreenHeight - y)
    }
    
}

//视频区
extension PVHomeSchoolVideoVC {
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .schoolVideoList(page: page, count: 10), success: { (resp) in
            self.tableView.mj_header.endRefreshing()
            if page == 1 { self.dataArr.removeAll() }
            
            
        }) { (e) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 1
            self?.dataArr.removeAll()
            self?.loadData(page: 1)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 10
            self?.loadData(page: self?.page ?? 1)
        }
    }
    
}

extension PVHomeSchoolVideoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeSchoolVideoCell") as? PVHomeSchoolVideoCell
        if cell == nil {
            cell = PVHomeSchoolVideoCell.init(style: .default, reuseIdentifier: "PVHomeSchoolVideoCell")
        }
        
        return cell!
    }
    
}

//新手指南
extension PVHomeSchoolGuideVC {
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .schoolUserGuide(page: page, count: 10), success: { (resp) in
            self.tableView.mj_header.endRefreshing()
            if page == 1 { self.dataArr.removeAll() }
            
            
        }) { (e) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 1
            self?.dataArr.removeAll()
            self?.loadData(page: 1)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 10
            self?.loadData(page: self?.page ?? 1)
        }
    }
}

extension PVHomeSchoolGuideVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "PVHomeSchoolGuideCell", configuration: { (cell) in
            
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeSchoolGuideCell") as? PVHomeSchoolGuideCell
        if cell == nil {
            cell = PVHomeSchoolGuideCell.init(style: .default, reuseIdentifier: "PVHomeSchoolGuideCell")
        }
        
        return cell!
    }
    
}
