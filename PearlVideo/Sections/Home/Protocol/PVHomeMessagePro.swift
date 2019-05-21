//
//  PVHomeMessagePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/14.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import ObjectMapper

extension PVHomeMessageVC {
    //获取消息状态
    func getMessageStatus() {
        PVNetworkTool.Request(router: .messageBadgeState(), success: { (resp) in
            if let fs = resp["result"]["followMessageStatus"].bool {
                self.followMessageStatus = fs
            }
            if let fs = resp["result"]["thumbupMessageStatus"].bool {
                self.thumbupMessageStatus = fs
            }
            if let fs = resp["result"]["commentMessageStatus"].bool {
                self.commentMessageStatus = fs
            }
            if let fs = resp["result"]["noticeMessageStatus"].bool {
                self.noticeMessageStatus = fs
            }
            self.reloadData()
            
        }) { (e) in
            
        }
    }
    
    //更新消息状态
    func refreshStatus(category: String) {
        PVNetworkTool.Request(router: .refreshMessageBadgeState(category: category), success: { (resp) in
            if let s = resp["msg"].string { print(s) }
            
        }) { (e) in
            
        }
    }
    
}

//WMPageController delegate
extension PVHomeMessageVC {
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return ["通知", "评论", "点赞", "关注"].count
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["通知", "评论", "点赞", "关注"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//通知
            return PVHomeMsgNoticeVC()
        }
        if index == 1 {//评论
            return PVHomeMsgCommentVC()
        }
        if index == 2 {//点赞
            return PVHomeMsgLikeVC()
        }
        if index == 3 {//关注
            return PVHomeMsgAttentionVC()
        }
        return UIViewController()
    }
    
    override func menuView(_ menu: WMMenuView!, badgeViewAt index: Int) -> UIView! {
        if let item = menu.item(at: index) {
            let badge = UIView.init(frame: CGRect.init(x: item.width * 0.75, y: 13 * KScreenRatio_6, width: 5, height: 5))
            badge.backgroundColor = kColor_pink
            badge.layer.cornerRadius = 2.5
            if index == 0 {//通知
                if noticeMessageStatus { return badge }
            }
            if index == 1 {//评论
                if commentMessageStatus { return badge }
            }
            if index == 2 {//点赞
                if thumbupMessageStatus { return badge }
            }
            if index == 3 {//关注
                if followMessageStatus { return badge }
            }
        }
        return nil
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let y = kNavigationBarAndStatusHeight + 50 * KScreenRatio_6
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: kScreenHeight - y)
    }
    
    override func pageController(_ pageController: WMPageController, didEnter viewController: UIViewController, withInfo info: [AnyHashable : Any]) {
        
    }
}

//MARK: - 通知
extension PVHomeMsgNoticeVC {
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .messsageList(page: page * 10, category: "NOTICEMESSAGE"), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeNoticeMessageList>().mapArray(JSONObject: resp["result"]["noticeList"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
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
}

extension PVHomeMsgNoticeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMsgNoticeCell") as? PVHomeMsgNoticeCell
        if cell == nil {
            cell = PVHomeMsgNoticeCell.init(style: .default, reuseIdentifier: "PVHomeMsgNoticeCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension PVHomeMsgNoticeDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "PVHomeMsgNoticeCell", cacheBy: indexPath, configuration: { (cell) in
            
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMsgNoticeCell", for: indexPath) as! PVHomeMsgNoticeCell
        cell.arrowIV.isHidden = true
        
        return cell
    }
    
}


//MARK: - 评论
extension PVHomeMsgCommentVC {
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .messsageList(page: page * 10, category: "COMMENTMESSAGE"), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeMessageList>().mapArray(JSONObject: resp["result"]["commentMessageList"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
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
}
extension PVHomeMsgCommentVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMsgCommentCell") as? PVHomeMsgCommentCell
        if cell == nil {
            cell = PVHomeMsgCommentCell.init(style: .default, reuseIdentifier: "PVHomeMsgCommentCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - 点赞
extension PVHomeMsgLikeVC {
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .messsageList(page: page * 10, category: "THUMBUPMESSAGE"), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeMessageList>().mapArray(JSONObject: resp["result"]["thumbupMessageList"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
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
}

extension PVHomeMsgLikeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMsgLikeCell") as? PVHomeMsgLikeCell
        if cell == nil {
            cell = PVHomeMsgLikeCell.init(style: .default, reuseIdentifier: "PVHomeMsgLikeCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - 关注
extension PVHomeMsgAttentionVC {
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .messsageList(page: page * 10, category: "FOLLOWMESSAGE"), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeMessageList>().mapArray(JSONObject: resp["result"]["followMessageList"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
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
}

extension PVHomeMsgAttentionVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMsgAttentionCell") as? PVHomeMsgAttentionCell
        if cell == nil {
            cell = PVHomeMsgAttentionCell.init(style: .default, reuseIdentifier: "PVHomeMsgAttentionCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
