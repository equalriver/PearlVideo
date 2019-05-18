//
//  PVHomeVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVHomeVC: PVBaseWMPageVC {
    
    let items = ["推荐", "关注"]
    
    let headerViewHeight = 420 * KScreenRatio_6
    let safeInset = 10 * KScreenRatio_6
    
    public var data: PVHomeModel!

    lazy var msgBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "home_msg"), for: .normal)
        b.addTarget(self, action: #selector(messageAction), for: .touchUpInside)
        return b
    }()
    lazy var headerView: PVHomeHeaderView = {
        let v = PVHomeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: headerViewHeight))
        v.delegate = self
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var recommendVC: PVHomeRecommendVC = {
        let vc = PVHomeRecommendVC()
        vc.delegate = self
        return vc
    }()
    lazy var attentionVC: PVHomeAttentionVC = {
        let vc = PVHomeAttentionVC()
        vc.delegate = self
        return vc
    }()
    lazy var contentScrollView: UIScrollView = {
        let v = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        v.backgroundColor = kColor_deepBackground
        v.contentSize = CGSize.init(width: 0, height: headerViewHeight + kScreenHeight - kTabBarHeight - safeInset)
        v.showsVerticalScrollIndicator = false
        v.delegate = self
        v.scrollsToTop = false
        v.bounces = false
        return v
    }()
    
    override func loadView() {
        view = contentScrollView
    }
    
    override func viewDidLoad() {
        titleSizeNormal = 18 * KScreenRatio_6
        titleSizeSelected = 18 * KScreenRatio_6
        titleColorNormal = kColor_text!
        titleColorSelected = UIColor.white
        menuViewStyle = .line
        menuItemWidth = 50 * KScreenRatio_6
        menuViewContentMargin = 50 * KScreenRatio_6
        progressWidth = 30 * KScreenRatio_6
        
        super.viewDidLoad()
        initUI()
        setRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if data == nil {
            loadData()
        }
    }
    
    func initUI() {
        view.backgroundColor = kColor_background
        view.addSubview(headerView)
        view.addSubview(msgBtn)
        msgBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.right.equalTo(headerView).offset(-15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        naviBar.isHidden = true
        menuView?.backgroundColor = kColor_background
        scrollView?.backgroundColor = kColor_background
    }
}
