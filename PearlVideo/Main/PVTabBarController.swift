//
//  PVTabBarController.swift


class PYTabBar: UITabBar {
    
    public lazy var playBtn: UIButton = {
        let b = UIButton()
        b.adjustsImageWhenHighlighted = false
        b.setImage(UIImage.init(named: "tab_play"), for: .normal)
        return b
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var index = 0
        guard NSClassFromString("UITabBarButton") != nil else { return }
        let arr = subviews.sorted { (v1, v2) -> Bool in
            return v1.origin.x < v2.origin.x
        }
        for v in arr {
            if v.isKind(of: NSClassFromString("UITabBarButton")!) {
                
                v.frame = CGRect.init(x: CGFloat(index) * kScreenWidth / 5, y: v.origin.y, width: kScreenWidth / 5, height: v.height)
                index += 1
                for obj in v.subviews { obj.backgroundColor = kColor_deepBackground }
                
                if index == 2 {
                    playBtn.frame = CGRect.init(x: CGFloat(index) * kScreenWidth / 5, y: v.origin.y, width: kScreenWidth / 5, height: v.height)
                    index += 1
                }
            }
        }
        
    }
    
}

class PVTabBarController: UITabBarController {
    
    private lazy var customTabBar: PYTabBar = {
        let tb = PYTabBar.init()
        tb.isTranslucent = false
        tb.barTintColor = kColor_deepBackground
        tb.playBtn.addTarget(self, action: #selector(didSelectedPlay), for: .touchUpInside)
        return tb
    }()
    
    private let tabTitles = ["首页", "活动中心", "交换中心", "我的"]
    
    private let tabImages = [UIImage.init(named: "tab_首页"), UIImage.init(named: "tab_活动中心"), UIImage.init(named: "tab_交换"), UIImage.init(named: "tab_我的")]
    
    private let tabSelectedImages = [UIImage.init(named: "tab_首页_s"), UIImage.init(named: "tab_活动中心_s"), UIImage.init(named: "tab_交换_s"), UIImage.init(named: "tab_我的_s")]
    
    private lazy var homeVC: PVBaseRootNaviVC = {
        let vc = PVBaseRootNaviVC.init(rootViewController: PVHomeVC())
        return vc
    }()

    private lazy var hotVC: PVBaseRootNaviVC = {
        let vc = PVBaseRootNaviVC.init(rootViewController: PVAttentionVC())
        return vc
    }()

    private lazy var pearlVC: PVBaseRootNaviVC = {
        let vc = PVBaseRootNaviVC.init(rootViewController: PVPearlVC())
        return vc
    }()

    private lazy var userVC: PVBaseRootNaviVC = {
        let vc = PVBaseRootNaviVC.init(rootViewController: PVMeViewController())
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kColor_deepBackground
        
        self.setValue(customTabBar, forKey: "tabBar")
        viewControllers = [homeVC, hotVC, pearlVC, userVC]
        for (index, item) in (viewControllers?.enumerated())! {
            item.tabBarItem.title = tabTitles[index]
            item.tabBarItem.image = tabImages[index]
            item.tabBarItem.selectedImage = tabSelectedImages[index]
        }
        
    }
    
    
    @objc func didSelectedPlay() {
        if let vc = self.selectedViewController {
            let playVC = PVPlayVC()
            vc.present(playVC, animated: true, completion: nil)
        }
    }

    
}


