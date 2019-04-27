//
//  PVPearlPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - action
extension PVPearlVC {
    
}

//MARK: - header view delegate
extension PVPearlVC: PVPearlHeaderDelegate {
    //升级贝壳
    func didSelectedLevelUp() {
        YPJOtherTool.ypj.showAlert(title: nil, message: "升级x贝壳LVxx需消耗xx珍珠", style: .alert, isNeedCancel: true) { (ac) in
            
        }
    }
    
    //珍珠明细
    func didSelectedPearlDetail() {
        
    }
    
    //水草明细
    func didSelectedPlantDetail() {
        
    }
    
    //用户等级
    func didSelectedUserLevel() {
        
    }
    
    //贝壳等级
    func didSelectedShellLevel() {
        
    }
    
    //喂养水草
    func didSelectedFeedPlant(sender: UIButton, completion: (String?) -> Void) {
        
    }
    
}

//MARK: - section header delegate
extension PVPearlVC: PVPearlSectionHeaderDelegate {
    //进入集市
    func didSelectedMarket() {
        
    }
    
}

//MARK: - action
extension PVPearlVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PVPearlCell.init(style: .default, reuseIdentifier: nil)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }
    
}

//MARK: - cell delegate
extension PVPearlVC: PVPearlCellDelegate {
    
    func didSelectedTask(cell: UITableViewCell, sender: UIButton) {
        
    }

}
