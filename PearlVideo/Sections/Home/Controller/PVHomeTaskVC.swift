//
//  PVHomeTaskVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVHomeTaskVC: PVBaseWMPageVC {
    
    override func viewDidLoad() {
        titleSizeNormal = 15 * KScreenRatio_6
        titleSizeSelected = 15 * KScreenRatio_6
        titleColorNormal = kColor_text!
        titleColorSelected = UIColor.white
        progressWidth = 30 * KScreenRatio_6
        
        super.viewDidLoad()
        title = "任务书卷"
        view.backgroundColor = kColor_deepBackground
        menuView?.backgroundColor = kColor_background
        scrollView?.backgroundColor = kColor_deepBackground
    }
    
    
}

//MARK: - 我的任务
class PVHomeMyTaskVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeTaskList>()
    
    var page = 0
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.backgroundColor = kColor_deepBackground
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        setRefresh()
        loadData(page: 0)
    }
    
}

//MARK: - 任务书卷
class PVHomeAllTaskVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeTaskList>()
    
    var page = 0
    
    //交换密码
    var exchangePsd = ""
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.backgroundColor = kColor_deepBackground
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        setRefresh()
        loadData(page: 0)
    }
    
}

//MARK: - 历史任务
class PVHomeHistoryTaskVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeTaskList>()
    
    var page = 0
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.backgroundColor = kColor_deepBackground
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        setRefresh()
        loadData(page: 0)
    }
    
}
