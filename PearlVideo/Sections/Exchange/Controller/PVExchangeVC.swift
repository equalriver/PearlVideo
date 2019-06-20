//
//  PVExchangeVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/27.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVExchangeSearchVC: PYSearchViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard navigationController != nil else { return }
        for v in navigationController!.navigationBar.subviews {
            v.backgroundColor = kColor_deepBackground
        }
    }
}

class PVExchangeVC: PVBaseNavigationVC {
    
    var isBuyOrderView = true
    
    var isLoadingMore = false
    
    let threshold: CGFloat = 0.6
    let itemPerPage = 10   //每页条数
    var page = 0
    var nextPage = ""
    
    var dataArr = Array<PVExchangeOrderList>()
    var searchArr = Array<PVExchangeOrderList>()
    var data = PVExchangeInfoModel()
    
    
    lazy var segment: UISegmentedControl = {
        let s = UISegmentedControl.init(items: ["我要买", "我要卖"])
        if #available(iOS 11.0, *) { s.isSpringLoaded = true }
        s.backgroundColor = kColor_deepBackground
        s.tintColor = kColor_pink
        s.selectedSegmentIndex = 0
        s.setTitleTextAttributes([.font: kFont_text_2, .foregroundColor: kColor_subText!], for: .normal)
        s.setTitleTextAttributes([.font: kFont_text_2, .foregroundColor: UIColor.white], for: .selected)
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
    lazy var sectionView: PVExchangeHeaderSectionView = {
        let v = PVExchangeHeaderSectionView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 40 * KScreenRatio_6))
        v.delegate = self
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
    lazy var searchVC: PVExchangeSearchVC = {
        let vc = PVExchangeSearchVC.init(hotSearches: nil, searchBarPlaceholder: "请输入对方账号")
        vc!.delegate = self
        vc!.dataSource = self
        vc?.showSearchHistory = false
        vc?.searchBar.returnKeyType = UIReturnKeyType.search
        vc?.searchBar.setImage(UIImage.init(named: "ex_搜索"), for: UISearchBar.Icon.search, state: .normal)
        vc?.searchTextField.textColor = UIColor.white
        vc?.searchTextField.attributedPlaceholder = NSAttributedString.init(string: "请输入对方账号", attributes: [.font: kFont_text_2_weight, .foregroundColor: kColor_subText!])
        vc?.searchBarCornerRadius = kCornerRadius
        vc?.searchBarBackgroundColor = kColor_deepBackground
        vc?.view.backgroundColor = kColor_deepBackground
        vc?.cancelButton.backgroundColor = kColor_deepBackground
        vc?.cancelButton.setTitleColor(kColor_text, for: .normal)
        return vc!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "交换中心"
        naviBar.rightBarButtons = [recordBtn]
        naviBar.isNeedBackButton = false
        initUI()
        setRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dataArr.count == 0 { loadData(page: 0) }
        if data.maxPrice == 0 { loadInfoData() }
    }
    
    func initUI() {
        view.addSubview(segment)
        view.addSubview(tableView)
        segment.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 250 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom).offset(15 * KScreenRatio_6)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(segment.snp.bottom).offset(15 * KScreenRatio_6)
            make.centerX.width.bottom.equalToSuperview()
        }
    }
    
    
}
