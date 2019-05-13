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
    
    public var data: PVHomeModel!
    
    var isShowMoreList = false {
        didSet{
            recommendVC.isShowMoreView = isShowMoreList
            
            UIView.animate(withDuration: 0.3) {
                self.headerView.origin.y = self.isShowMoreList ? -self.headerViewHeight : 0
                self.forceLayoutSubviews()
            }
        }
    }
    
    lazy var headerView: PVHomeHeaderView = {
        let v = PVHomeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: headerViewHeight))
        v.delegate = self
        v.backgroundColor = kColor_background
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(headerViewPanAction(pan:)))
        pan.maximumNumberOfTouches = 1
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(pan)
        return v
    }()
    lazy var recommendVC: PVHomeRecommendVC = {
        let vc = PVHomeRecommendVC()
        vc.delegate = self
        return vc
    }()
    
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
        view.backgroundColor = kColor_background
        view.addSubview(headerView)
        naviBar.isHidden = true
        menuView?.backgroundColor = kColor_background
        scrollView?.backgroundColor = kColor_background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if data == nil {
            loadData()
        }
    }
}
