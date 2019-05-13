//
//  PVHomeInfoChildVCs.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 会员等级
class PVHomeUserLevelVC: PVBaseNavigationVC {
    
    
    lazy var headerView: PVHomeUserLevelHeaderView = {
        let v = PVHomeUserLevelHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 170 * KScreenRatio_6))
        return v
    }()
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
        title = "等级"
        view.backgroundColor = kColor_deepBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.centerX.width.bottom.equalToSuperview()
        }
    }
    
    
    
}

//MARK: - 活跃度
class PVHomeActivenessVC: PVBaseNavigationVC {
    
    
    lazy var headerView: PVHomeActivenessHeaderView = {
        let v = PVHomeActivenessHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 170 * KScreenRatio_6))
        return v
    }()
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
        title = "活跃度"
        view.backgroundColor = kColor_deepBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.centerX.width.bottom.equalToSuperview()
        }
    }
    
    
}


//MARK: - 平安果
class PVHomeFruitVC: PVBaseNavigationVC {
    
    
    lazy var headerView: PVHomeActivenessHeaderView = {
        let v = PVHomeActivenessHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 170 * KScreenRatio_6))
        v.activenessBtn.setImage(UIImage.init(named: "home_fruit"), for: .normal)
        v.activenessBtn.setTitle("当前活跃度", for: .normal)
        return v
    }()
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
        title = "平安果"
        view.backgroundColor = kColor_deepBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.centerX.width.bottom.equalToSuperview()
        }
    }
    
}

