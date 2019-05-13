//
//  PVHomeSchoolVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/13.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - 商学院
class PVHomeSchoolVC: PVBaseWMPageVC {
    
    
    override func viewDidLoad() {
        titleSizeNormal = 15 * KScreenRatio_6
        titleSizeSelected = 15 * KScreenRatio_6
        titleColorNormal = kColor_text!
        titleColorSelected = UIColor.white
        progressWidth = 30 * KScreenRatio_6
        
        super.viewDidLoad()
        view.backgroundColor = kColor_deepBackground
        menuView?.backgroundColor = kColor_background
        scrollView?.backgroundColor = kColor_deepBackground
    }
    
}

//视频区
class PVHomeSchoolVideoVC: UIViewController {
    
    var page = 1
    
    var dataArr = [""]
    
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
class PVHomeSchoolGuideVC: UIViewController {
    
    var page = 1
    
    var dataArr = [""]
    
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
