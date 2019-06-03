//
//  PVExchangePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/28.
//  Copyright © 2019 equalriver. All rights reserved.
//

extension PVExchangeVC {
    
    @objc func segmentAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isBuyOrderView = true
            
        }
        if sender.selectedSegmentIndex == 1 {
            isBuyOrderView = false
            
        }
    }
    
}

extension PVExchangeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVExchangeCell") as? PVExchangeCell
        if cell == nil {
            cell = PVExchangeCell.init(style: .default, reuseIdentifier: "PVExchangeCell")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionView
    }
    
}

//MARK: - header section view
extension PVExchangeVC: PVExchangeHeaderSectionDelegate {
    
    func didSelectedSearch() {
        
    }
    
    func didSelectedSendOrder() {
        
    }

}

//MARK: - search vc delegate
extension PVExchangeVC: PYSearchViewControllerDelegate, PYSearchViewControllerDataSource {
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, heightForRowAt indexPath: IndexPath!) -> CGFloat {
        return 120 * KScreenRatio_6
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        var cell = searchSuggestionView.dequeueReusableCell(withIdentifier: "PVExchangeCell") as? PVExchangeCell
        if cell == nil {
            cell = PVExchangeCell.init(style: .default, reuseIdentifier: "PVExchangeCell")
        }
        
        
        return cell!
    }
    
    
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange searchBar: UISearchBar!, searchText: String!) {
        
        
        
    }
    
    func searchViewController(_ searchViewController: PYSearchViewController!, didSelectSearchSuggestionAt indexPath: IndexPath!, searchBar: UISearchBar!) {
        
//        guard searchArr.count > indexPath.row else { return }
        
        searchViewController.dismiss(animated: true) {
            
            DispatchQueue.main.async {
                
            }
        }
        
    }
    
    func didClickCancel(_ searchViewController: PYSearchViewController!) {
        
        searchViewController.dismiss(animated: true) {
           
        }
    }
}
