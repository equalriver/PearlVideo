//
//  PVExchangeVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/27.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVExchangeVC: PVBaseNavigationVC {
    
    lazy var segment: UISegmentedControl = {
        let s = UISegmentedControl.init(items: ["我要买", "我要卖"])
        if #available(iOS 11.0, *) { s.isSpringLoaded = true }
        s.backgroundColor = kColor_deepBackground
        s.tintColor = kColor_pink
        s.addTarget(self, action: #selector(segmentAction(sender:)), for: .valueChanged)
        return s
    }()
    lazy var recordBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("交换记录", for: .normal)
        b.setTitleColor(kColor_pink, for: .normal)
        return b
    }()
    lazy var headerView: PVExchangeHeaderView = {
        let v = PVExchangeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 170 * KScreenRatio_6))
        v.backgroundColor = kColor_deepBackground
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
        title = "交换中心"
        naviBar.rightBarButtons = [recordBtn]
    }
    
    func initUI() {
        view.addSubview(segment)
        view.addSubview(tableView)
    }
    
    @objc func segmentAction(sender: UISegmentedControl) {
        
    }
    
}
