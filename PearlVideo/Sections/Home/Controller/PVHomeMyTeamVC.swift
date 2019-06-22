//
//  PVHomeMyTeamVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVHomeMyTeamVC: PVBaseWMPageVC {
    
    let items = ["全部队员", "实名队员", "未实名队员"]
    
    public var data: PVHomeTeamModel! {
        didSet{
            headerView.data = data
        }
    }
    
    lazy var inviteBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("团队招募", for: .normal)
        b.setTitleColor(kColor_yellow, for: .normal)
        return b
    }()
    lazy var headerView: PVHomeMyTeamHeaderView = {
        let v = PVHomeMyTeamHeaderView.init(frame: CGRect.init(x: 0, y: kNavigationBarAndStatusHeight, width: kScreenWidth, height: 150 * KScreenRatio_6))
        v.backgroundColor = kColor_deepBackground
        return v
    }()
    
    override func viewDidLoad() {
        
        titleSizeNormal = 15 * KScreenRatio_6
        titleSizeSelected = 15 * KScreenRatio_6
        titleColorNormal = kColor_text!
        titleColorSelected = UIColor.white
        progressWidth = 30 * KScreenRatio_6
        progressColor = UIColor.white
        menuViewStyle = .line
        menuItemWidth = kScreenWidth / CGFloat(items.count)
        
        super.viewDidLoad()
        title = "我的团队"
        naviBar.rightBarButtons = [inviteBtn]
        view.backgroundColor = kColor_deepBackground
        menuView?.backgroundColor = kColor_deepBackground
        scrollView?.backgroundColor = kColor_deepBackground
        view.addSubview(headerView)
        NotificationCenter.default.addObserver(self, selector: #selector(userValidateNoti(sender:)), name: .kNotiName_userValidateSuccess, object: nil)
        loadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

//MARK: - 全部队员
class PVHomeMyTeamAllVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeTeamList>()
    
    var page = 0
    var nextPage = ""
    
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
        setRefresh()
        loadData(page: 0)
    }
    
}

//MARK: - 实名队员
class PVHomeMyTeamAuthVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeTeamList>()
    
    var page = 0
    var nextPage = ""
    
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
        setRefresh()
        loadData(page: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(userValidateNoti(sender:)), name: .kNotiName_userValidateSuccess, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

//MARK: - 未实名队员
class PVHomeMyTeamNotAuthVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeTeamList>()
    
    var page = 0
    var nextPage = ""
    
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
        setRefresh()
        loadData(page: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(userValidateNoti(sender:)), name: .kNotiName_userValidateSuccess, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
