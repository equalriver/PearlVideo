//
//  PVHomeMyTeamPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import ObjectMapper

extension PVHomeMyTeamVC {
    //团队招募
    override func rightButtonsAction(sender: UIButton) {
        let vc = PVVideoShareVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadData() {
        PVNetworkTool.Request(router: .teamInfo, success: { (resp) in
            if let d = Mapper<PVHomeTeamModel>().map(JSONObject: resp["result"].object) {
                self.data = d
            }
            
        }) { (e) in
             
        }
    }
    
    @objc func userValidateNoti(sender: Notification) {
        loadData()
    }
}

//page controller delegate
extension PVHomeMyTeamVC {
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return 3
    }
    
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
        return CGRect.init(x: 0, y: 150 * KScreenRatio_6 + kNavigationBarAndStatusHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let y = 200 * KScreenRatio_6 + kNavigationBarAndStatusHeight
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: kScreenHeight - y)
    }
    
}


//MARK: - 全部队员
extension PVHomeMyTeamAllVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .teamAllList(page: page * 10), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeTeamList>().mapArray(JSONObject: resp["result"]["userTeamList"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                if self.dataArr.count == 0 { self.tableView.stateEmpty() }
                else { self.tableView.stateNormal() }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    @objc func userValidateNoti(sender: Notification) {
        loadData(page: 0)
    }
    
}

extension PVHomeMyTeamAllVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMyTeamListCell") as? PVHomeMyTeamListCell
        if cell == nil {
            cell = PVHomeMyTeamListCell.init(style: .default, reuseIdentifier: "PVHomeMyTeamListCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
}

//MARK: - 实名队员
extension PVHomeMyTeamAuthVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .teamAuthList(page: page * 10), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeTeamList>().mapArray(JSONObject: resp["result"]["realNameAuthenticationList"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                if self.dataArr.count == 0 { self.tableView.stateEmpty() }
                else { self.tableView.stateNormal() }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    @objc func userValidateNoti(sender: Notification) {
        loadData(page: 0)
    }
    
}

extension PVHomeMyTeamAuthVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMyTeamListCell") as? PVHomeMyTeamListCell
        if cell == nil {
            cell = PVHomeMyTeamListCell.init(style: .default, reuseIdentifier: "PVHomeMyTeamListCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        cell?.statusIV.isHidden = true
        return cell!
    }
    
}

//MARK: - 未实名队员
extension PVHomeMyTeamNotAuthVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .teamNotAuthList(page: page * 10), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeTeamList>().mapArray(JSONObject: resp["result"]["notRealNameAuthenticationList"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                if self.dataArr.count == 0 { self.tableView.stateEmpty() }
                else { self.tableView.stateNormal() }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    @objc func userValidateNoti(sender: Notification) {
        loadData(page: 0)
    }
    
}

extension PVHomeMyTeamNotAuthVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMyTeamListCell") as? PVHomeMyTeamListCell
        if cell == nil {
            cell = PVHomeMyTeamListCell.init(style: .default, reuseIdentifier: "PVHomeMyTeamListCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        cell?.statusIV.isHidden = true
        return cell!
    }
    
}
