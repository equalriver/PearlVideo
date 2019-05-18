//
//  PVMeTeamVCChild.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 我推荐的
class PVMeTeamMeCommendVC: PVBaseViewController {
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = kColor_background
        tb.dataSource = self
        tb.delegate = self
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 10 * KScreenRatio_6))
        v.backgroundColor = kColor_background
        tb.tableHeaderView = v
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

//MARK: - 好友推荐
class PVMeTeamFriendCommendVC: PVBaseViewController {
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = kColor_background
        tb.dataSource = self
        tb.delegate = self
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 10 * KScreenRatio_6))
        v.backgroundColor = kColor_background
        tb.tableHeaderView = v
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


//MARK: - 认证
class PVMeTeamAuthVC: PVBaseViewController {
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = kColor_background
        tb.dataSource = self
        tb.delegate = self
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 10 * KScreenRatio_6))
        v.backgroundColor = kColor_background
        tb.tableHeaderView = v
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


//MARK: - 认证popover
protocol PVMeTeamAuthPopoverDelegate: NSObjectProtocol {
    func didSelectedPopoverItem(index: Int)
}

class PVMeTeamAuthPopoverVC: PVBaseViewController {
    
    weak public var delegate: PVMeTeamAuthPopoverDelegate?
    
    public var currentIndex = 0
    
    let items = ["已认证", "未认证"]
    
    lazy var tableView: UITableView = {
        let t = UITableView.init(frame: CGRect.zero, style: .plain)
        t.separatorStyle = .none
        t.dataSource = self
        t.delegate = self
        t.showsVerticalScrollIndicator = false
        return t
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}





