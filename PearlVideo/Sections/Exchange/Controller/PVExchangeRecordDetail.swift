//
//  PVExchangeRecordDetail.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 买单详情
class PVExchangeRecordBuyDetailVC: PVBaseNavigationVC {
    
    var orderId = "" {
        didSet{
            loadData()
        }
    }
    
    
    lazy var headView: PVExchangeRecordBuyDetailView = {
        let v = PVExchangeRecordBuyDetailView.init(frame: .zero)
        return v
    }()
    lazy var cancelBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_btn_weight
        b.setTitle("取消订单", for: .normal)
        b.setTitleColor(kColor_subText, for: .normal)
        b.backgroundColor = kColor_deepBackground
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.borderColor = kColor_subText!.cgColor
        b.layer.borderWidth = 1
        b.addTarget(self, action: #selector(cancelOrder(sender:)), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        view.addSubview(headView)
        view.addSubview(cancelBtn)
        headView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom)
            make.height.equalTo(230 * KScreenRatio_6)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 260 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kIphoneXLatterInsetHeight - 15)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNoti(sender:)), name: .kNotiName_refreshRecordBuyDetail, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

//MARK: - 卖单详情
class PVExchangeRecordSellDetailVC: PVBaseNavigationVC {
    
    var orderId = "" {
        didSet{
            loadData()
        }
    }
    
    lazy var headView: PVExchangeRecordSellDetailView = {
        let v = PVExchangeRecordSellDetailView.init(frame: .zero)
        return v
    }()
    lazy var cancelBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_btn_weight
        b.setTitle("取消订单", for: .normal)
        b.setTitleColor(kColor_subText, for: .normal)
        b.backgroundColor = kColor_deepBackground
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.borderColor = kColor_subText!.cgColor
        b.layer.borderWidth = 1
        b.addTarget(self, action: #selector(cancelOrder(sender:)), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        view.addSubview(headView)
        view.addSubview(cancelBtn)
        headView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom)
            make.height.equalTo(230 * KScreenRatio_6)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 260 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kIphoneXLatterInsetHeight - 15)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNoti(sender:)), name: .kNotiName_refreshRecordSellDetail, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


//MARK: - 交换中详情
class PVExchangeRecordChangingDetailVC: PVBaseNavigationVC {
    
    var uploadImageSuccess: (() -> Void)?
    
    var uploadImageURL: URL?
    
    var type = PVExchangeRecordListState.none
    
    var orderId = ""
    
    
    lazy var contentView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = kColor_deepBackground
        v.showsHorizontalScrollIndicator = false
        v.contentSize = CGSize.init(width: 0, height: 840 * KScreenRatio_6)
        return v
    }()
    lazy var headerView: ChangingDetailHeadView = {
        let v = ChangingDetailHeadView.init(frame: .zero)
        return v
    }()
    lazy var footerView: ChangingFootView = {
        let v = ChangingFootView.init(frame: .zero)
        v.delegate = self
        return v
    }()
    lazy var screenshotView: ChangingScreenshotView = {
        let v = ChangingScreenshotView.init(frame: .zero)
        v.delegate = self
        return v
    }()
    lazy var bottomBtns: ChangingBottomButtons = {
        let v = ChangingBottomButtons.init(frame: .zero)
        v.delegate = self
        return v
    }()
    
    required convenience init(type: PVExchangeRecordListState, orderId: String) {
        self.init()
        initUI()
        self.type = type
        self.orderId = orderId
        headerView.type = type
        footerView.type = type
        bottomBtns.type = type
        switch type {
        case .waitForBuyerPay:  //待买家付款
            bottomBtns.isHidden = true
            contentView.isScrollEnabled = false
            break
            
        case .waitForPay: //待支付
            
            break
            
        case .waitForFruit: //待放平安果
            
            break
            
        case .success: //待收平安果
            bottomBtns.isHidden = true
            contentView.isScrollEnabled = false
            break
            
        case .none: break
            
        default: break
        }
        loadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNoti(sender:)), name: .kNotiName_refreshRecordExchanging, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initUI() {
        view.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(footerView)
        contentView.addSubview(screenshotView)
        view.addSubview(bottomBtns)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.bottom.equalTo(bottomBtns.snp.top)
        }
        headerView.snp.makeConstraints { (make) in
            make.top.width.centerX.equalToSuperview()
            make.height.equalTo(230 * KScreenRatio_6)
        }
        footerView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(250 * KScreenRatio_6)
        }
        screenshotView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(footerView.snp.bottom).offset(10)
            make.height.equalTo(310 * KScreenRatio_6)
        }
        bottomBtns.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
            make.height.equalTo(60 * KScreenRatio_6)
        }
    }
    
    
}
