//
//  PVPearlUserLevelVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVPearlUserLevelVC: PVBaseNavigationVC {
    
    
    lazy var levelLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18 * KScreenRatio_6)
        l.textColor = UIColor.white
        return l
    }()
    lazy var XPLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
    }()
    lazy var remindLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = UIColor.white
        return l
    }()
    lazy var headerView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 170 * KScreenRatio_6))
        v.backgroundColor = UIColor.white
        
        let iv = UIImageView.init(image: UIImage.init(named: "pearl_userLevel_bg"))
        iv.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 150 * KScreenRatio_6)
        v.addSubview(iv)
        
        let cornerView = UIView.init(frame: CGRect.init(x: 0, y: 150 * KScreenRatio_6, width: kScreenWidth, height: 20 * KScreenRatio_6))
        cornerView.backgroundColor = UIColor.white
        
        let b = UIBezierPath.init(roundedRect: cornerView.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize.init(width: 10 * KScreenRatio_6, height: 10 * KScreenRatio_6))
        let l = CAShapeLayer.init()
        l.frame = cornerView.bounds
        v.addSubview(cornerView)
        return v
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "会员等级"
        initUI()
        
    }

    func initUI() {
        headerView.addSubview(levelLabel)
        headerView.addSubview(XPLabel)
        headerView.addSubview(remindLabel)
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        levelLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
        }
        XPLabel.snp.makeConstraints { (make) in
            make.left.equalTo(levelLabel)
            make.top.equalTo(levelLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        remindLabel.snp.makeConstraints { (make) in
            make.left.equalTo(levelLabel)
            make.top.equalTo(XPLabel.snp.bottom).offset(25 * KScreenRatio_6)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
    }

}

extension PVPearlUserLevelVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVPearlUserLevelCell") as? PVPearlUserLevelCell
        if cell == nil {
            cell = PVPearlUserLevelCell.init(style: .default, reuseIdentifier: "PVPearlUserLevelCell")
        }
        
        return cell!
    }
    
}
