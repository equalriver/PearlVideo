//
//  PVMeViewController.swift


import UIKit
import ObjectMapper

class PVMeViewController: PVBaseWMPageVC {
    
    var panOffsetY: CGFloat = 0
    
    let headerViewHeight: CGFloat = 430 * KScreenRatio_6
    let safeInset = 10 * KScreenRatio_6
    
    lazy var contentScrollView: UIScrollView = {
        let v = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        v.backgroundColor = kColor_deepBackground
        v.contentSize = CGSize.init(width: 0, height: headerViewHeight + kScreenHeight - kTabBarHeight - kNavigationBarAndStatusHeight)
        v.showsVerticalScrollIndicator = false
        v.delegate = self
        v.scrollsToTop = false
        return v
    }()
    lazy var settingBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "me_设置"), for: .normal)
        return b
    }()
    lazy var headerView: PVMeHeaderView = {
        let v = PVMeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: headerViewHeight))
        v.backgroundColor = kColor_background
        v.delegate = self
        return v
    }()
    lazy var effectView: UIVisualEffectView = {
        let blur = UIBlurEffect.init(style: .light)
        let e = UIVisualEffectView.init(effect: blur)
        e.alpha = 0
        e.frame = naviBar.bounds
        return e
    }()
    lazy var productionVC: PVMeProductionVC = {
        let vc = PVMeProductionVC()
        vc.delegate = self
        return vc
    }()
    //life cycle
    override func loadView() {
        view = contentScrollView
    }
    
    override func viewDidLoad() {
        titleSizeNormal = 18 * KScreenRatio_6
        titleSizeSelected = 18 * KScreenRatio_6
        titleColorNormal = kColor_text!
        titleColorSelected = kColor_pink!
        menuViewStyle = .line
        progressWidth = 30 * KScreenRatio_6
        
        super.viewDidLoad()
        initUI()
        title = "我的"
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNotification), name: .kNotiName_refreshMeVC, object: nil)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.addSubview(naviBar)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        naviBar.removeFromSuperview()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
   
    func initUI() {
        naviBar.isNeedBackButton = false
        naviBar.backgroundColor = UIColor.clear
        naviBar.rightBarButtons = [settingBtn]
        naviBar.removeFromSuperview()
        naviBar.addSubview(effectView)
        naviBar.insertSubview(effectView, belowSubview: naviBar.titleView)
        
        view.backgroundColor = kColor_deepBackground
        view.addSubview(headerView)
        menuView?.backgroundColor = kColor_background
        scrollView?.backgroundColor = kColor_deepBackground
    }

    
}

