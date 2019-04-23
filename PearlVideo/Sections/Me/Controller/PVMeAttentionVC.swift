//
//  PVMeAttentionVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit
import PYSearch

class PVMeAttentionVC: PVBaseNavigationVC {
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.tableHeaderView = searchBtn
        return tb
    }()
    lazy var searchBtn: UIButton = {
        let b = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 30 * KScreenRatio_6))
        b.setImage(UIImage.init(named: ""), for: .normal)
        b.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "关注"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.bottom.width.centerX.equalToSuperview()
        }
    }
    
    @objc func searchAction() {
        let searchVC = PYSearchViewController.init()
        searchVC.delegate = self
        searchVC.dataSource = self
        searchVC.showSearchHistory = false
        present(UINavigationController.init(rootViewController: searchVC), animated: true, completion: nil)
    }


}

extension PVMeAttentionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeAttentionCell") as? PVMeAttentionCell
        if cell == nil {
            cell = PVMeAttentionCell.init(style: .default, reuseIdentifier: "PVMeAttentionCell")
        }
        
        return cell!
    }
}


//MARK: - PYSearchViewControllerDelegate
extension PVMeAttentionVC: PYSearchViewControllerDelegate, PYSearchViewControllerDataSource {
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, heightForRowAt indexPath: IndexPath!) -> CGFloat {
        return 60 * KScreenRatio_6
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        var cell = searchSuggestionView.dequeueReusableCell(withIdentifier: "PVMeAttentionCell") as? PVMeAttentionCell
        if cell == nil {
            cell = PVMeAttentionCell.init(style: .default, reuseIdentifier: "PVMeAttentionCell")
        }
        
        return cell!
    }
    
    
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange searchBar: UISearchBar!, searchText: String!) {
        
    }
    
    func searchViewController(_ searchViewController: PYSearchViewController!, didSelectSearchSuggestionAt indexPath: IndexPath!, searchBar: UISearchBar!) {
        
        
    }
    
    func didClickCancel(_ searchViewController: PYSearchViewController!) {
        
        searchViewController.dismiss(animated: true) {
            
        }
    }
}
