//
//  PVMeMessageVCChildPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/8.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 通知
extension PVMeMessageNoticeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeMessageNoticeCell") as? PVMeMessageNoticeCell
        if cell == nil {
            cell = PVMeMessageNoticeCell.init(style: .default, reuseIdentifier: "PVMeMessageNoticeCell")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


//MARK: - 评论
extension PVMeMessageCommentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeMessageCommentCell") as? PVMeMessageCommentCell
        if cell == nil {
            cell = PVMeMessageCommentCell.init(style: .default, reuseIdentifier: "PVMeMessageCommentCell")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


//MARK: - 点赞
extension PVMeMessageLikeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeMessageLikeCell") as? PVMeMessageLikeCell
        if cell == nil {
            cell = PVMeMessageLikeCell.init(style: .default, reuseIdentifier: "PVMeMessageLikeCell")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


//MARK: - 关注
extension PVMeMessageAttentionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeMessageAttentionCell") as? PVMeMessageAttentionCell
        if cell == nil {
            cell = PVMeMessageAttentionCell.init(style: .default, reuseIdentifier: "PVMeMessageAttentionCell")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
