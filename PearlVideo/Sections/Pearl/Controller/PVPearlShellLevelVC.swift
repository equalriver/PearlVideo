//
//  PVPearlShellLevelVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVPearlShellLevelVC: PVBaseNavigationVC {
    
    
    lazy var headerView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 170 * KScreenRatio_6))
        v.backgroundColor = UIColor.white
        return v
    }()
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
        title = "贝壳等级"
        initUI()
        
    }
    
    func initUI() {
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
    }

    
}

extension PVPearlShellLevelVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVPearlUserLevelCell") as? PVPearlUserLevelCell
        if cell == nil {
            cell = PVPearlUserLevelCell.init(style: .default, reuseIdentifier: "PVPearlUserLevelCell")
        }
        
        return cell!
    }
    
}
