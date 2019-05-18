//
//  PVAttentionCommentDetailVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVAttentionCommentDetailVC: PVBaseViewController {
    
    lazy var naviTitleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.textAlignment = .center
        return l
    }()
    lazy var dismissBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "attention_close"), for: .normal)
        b.addTarget(self, action: #selector(dismissAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var sepView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var headerView: PVAttentionCommentDetailHeaderView = {
        let v = PVAttentionCommentDetailHeaderView.init(frame: .zero, delegate: self)
        return v
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.register(PVAttentionCommentDetailCell.self, forCellReuseIdentifier: "PVAttentionCommentDetailCell")
        return tb
    }()
    lazy var commentInputView: PVAttentionDetailCommentInputView = {
        let v = PVAttentionDetailCommentInputView.init(frame: CGRect.init(x: 0, y: kScreenHeight - 50 * KScreenRatio_6, width: kScreenWidth, height: 50 * KScreenRatio_6), delegate: self)
        v.delegate = self
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    func initUI() {
        view.addSubview(naviTitleLabel)
        view.addSubview(dismissBtn)
        view.addSubview(sepView)
        view.addSubview(tableView)
        view.addSubview(commentInputView)
        naviTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        dismissBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(naviTitleLabel)
            make.size.equalTo(CGSize.init(width: 30 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-10)
        }
        sepView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 0.5))
            make.centerX.equalToSuperview()
            make.top.equalTo(naviTitleLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(sepView.snp.bottom)
            make.centerX.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50 * KScreenRatio_6)
        }
    }

}
