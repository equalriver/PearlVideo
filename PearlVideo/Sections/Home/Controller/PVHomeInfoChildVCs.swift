//
//  PVHomeInfoChildVCs.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 会员等级
class PVHomeUserLevelVC: PVBaseNavigationVC {
    
    var dataArr = Array<PVHomeUserLevelModel>()
    var page = 0
    var infoData = PVHomeCurrentUserLevel()
    
    lazy var headerView: PVHomeUserLevelHeaderView = {
        let v = PVHomeUserLevelHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 180 * KScreenRatio_6))
        v.delegate = self
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
        setRefresh()
        loadData(page: 0)
        loadCurrentInfo()
    }
    
    
    
}

class PVHomeUserLevelDetailVC: PVBaseNavigationVC {
    
    var dataArr = Array<PVHomeUserLevelDetailModel>()
    
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
        title = "会员等级详情"
        view.backgroundColor = kColor_deepBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.centerX.width.bottom.equalToSuperview()
        }
        setRefresh()
        loadData()
    }
    
    
    
}

//MARK: - 活跃度
class PVHomeActivenessVC: PVBaseNavigationVC {
    
    var data = PVHomeActivenessModel()
    var page = 0
    
    
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
        setRefresh()
        loadData(page: 0)
    }
    
    
}


//MARK: - 平安果
class PVHomeFruitVC: PVBaseNavigationVC {
    
    
    var data = PVHomeFruitModel()
    
    var page = 0
    
    
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
        setRefresh()
        loadData(page: 0)
    }
    
}

//MARK: - 商学院
class PVHomeSchoolVC: PVBaseWMPageVC {
    
    
    override func viewDidLoad() {
        titleSizeNormal = 15 * KScreenRatio_6
        titleSizeSelected = 15 * KScreenRatio_6
        titleColorNormal = kColor_text!
        titleColorSelected = UIColor.white
        progressWidth = 30 * KScreenRatio_6
        menuViewStyle = .line
        
        super.viewDidLoad()
        title = "商学院"
        view.backgroundColor = kColor_deepBackground
        menuView?.backgroundColor = kColor_background
        scrollView?.backgroundColor = kColor_deepBackground
    }
    
}

//视频区
class PVHomeSchoolVideoVC: PVBaseViewController {
    
    var page = 0
    
    var dataArr = Array<PVHomeSchoolVideoList>()
    
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
        view.backgroundColor = kColor_deepBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        
        setRefresh()
        loadData(page: page)
    }
}

//新手指南
class PVHomeSchoolGuideVC: PVBaseViewController {
    
    var page = 0
    
    var dataArr = Array<PVHomeSchoolGuideList>()
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_deepBackground
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.register(PVHomeSchoolGuideCell.self, forCellReuseIdentifier: "PVHomeSchoolGuideCell")
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kColor_deepBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        
        setRefresh()
        loadData(page: page)
    }
    
}
