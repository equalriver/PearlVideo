//
//  PVMeMessageVCChild.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/4.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - 通知
class PVMeMessageNoticeVC: PVBaseViewController {
    
   
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_background
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
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


//MARK: - 评论
class PVMeMessageCommentVC: PVBaseViewController {
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_background
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
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


//MARK: - 点赞
class PVMeMessageLikeVC: PVBaseViewController {
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_background
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
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


//MARK: - 关注
class PVMeMessageAttentionVC: PVBaseViewController {
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_background
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
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
