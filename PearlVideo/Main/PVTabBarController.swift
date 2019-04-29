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
        tb.playBtn.addTarget(self, action: #selector(didSelectedPlay), for: .touchUpInside)
        return tb
    }()
    
    private let tabTitles = ["首页", "关注", "珍珠", "我的"]
    
    private let tabImages = [UIImage.init(named: "tab_首页"), UIImage.init(named: "tab_关注"), UIImage.init(named: "tab_珍珠"), UIImage.init(named: "tab_我的")]
    
    private let tabSelectedImages = [UIImage.init(named: "tab_首页_s"), UIImage.init(named: "tab_关注_s"), UIImage.init(named: "tab_珍珠_s"), UIImage.init(named: "tab_我的_s")]
    
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
        view.backgroundColor = .white
        
        self.setValue(customTabBar, forKey: "tabBar")
        viewControllers = [homeVC, hotVC, pearlVC, userVC]
        for (index, item) in (viewControllers?.enumerated())! {
            item.tabBarItem.title = tabTitles[index]
            item.tabBarItem.image = tabImages[index]
            item.tabBarItem.selectedImage = tabSelectedImages[index]
        }
        if customTabBar.items != nil {
            for v in customTabBar.items! {
                v.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12 * KScreenRatio_6), .foregroundColor: UIColor.init(patternImage: UIImage.init(named: "gradient_bg")!)], for: UIControl.State.selected)
            }
        }
    }
    
    
    @objc func didSelectedPlay() {
        if let vc = self.selectedViewController {
            let playVC = PVPlayVC()
            vc.present(playVC, animated: true, completion: nil)
        }
    }

    
}


