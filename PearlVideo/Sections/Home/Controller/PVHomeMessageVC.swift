//
//  PVHomeMessageVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/14.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVHomeMessageVC: PVBaseWMPageVC {
    ///通知状态
    var noticeMessageStatus = false
    ///评论状态
    var commentMessageStatus = false
    ///点赞状态
    var thumbupMessageStatus = false
    ///关注状态
    var followMessageStatus = false
    
    override func viewDidLoad() {
        titleSizeNormal = 15 * KScreenRatio_6
        titleSizeSelected = 15 * KScreenRatio_6
        titleColorNormal = kColor_text!
        titleColorSelected = UIColor.white
        progressWidth = 30 * KScreenRatio_6
        menuViewStyle = .line
        
        super.viewDidLoad()
        title = "消息列表"
        view.backgroundColor = kColor_deepBackground
        menuView?.backgroundColor = kColor_background
        scrollView?.backgroundColor = kColor_deepBackground
        
        getMessageStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if noticeMessageStatus {
            refreshStatus(category: "NOTICEMESSAGE")
        }
        if commentMessageStatus {
            refreshStatus(category: "COMMENTMESSAGE")
        }
        if thumbupMessageStatus {
            refreshStatus(category: "THUMBUPMESSAGE")
        }
        if followMessageStatus {
            refreshStatus(category: "FOLLOWMESSAGE")
        }
    }
    
}

//MARK: - 通知
class PVHomeMsgNoticeVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeNoticeMessageList>()
    
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

class PVHomeMsgNoticeDetailVC: PVBaseNavigationVC {
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.backgroundColor = kColor_deepBackground
        tb.register(PVHomeMsgNoticeCell.self, forCellReuseIdentifier: "PVHomeMsgNoticeCell")
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//MARK: - 评论
class PVHomeMsgCommentVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeMessageList>()
    
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
//MARK: - 点赞
class PVHomeMsgLikeVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeMessageList>()
    
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
//MARK: - 关注
class PVHomeMsgAttentionVC: PVBaseViewController {
    
    var dataArr = Array<PVHomeMessageList>()
    
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
