//
//  PVPearlDealRecordChildPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/15.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 买单
extension PVPearlDealRecordBuyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVPearlDealRecordBuyCell") as? PVPearlDealRecordBuyCell
        if cell == nil {
            cell = PVPearlDealRecordBuyCell.init(style: .default, reuseIdentifier: "PVPearlDealRecordBuyCell")
        }
        cell?.delegate = self
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }
    
}

extension PVPearlDealRecordBuyVC: PVPearlDealRecordBuyDelegate {
    
    func didSelectedHeader(cell: UITableViewCell) {
        
    }
    
    func didSelectedDealDetail(cell: UITableViewCell) {
        
    }
    
}
