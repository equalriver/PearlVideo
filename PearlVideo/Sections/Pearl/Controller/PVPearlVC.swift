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
        b.setImage(UIImage.init(named: "pearl_规则"), for: .normal)
        return b
    }()
    lazy var headerView: PVPearlHeaderView = {
        let v = PVPearlHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 370 * KScreenRatio_6))
        v.delegate = self
        return v
    }()
    lazy var sectionHeaderView: PVPearlSectionHeaderView = {
        let v = PVPearlSectionHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 170 * KScreenRatio_6))
        v.delegate = self
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

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "贝壳喂养"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviBar.backgroundColor = UIColor.init(hexString: "#DAEEF4")
        naviBar.isNeedBackButton = false
        naviBar.rightBarButtons = [ruleBtn]
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.width > 0 {
            tableView.tableHeaderView = headerView
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        view.stateUnlogin(title: "登录可喂养珍珠", img: nil)
//    }

}
