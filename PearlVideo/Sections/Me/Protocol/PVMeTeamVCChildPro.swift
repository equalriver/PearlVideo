//
//  PVMeTeamVCChildPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 我推荐的
extension PVMeTeamMeCommendVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeTeamCell") as? PVMeTeamCell
        if cell == nil {
            cell = PVMeTeamCell.init(style: .default, reuseIdentifier: "PVMeTeamCell")
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


//MARK: - 好友推荐
extension PVMeTeamFriendCommendVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeTeamCell") as? PVMeTeamCell
        if cell == nil {
            cell = PVMeTeamCell.init(style: .default, reuseIdentifier: "PVMeTeamCell")
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - 认证
extension PVMeTeamAuthVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeTeamCell") as? PVMeTeamCell
        if cell == nil {
            cell = PVMeTeamCell.init(style: .default, reuseIdentifier: "PVMeTeamCell")
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


//MARK: - 认证popover
extension PVMeTeamAuthPopoverVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PVMeTeamAuthPopoverCell.init(style: .default, reuseIdentifier: nil)
        cell.titleLabel.text = items[indexPath.row]
        cell.isSelected = currentIndex == indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedPopoverItem(index: indexPath.row)
        dismiss(animated: true, completion: nil)
    }
    
}
