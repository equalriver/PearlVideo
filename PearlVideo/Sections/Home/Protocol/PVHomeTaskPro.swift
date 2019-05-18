//
//  PVHomeTaskPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/14.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import ObjectMapper

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
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .myTask(page: page * 10), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeTaskList>().mapArray(JSONObject: resp["result"]["list"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else { self.dataArr += d }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
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
            self?.page = 0
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .taskAll(page: page * 10), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeTaskList>().mapArray(JSONObject: resp["result"]["list"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else { self.dataArr += d }
                self.tableView.reloadData()
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
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
    
    func didSelectedExchange(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alert = UIAlertController.init(title: nil, message: "交换密码", preferredStyle: .alert)
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
            tf.keyboardType = .numbersAndPunctuation
            tf.borderStyle = .roundedRect
        }
        let confirm = UIAlertAction.init(title: "确定", style: .default) { (ac) in
            self.view.endEditing(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                
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


//MARK: - 历史任务
extension PVHomeHistoryTaskVC {
    
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
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .historyTask(page: page * 10), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVHomeTaskList>().mapArray(JSONObject: resp["result"]["list"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else { self.dataArr += d }
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
