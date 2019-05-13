//
//  PVHomeMyTeamVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVHomeMyTeamVC: PVBaseWMPageVC {
    
    lazy var inviteBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("邀请好友", for: .normal)
        b.setTitleColor(kColor_yellow, for: .normal)
        return b
    }()
    
    
    override func viewDidLoad() {
        
        titleSizeNormal = 15 * KScreenRatio_6
        titleSizeSelected = 15 * KScreenRatio_6
        titleColorNormal = kColor_text!
        titleColorSelected = UIColor.white
        progressWidth = 30 * KScreenRatio_6
        
        super.viewDidLoad()
        title = "我的团队"
        naviBar.rightBarButtons = [inviteBtn]
        
    }
    
}

//MARK: - 全部队员
class PVHomeMyTeamAllVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = kColor_deepBackground
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerY.centerX.equalToSuperview()
        }
    }
    
}

//MARK: - 实名队员
class PVHomeMyTeamAuthVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = kColor_deepBackground
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerY.centerX.equalToSuperview()
        }
    }
    
}

//MARK: - 未实名队员
class PVHomeMyTeamNotAuthVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = kColor_deepBackground
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerY.centerX.equalToSuperview()
        }
    }
    
}
