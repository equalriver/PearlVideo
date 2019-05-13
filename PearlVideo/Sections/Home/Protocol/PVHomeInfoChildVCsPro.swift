//
//  PVHomeInfoChildVCsPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/10.
//  Copyright © 2019 equalriver. All rights reserved.
//



//MARK: - 会员等级
extension PVHomeUserLevelVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeUserLevelCell") as? PVHomeUserLevelCell
        if cell == nil {
            cell = PVHomeUserLevelCell.init(style: .default, reuseIdentifier: "PVHomeUserLevelCell")
        }
        
        return cell!
    }
}


//MARK: - 活跃度
extension PVHomeActivenessVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeActivenessCell") as? PVHomeActivenessCell
        if cell == nil {
            cell = PVHomeActivenessCell.init(style: .default, reuseIdentifier: "PVHomeActivenessCell")
        }
        
        return cell!
    }
}

//MARK: - 平安果
extension PVHomeFruitVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeActivenessCell") as? PVHomeActivenessCell
        if cell == nil {
            cell = PVHomeActivenessCell.init(style: .default, reuseIdentifier: "PVHomeActivenessCell")
        }
        
        return cell!
    }
}


