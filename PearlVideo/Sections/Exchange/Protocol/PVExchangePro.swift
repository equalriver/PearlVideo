//
//  PVExchangePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/28.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper
import SVProgressHUD

extension PVExchangeVC {
    
    override func rightButtonsAction(sender: UIButton) {
        let vc = PVExchangeRecordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadInfoData() {
        PVNetworkTool.Request(router: .exchangeInfo, success: { (resp) in
            if let d = Mapper<PVExchangeInfoModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                self.headerView.data = d
                self.tableView.tableHeaderView = self.headerView
            }
            
        }) { (e) in
            
        }
    }
    
    func loadData(page: Int) {
        isLoadingMore = true
        PVNetworkTool.Request(router: .exchangeInfoList(isBuyOrder: isBuyOrderView, phone: "", page: page * 10), success: { (resp) in
            
            if let d = Mapper<PVExchangeOrderList>().mapArray(JSONObject: resp["result"]["orderList"].arrayObject) {
                if page == 0 {
                    self.dataArr = d
                }
                else {
                    self.dataArr += d
                    if d.count == 0 {
                        self.page -= 1
                        self.isLoadingMore = false
                        return
                    }
                }
                if self.dataArr.count == 0 { self.tableView.stateEmpty() }
                else { self.tableView.stateNormal() }
                self.tableView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.isLoadingMore = false
            })
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.isLoadingMore = false
        }
    }
    
    @objc func searchData(phone: String) {
        PVNetworkTool.Request(router: .exchangeInfoList(isBuyOrder: isBuyOrderView, phone: phone, page: page * 10), success: { (resp) in
            
            if let d = Mapper<PVExchangeOrderList>().mapArray(JSONObject: resp["result"]["orderList"].arrayObject) {
                self.searchArr = d
//                self.searchVC.searchSuggestionView.reloadData()
                
            }
            
        }) { (e) in
            
        }
    }
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) { [weak self] in
            self?.page = 0
            self?.loadInfoData()
            self?.loadData(page: 0)
        }
    }
    
    @objc func segmentAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isBuyOrderView = true
            
        }
        if sender.selectedSegmentIndex == 1 {
            isBuyOrderView = false
            
        }
        tableView.mj_header.beginRefreshing()
    }
    
}

extension PVExchangeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVExchangeCell") as? PVExchangeCell
        if cell == nil {
            cell = PVExchangeCell.init(style: .default, reuseIdentifier: "PVExchangeCell")
        }
        cell?.delegate = self
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        cell?.isBuyOrder = isBuyOrderView
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionView
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isLoadingMore == false {
            let current = scrollView.contentOffset.y + scrollView.frame.size.height
            let total = scrollView.contentSize.height
            let ratio = current / total
            
            let needRead = CGFloat(itemPerPage) * threshold + CGFloat(page * itemPerPage) * 0.8
            let totalItem = itemPerPage * (page + 1)
            let newThreshold = needRead / CGFloat(totalItem)
            
            if ratio >= newThreshold {
                page += 1
                isLoadingMore = true
                loadData(page: page)
                print("Request page \(page) from server.")
            }
        }
    }
    
}

//MARK: - cell delegate
extension PVExchangeVC: PVExchangeOrderDelegate {
    
    func didSelectedDeal(cell: PVExchangeCell, isBuyOrder: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        func acceptOrder(id: String, psd: String, count: Int, isBuyOrder: Bool) {
            PVNetworkTool.Request(router: .acceptOrder(orderId: id, password: psd, count: count), success: { (resp) in
                SVProgressHUD.showSuccess(withStatus: "接单成功")
                let vc = PVExchangeRecordVC()
                vc.selectIndex = isBuyOrder ? 0 : 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                
            }) { (e) in
                
            }
        }
        
        SVProgressHUD.show()
        PVNetworkTool.Request(router: .readyAcceptOrder(orderId: self.dataArr[indexPath.row].orderId), success: { (resp) in
            SVProgressHUD.dismiss()
            guard let d = Mapper<PVExchangeReadyAcceptOrderModel>().map(JSONObject: resp["result"].object) else { return }
            if cell.isBuyOrder {//买入
                let alert = PVExchangeBuyAlert.init(frame: self.view.bounds) { (count, psd) in
                    acceptOrder(id: self.dataArr[indexPath.row].orderId, psd: psd, count: Int(count) ?? 0, isBuyOrder: cell.isBuyOrder)
                }
                alert.data = d
                self.view.addSubview(alert)
            }
            else {//卖出
                
            }
            
        }) { (e) in
            
        }
        
    }
    
}


//MARK: - header section view
extension PVExchangeVC: PVExchangeHeaderSectionDelegate {
    //搜索
    func didSelectedSearch() {
        present(UINavigationController.init(rootViewController: searchVC), animated: true, completion: nil)
    }
    //发单
    func didSelectedSendOrder() {
        if isBuyOrderView {
            let vc = PVExchangeBuyOrderVC()
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = PVExchangeSellOrderVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

//MARK: - search vc delegate
extension PVExchangeVC: PYSearchViewControllerDelegate, PYSearchViewControllerDataSource {
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return searchArr.count
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, heightForRowAt indexPath: IndexPath!) -> CGFloat {
        return 120 * KScreenRatio_6
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        var cell = searchSuggestionView.dequeueReusableCell(withIdentifier: "PVExchangeCell") as? PVExchangeCell
        if cell == nil {
            cell = PVExchangeCell.init(style: .default, reuseIdentifier: "PVExchangeCell")
        }
        guard searchArr.count > indexPath.row else { return cell! }
        cell?.delegate = self
        cell?.data = searchArr[indexPath.row]
        cell?.isBuyOrder = isBuyOrderView
        return cell!
    }
    
    
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange searchBar: UISearchBar!, searchText: String!) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchData(phone:)), object: nil)
        self.perform(#selector(searchData(phone:)), with: searchText, afterDelay: 0.5)
        
    }
    
    func searchViewController(_ searchViewController: PYSearchViewController!, didSelectSearchSuggestionAt indexPath: IndexPath!, searchBar: UISearchBar!) {
        
//        guard searchArr.count > indexPath.row else { return }
//
//        searchViewController.dismiss(animated: true) {
//
//            DispatchQueue.main.async {
//
//            }
//        }
        
    }
    
    func didClickCancel(_ searchViewController: PYSearchViewController!) {
        
        searchViewController.dismiss(animated: true) {
           
        }
    }
}
