//
//  PVHomeTaskPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/14.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import ObjectMapper
import SVProgressHUD

extension PVHomeTaskVC {
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return 3
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["我的任务", "任务书卷", "历史任务"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//我的任务
            return PVHomeMyTaskVC()
        }
        if index == 1 {//任务书卷
            return PVHomeAllTaskVC()
        }
        if index == 2 {//历史任务
            return PVHomeHistoryTaskVC()
        }
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let y = kNavigationBarAndStatusHeight + 50 * KScreenRatio_6
        return CGRect.init(x: 0, y: y, width: kScreenWidth, height: kScreenHeight - y)
    }
    
}


//MARK: - 我的任务
extension PVHomeMyTaskVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .myTask(next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            let n = resp["result"]["next"].string ?? "\(resp["result"]["skip"].intValue)"
            self.nextPage = n
            
            if let d = Mapper<PVHomeTaskList>().mapArray(JSONObject: resp["result"]["list"].arrayObject) {
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
    
    func loadTaskProgress() {
        PVNetworkTool.Request(router: .taskProgress, success: { (resp) in
            if let d = Mapper<PVTaskProgressModel>().map(JSONObject: resp["result"].object) {
                let watchPercent = Float(d.watchVideo) / Float(d.watchVideo + d.notWatchVideo) * 100
                let likePercent = Float(d.thumbupVideo) / Float(d.thumbupVideo + d.notThumbupVideo) * 100
                let v = PVHomeMyTaskHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 110 * KScreenRatio_6), watchPercent: Int(watchPercent), likePercent: Int(likePercent))
                self.tableView.tableHeaderView = v
                self.tableView.reloadData()
            }
            
        }) { (e) in
            
        }
    }
    
    @objc func refreshNoti(sender: Notification) {
        page = 0
        nextPage = ""
        loadData(page: 0)
    }
    
}

extension PVHomeMyTaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMyTaskCell") as? PVHomeMyTaskCell
        if cell == nil {
            cell = PVHomeMyTaskCell.init(style: .default, reuseIdentifier: "PVHomeMyTaskCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
}

//MARK: - 任务书卷
extension PVHomeAllTaskVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.loadData()
        }
       
    }
    
    func loadData() {
        PVNetworkTool.Request(router: .taskAll, success: { (resp) in
            if let d = Mapper<PVHomeTaskList>().mapArray(JSONObject: resp["result"]["list"].arrayObject) {
                self.dataArr = d
                if self.dataArr.count == 0 { self.tableView.stateEmpty() }
                else { self.tableView.stateNormal() }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            
        }
    }
    
}

extension PVHomeAllTaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeAllTaskCell") as? PVHomeAllTaskCell
        if cell == nil {
            cell = PVHomeAllTaskCell.init(style: .default, reuseIdentifier: "PVHomeAllTaskCell")
        }
        cell?.delegate = self
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
}

extension PVHomeAllTaskVC: PVHomeAllTaskDelegate {
    
    func didSelectedExchange(cell: PVHomeAllTaskCell, sender: UIButton) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        if dataArr[indexPath.row].category == 0 {//领取
            
        }
        else {//兑换
            func exchange(password: String) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
//                    YPJOtherTool.ypj.authWithTouchID(callback: { (isSuccess) in
//                        if isSuccess {
                            SVProgressHUD.show()
                            PVNetworkTool.Request(router: .exchangeTask(id: self.dataArr[indexPath.row].id, password: password), success: { (resp) in
                                SVProgressHUD.showSuccess(withStatus: "兑换成功")
                                sender.isEnabled = false
                                self.dataArr[indexPath.row].isExchange = true
                                self.tableView.reloadRow(at: indexPath, with: .none)
                                NotificationCenter.default.post(name: .kNotiName_refreshMyTask, object: nil)
                                
                            }, failure: { (e) in
                                
                            })
//                        }
//                    })
                })
            }
            
            let alert = UIAlertController.init(title: nil, message: "确定兑换该书卷吗？", preferredStyle: .alert)
            alert.addTextField { (tf) in
                tf.isSecureTextEntry = true
                tf.placeholder = "请输入交换密码"
                tf.font = kFont_text
                tf.textColor = UIColor.black
                tf.addBlock(for: .editingChanged, block: {[weak self] (t) in
                    self?.exchangePsd = tf.text ?? ""
                })
                tf.backgroundColor = UIColor.white
                tf.tintColor = kColor_border
                tf.borderStyle = .roundedRect
            }
            let confirm = UIAlertAction.init(title: "确定", style: .default) { (ac) in
                guard let tf = alert.textFields?.first else { return }
                guard tf.hasText else {
                    self.view.makeToast("请输入交换密码")
                    return
                }
                self.view.endEditing(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                    exchange(password: tf.text!)
                })
            }
            let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            alert.addAction(confirm)
            alert.addAction(cancel)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
 
        }
        
    }
    
}


//MARK: - 历史任务
extension PVHomeHistoryTaskVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.nextPage = ""
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .historyTask(next: nextPage), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let n = resp["result"]["next"].string { self.nextPage = n }
            
            if let d = Mapper<PVHomeTaskList>().mapArray(JSONObject: resp["result"]["list"].arrayObject) {
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
    
}

extension PVHomeHistoryTaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVHomeMyTaskCell") as? PVHomeMyTaskCell
        if cell == nil {
            cell = PVHomeMyTaskCell.init(style: .default, reuseIdentifier: "PVHomeMyTaskCell")
        }
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
}
