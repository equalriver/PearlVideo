//
//  PVExchangeRecordPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import ObjectMapper

extension PVExchangeRecordVC {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return items.count
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return items[index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//买单
            return PVExchangeRecordBuyVC()
        }
        if index == 1 {//卖单
            return PVExchangeRecordSellVC()
        }
        if index == 2 {//交换中
            return PVExchangeRecordExchangingVC()
        }
        if index == 3 {//已完成
            return PVExchangeRecordFinishVC()
        }
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight + 50 * KScreenRatio_6, width: kScreenWidth, height: kScreenHeight - kNavigationBarAndStatusHeight - 50 * KScreenRatio_6)
    }
}

//MARK: - 买单
extension PVExchangeRecordBuyVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) { [weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) { [weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .recordList(type: .buy, next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVExchangeRecordList>().mapArray(JSONObject: resp["result"]["orderList"].arrayObject) {
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
}

extension PVExchangeRecordBuyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVExchangeRecordCell") as? PVExchangeRecordCell
        if cell == nil {
            cell = PVExchangeRecordCell.init(style: .default, reuseIdentifier: "PVExchangeRecordCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.handleLabel.text = "买入"
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PVExchangeRecordBuyDetailVC()
        vc.orderId = dataArr[indexPath.row].orderId
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - 卖单
extension PVExchangeRecordSellVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) { [weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) { [weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .recordList(type: .sell, next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVExchangeRecordList>().mapArray(JSONObject: resp["result"]["orderList"].arrayObject) {
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
}

extension PVExchangeRecordSellVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVExchangeRecordCell") as? PVExchangeRecordCell
        if cell == nil {
            cell = PVExchangeRecordCell.init(style: .default, reuseIdentifier: "PVExchangeRecordCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.handleLabel.text = "卖出"
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PVExchangeRecordSellDetailVC()
        vc.orderId = dataArr[indexPath.row].orderId
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - 交换中
extension PVExchangeRecordExchangingVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) { [weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) { [weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .recordList(type: .exchanging, next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVExchangeRecordList>().mapArray(JSONObject: resp["result"]["orderList"].arrayObject) {
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
    
    @objc func refreshNoti(sender: Notification) {
        page = 0
        nextPage = ""
        loadData(page: 0)
    }
}

extension PVExchangeRecordExchangingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVExchangeRecordCell") as? PVExchangeRecordCell
        if cell == nil {
            cell = PVExchangeRecordCell.init(style: .default, reuseIdentifier: "PVExchangeRecordCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.handleLabel.text = "买入"
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PVExchangeRecordChangingDetailVC.init(type: dataArr[indexPath.row].state, orderId: dataArr[indexPath.row].orderId)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - 已完成
extension PVExchangeRecordFinishVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) { [weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) { [weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .recordList(type: .finish, next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVExchangeRecordList>().mapArray(JSONObject: resp["result"]["orderList"].arrayObject) {
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
}

extension PVExchangeRecordFinishVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVExchangeRecordCell") as? PVExchangeRecordCell
        if cell == nil {
            cell = PVExchangeRecordCell.init(style: .default, reuseIdentifier: "PVExchangeRecordCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.handleLabel.text = "已完成"
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
