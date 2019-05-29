//
//  PVExchangePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/28.
//  Copyright © 2019 equalriver. All rights reserved.
//

extension PVExchangeVC {
    
}

extension PVExchangeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVExchangeCell") as? PVExchangeCell
        if cell == nil {
            cell = PVExchangeCell.init(style: .default, reuseIdentifier: "PVExchangeCell")
        }
        
        return cell!
    }
    
}
