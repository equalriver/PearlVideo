//
//  PVMeViewController.swift


import UIKit
import ObjectMapper

class PVMeViewController: PVBaseWMPageVC {
    
    
    var isShowMoreList = false {
        didSet{
            UIView.animate(withDuration: 0.3) {
                self.headerView.origin.y = self.isShowMoreList ? -self.headerViewHeight : 0
                self.forceLayoutSubviews()
            }
        }
    }
    
    let headerViewHeight: CGFloat = 430 * KScreenRatio_6
    

    lazy var headerView: PVMeHeaderView = {
        let v = PVMeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: headerViewHeight))
        v.backgroundColor = kColor_background
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(headerViewPanAction(pan:)))
        pan.maximumNumberOfTouches = 1
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(pan)
        return v
    }()
    

    //life cycle
    override func viewDidLoad() {
        
        titleSizeNormal = 18 * KScreenRatio_6
        titleSizeSelected = 18 * KScreenRatio_6
        titleColorNormal = kColor_text!
        titleColorSelected = kColor_pink!
        menuViewStyle = .line
        progressWidth = 30 * KScreenRatio_6
        
        super.viewDidLoad()
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNotification), name: .kNotiName_refreshMeVC, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
   
    func initUI() {
        naviBar.isHidden = true
//        naviBar.isNeedBackButton = false
//        naviBar.titleView.isHidden = true
//        naviBar.backgroundColor = UIColor.clear
        view.backgroundColor = kColor_deepBackground
        view.addSubview(headerView)
        menuView?.backgroundColor = kColor_background
        scrollView?.backgroundColor = kColor_deepBackground
    }

}

