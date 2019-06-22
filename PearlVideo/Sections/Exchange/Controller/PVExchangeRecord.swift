//
//  PVExchangeRecord.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVExchangeRecordVC: PVBaseWMPageVC {
    
    let items = ["买单", "卖单", "交换中", "已完成"]
    
    
    override func viewDidLoad() {
        titleSizeNormal = 18 * KScreenRatio_6
        titleSizeSelected = 18 * KScreenRatio_6
        titleColorNormal = UIColor.white
        titleColorSelected = kColor_pink!
        menuViewStyle = .line
        progressWidth = 30 * KScreenRatio_6
        menuItemWidth = kScreenWidth / CGFloat(items.count)
        super.viewDidLoad()
        title = "交换记录"
        
    }
    
    
}

//MARK: - 买单
class PVExchangeRecordBuyVC: PVBaseViewController {
    
    var page = 0
    var dataArr = Array<PVExchangeRecordList>()
    var nextPage = ""
    
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        setRefresh()
        loadData(page: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNoti(sender:)), name: .kNotiName_refreshRecordBuy, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

//MARK: - 卖单
class PVExchangeRecordSellVC: PVBaseViewController {
    
    var page = 0
    var dataArr = Array<PVExchangeRecordList>()
    var nextPage = ""
    
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        setRefresh()
        loadData(page: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNoti(sender:)), name: .kNotiName_refreshRecordSell, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - 交换中
class PVExchangeRecordExchangingVC: PVBaseViewController {
    
    var page = 0
    var dataArr = Array<PVExchangeRecordList>()
    var nextPage = ""
    
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        setRefresh()
        loadData(page: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNoti(sender:)), name: .kNotiName_refreshRecordExchanging, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - 已完成
class PVExchangeRecordFinishVC: PVBaseViewController {
    
    var page = 0
    var dataArr = Array<PVExchangeRecordList>()
    var nextPage = ""
    
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        setRefresh()
        loadData(page: 0)
    }
    
}
