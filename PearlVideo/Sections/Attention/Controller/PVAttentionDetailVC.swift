//
//  PVAttentionDetailVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/9.
//  Copyright © 2019 equalriver. All rights reserved.
//


class PVAttentionDetailVC: PVBaseViewController {
    
    
    lazy var naviBarView: PVAttentionDetailNaviBar = {
        let v = PVAttentionDetailNaviBar.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(kNavigationBarAndStatusHeight)))
        v.delegate = self
        return v
    }()
    lazy var contentScrollView: UIScrollView = {
        let s = UIScrollView()
        s.isPagingEnabled = true
        s.isScrollEnabled = false
        s.backgroundColor = UIColor.white
        s.contentSize = CGSize.init(width: 0, height: kScreenHeight * 2)
        return s
    }()
    lazy var mainView: PVAttentionDetailMainView = {
        let v = PVAttentionDetailMainView.init(frame: view.bounds)
        v.contentSize = CGSize.init(width: 0, height: kScreenHeight)
        v.pv_delegate = self
        return v
    }()
    lazy var commentHeaderView: PVAttentionDetailCommentHeaderView = {
        let v = PVAttentionDetailCommentHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 80 * KScreenRatio_6))
        return v
    }()
    lazy var commentTableView: UITableView = {
        let tb = UITableView.init(frame: CGRect.init(x: 0, y: kScreenHeight + naviBarView.height, width: kScreenWidth, height: kScreenHeight - naviBarView.height - 50 * KScreenRatio_6), style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = UIColor.white
        tb.dataSource = self
        tb.delegate = self
        tb.register(PVAttentionDetailCommentCell.self, forCellReuseIdentifier: "PVAttentionDetailCommentCell")
        tb.tableHeaderView = commentHeaderView
        return tb
    }()
    lazy var commentInputView: PVAttentionDetailCommentInputView = {
        let v = PVAttentionDetailCommentInputView.init(frame: CGRect.init(x: 0, y: kScreenHeight * 2 - 50 * KScreenRatio_6, width: kScreenWidth, height: 50 * KScreenRatio_6), delegate: self)
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setRefresh()
    }
    
    func initUI() {
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(mainView)
        contentScrollView.addSubview(commentTableView)
        contentScrollView.addSubview(commentInputView)
        view.addSubview(naviBarView)
        contentScrollView.snp.makeConstraints { (make) in
            make.width.centerX.top.equalToSuperview()
            make.height.equalTo(kScreenHeight)
        }
    }
    
}
