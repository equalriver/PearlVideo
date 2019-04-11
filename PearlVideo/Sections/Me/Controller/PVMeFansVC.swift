//
//  PVMeFansVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeFansVC: PVBaseNavigationVC {

    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
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
        
    }
    
}


extension PVMeFansVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeAttentionCell") as? PVMeAttentionCell
        if cell == nil {
            cell = PVMeAttentionCell.init(style: .default, reuseIdentifier: "PVMeAttentionCell")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }
}
