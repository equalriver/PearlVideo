//
//  PVMeAttentionVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit
import PYSearch
import ObjectMapper

class PVMeAttentionVC: PVBaseNavigationVC {
    
    public var userId = ""
    
    var page = 0
    var dataArr = Array<PVMeAttentionModel>()
    var searchDataArr = Array<PVMeAttentionModel>()
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_deepBackground
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    lazy var searchBtn: UIButton = {
        let b = UIButton.init(frame: .zero)
        b.setImage(UIImage.init(named: ""), for: .normal)
        b.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        return b
    }()
    lazy var searchVC: PYSearchViewController = {
        let searchVC = PYSearchViewController.init()
        searchVC.delegate = self
        searchVC.dataSource = self
        searchVC.showSearchHistory = false
        searchVC.searchTextField.attributedPlaceholder = NSAttributedString.init(string: "请输入对方昵称", attributes: [.font: kFont_text_2_weight, .foregroundColor: kColor_subText!])
        searchVC.searchBarCornerRadius = kCornerRadius
        searchVC.searchBarBackgroundColor = kColor_deepBackground
        searchVC.searchSuggestionView.backgroundColor = kColor_deepBackground
        searchVC.view.backgroundColor = kColor_deepBackground
        searchVC.cancelButton.backgroundColor = kColor_deepBackground
        searchVC.cancelButton.setTitleColor(kColor_text, for: .normal)
        return searchVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "关注"
        view.addSubview(tableView)
        view.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.height.equalTo(30 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom).offset(15)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBtn.snp.bottom).offset(15)
            make.bottom.width.centerX.equalToSuperview()
        }
        
        setRefresh()
        loadData(page: 0)
    }
    
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
        PVNetworkTool.Request(router: .attentionAndFansList(type: 1, userId: userId, content: "", page: page * 10), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVMeAttentionModel>().mapArray(JSONObject: resp["result"]["followUserProfileList"].arrayObject) {
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
    
    @objc func searchAction() {
        present(UINavigationController.init(rootViewController: searchVC), animated: true, completion: nil)
    }


}

extension PVMeAttentionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeAttentionCell") as? PVMeAttentionCell
        if cell == nil {
            cell = PVMeAttentionCell.init(style: .default, reuseIdentifier: "PVMeAttentionCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
}


//MARK: - PYSearchViewControllerDelegate
extension PVMeAttentionVC: PYSearchViewControllerDelegate, PYSearchViewControllerDataSource {
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return searchDataArr.count
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, heightForRowAt indexPath: IndexPath!) -> CGFloat {
        return 60 * KScreenRatio_6
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        var cell = searchSuggestionView.dequeueReusableCell(withIdentifier: "PVMeAttentionCell") as? PVMeAttentionCell
        if cell == nil {
            cell = PVMeAttentionCell.init(style: .default, reuseIdentifier: "PVMeAttentionCell")
        }
        guard searchDataArr.count > indexPath.row else { return cell! }
        cell?.data = searchDataArr[indexPath.row]
        return cell!
    }
    
    
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange searchBar: UISearchBar!, searchText: String!) {
        PVNetworkTool.Request(router: .attentionAndFansList(type: 3, userId: userId, content: searchText, page: 0), success: { (resp) in
            if let d = Mapper<PVMeAttentionModel>().mapArray(JSONObject: resp["result"]["followInfolist"].arrayObject) {
                
            }
        }) { (e) in
            
        }
    }
    
    func searchViewController(_ searchViewController: PYSearchViewController!, didSelectSearchSuggestionAt indexPath: IndexPath!, searchBar: UISearchBar!) {
        
        
    }
    
    func didClickCancel(_ searchViewController: PYSearchViewController!) {
        
        searchViewController.dismiss(animated: true) {
            
        }
    }
}
