//
//  PVMeFansVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/5.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

class PVMeFansVC: PVBaseNavigationVC {
    
    public var userId = ""
    
    var page = 0
    var dataArr = Array<PVMeAttentionModel>()
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_deepBackground
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的粉丝"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.bottom.width.centerX.equalToSuperview()
        }
        
        setRefresh()
        loadData(page: 0)
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
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .attentionAndFansList(type: 2, userId: userId, content: "", page: page * 10), success: { (resp) in
            self.tableView.mj_footer.endRefreshing()
            if let d = Mapper<PVMeAttentionModel>().mapArray(JSONObject: resp["result"]["followUserProfileList"].arrayObject) {
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


extension PVMeFansVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeFansCell") as? PVMeFansCell
        if cell == nil {
            cell = PVMeFansCell.init(style: .default, reuseIdentifier: "PVMeFansCell")
        }
        cell?.delegate = self
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
    
}

extension PVMeFansVC: PVMeFansDelegate {
    
    func didSelectedAttention(cell: PVMeFansCell, sender: UIButton) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        sender.isEnabled = false
        let action = dataArr[indexPath.row].isFollow ? 1 : 2
        PVNetworkTool.Request(router: .attention(id: userId, action: action), success: { (resp) in
            sender.isEnabled = true
            self.dataArr[indexPath.row].isFollow = !self.dataArr[indexPath.row].isFollow
            self.tableView.reloadRow(at: indexPath, with: .none)
            
        }) { (e) in
            sender.isEnabled = true
        }
    }
}
