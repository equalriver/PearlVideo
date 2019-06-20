//
//  PVHomeInfoChildVCsPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper
import WMPageController

//MARK: - 会员等级
extension PVHomeUserLevelVC {
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) { [weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
            self?.loadCurrentInfo()
        }
        PVRefresh.footerRefresh(scrollView: tableView) { [weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadCurrentInfo() {
        PVNetworkTool.Request(router: .currentUserLevel, success: { (resp) in
            if let d = Mapper<PVHomeCurrentUserLevel>().map(JSONObject: resp["result"].object) {
                self.infoData = d
                self.headerView.data = d
                self.tableView.tableHeaderView = self.headerView
            }
            
        }) { (e) in
            
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .userLevel(next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVHomeUserLevelModel>().mapArray(JSONObject: resp["result"]["userExpList"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
            }
            if self.dataArr.count == 0 { self.tableView.stateEmpty() }
            else { self.tableView.stateNormal() }
            self.tableView.reloadData()
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
    }
}

extension PVHomeUserLevelVC: PVHomeUserLevelHeaderDelegate {
    
    func didSelectedLevelDetail() {
        let vc = PVHomeUserLevelDetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PVHomeUserLevelVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeUserLevelCell") as? PVHomeUserLevelCell
        if cell == nil {
            cell = PVHomeUserLevelCell.init(style: .default, reuseIdentifier: "PVHomeUserLevelCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
}

//MARK: - 会员等级详情
extension PVHomeUserLevelDetailVC {
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) { [weak self] in
            self?.loadData()
        }
    }
    
    func loadData() {
        PVNetworkTool.Request(router: .userLevelDetail, success: { (resp) in
        
            if let d = Mapper<PVHomeUserLevelDetailModel>().mapArray(JSONObject: resp["result"]["levelList"].arrayObject) {
                self.dataArr = d
            }
            if self.dataArr.count == 0 { self.tableView.stateEmpty() }
            else { self.tableView.stateNormal() }
            self.tableView.reloadData()
            
        }) { (e) in
            
        }
    }
}

extension PVHomeUserLevelDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeUserLevelDetailCell") as? PVHomeUserLevelDetailCell
        if cell == nil {
            cell = PVHomeUserLevelDetailCell.init(style: .default, reuseIdentifier: "PVHomeUserLevelDetailCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
}


//MARK: - 活跃度
extension PVHomeActivenessVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .activenessDetail(next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVHomeActivenessModel>().map(JSONObject: resp["result"].object) {
                if page == 0 { self.data = d }
                else {
                    self.data.livenessDetailList += d.livenessDetailList
                    if d.livenessDetailList.count == 0 { self.page -= 1 }
                }
                if self.data.livenessDetailList.count == 0 { self.tableView.stateEmpty() }
                else { self.tableView.stateNormal() }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
}

extension PVHomeActivenessVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.livenessDetailList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeActivenessCell") as? PVHomeActivenessCell
        if cell == nil {
            cell = PVHomeActivenessCell.init(style: .default, reuseIdentifier: "PVHomeActivenessCell")
        }
        guard data.livenessDetailList.count > indexPath.row else { return cell! }
        cell?.activenessData = data.livenessDetailList[indexPath.row]
        return cell!
    }
}

//MARK: - 平安果
extension PVHomeFruitVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .fruitDetail(next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVHomeFruitModel>().map(JSONObject: resp["result"].object) {
                if page == 0 { self.data = d }
                else {
                    self.data.pearlDetail += d.pearlDetail
                    if d.pearlDetail.count == 0 { self.page -= 1 }
                }
                if self.data.pearlDetail.count == 0 { self.tableView.stateEmpty() }
                else { self.tableView.stateNormal() }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
}

extension PVHomeFruitVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.pearlDetail.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeActivenessCell") as? PVHomeActivenessCell
        if cell == nil {
            cell = PVHomeActivenessCell.init(style: .default, reuseIdentifier: "PVHomeActivenessCell")
        }
        guard data.pearlDetail.count > indexPath.row else { return cell! }
        cell?.fruitData = data.pearlDetail[indexPath.row]
        return cell!
    }
}

//MARK: - 商学院
extension PVHomeSchoolVC {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return 2
    }
    
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
        PVNetworkTool.Request(router: .schoolVideoList(next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVHomeSchoolVideoList>().mapArray(JSONObject: resp["result"]["courseList"].arrayObject) {
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
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
}

extension PVHomeSchoolVideoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeSchoolVideoCell") as? PVHomeSchoolVideoCell
        if cell == nil {
            cell = PVHomeSchoolVideoCell.init(style: .default, reuseIdentifier: "PVHomeSchoolVideoCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
}

//新手指南
extension PVHomeSchoolGuideVC {
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .schoolUserGuide(next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVHomeSchoolGuideList>().mapArray(JSONObject: resp["result"]["commercialList"].arrayObject) {
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
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
}

extension PVHomeSchoolGuideVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "PVHomeSchoolGuideCell", configuration: {[weak self] (cell) in
            guard let c = cell as? PVHomeSchoolGuideCell else { return }
            c.data = self?.dataArr[indexPath.row]
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeSchoolGuideCell", for: indexPath) as! PVHomeSchoolGuideCell
        guard dataArr.count > indexPath.row else { return cell }
        cell.data = dataArr[indexPath.row]
        return cell
    }
    
}

