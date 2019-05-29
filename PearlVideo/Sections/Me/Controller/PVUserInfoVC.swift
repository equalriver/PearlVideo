//
//  PVUserInfoVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit


class PVUserInfoVC: PVBaseWMPageVC {

    var data = PVMeModel()
    
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
    lazy var headerView: PVMeHeaderView = {
        let v = PVMeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: headerViewHeight))
        v.backgroundColor = kColor_background
        v.delegate = self
        return v
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
        
        super.viewDidLoad()
        initUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.addSubview(naviBar)
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        naviBar.removeFromSuperview()
    }
    
    func initUI() {
        naviBar.isNeedBackButton = false
        naviBar.backgroundColor = UIColor.clear
        view.backgroundColor = kColor_deepBackground
        view.addSubview(headerView)
        menuView?.backgroundColor = kColor_background
        scrollView?.backgroundColor = kColor_deepBackground
    }
    

}
