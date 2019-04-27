//
//  PVPearlVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit


class PVPearlVC: PVBaseNavigationVC {
    
    
    lazy var ruleBtn: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.titleLabel?.font = kFont_text_3
        b.setTitle("规则", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 12.5
        b.layer.masksToBounds = true
        return b
    }()
    lazy var headerView: PVPearlHeaderView = {
        let v = PVPearlHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 370 * KScreenRatio_6))
        v.delegate = self
        return v
    }()
    lazy var sectionHeaderView: PVPearlSectionHeaderView = {
        let v = PVPearlSectionHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 120 * KScreenRatio_6))
        v.delegate = self
        return v
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.tableHeaderView = headerView
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "贝壳喂养"
        naviBar.backgroundColor = UIColor.init(hexString: "#DAEEF4")
        naviBar.leftBarButtons = [ruleBtn]
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.stateUnlogin(title: "登录可喂养珍珠", img: nil)
    }

}
