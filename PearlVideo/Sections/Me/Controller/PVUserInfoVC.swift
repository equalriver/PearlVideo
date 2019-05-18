//
//  PVUserInfoVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit


class PVUserInfoVC: PVBaseWMPageVC {

    var isShowMoreList = false {
        didSet{
            UIView.animate(withDuration: 0.3) {
                self.forceLayoutSubviews()
            }
        }
    }
    
    
    lazy var shareBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "me_share"), for: .normal)
        return b
    }()
    lazy var headerView: PVUserInfoView = {
        let v = PVUserInfoView.init(frame: .zero)
        v.delegate = self
        return v
    }()
    
    
    override func viewDidLoad() {
  
        titleColorNormal = kColor_subText!
        titleColorSelected = kColor_text!
   
        progressWidth = 35 * KScreenRatio_6
        menuViewStyle = .line
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        naviBar.rightBarButtons = [shareBtn]
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 330 * KScreenRatio_6))
            make.top.equalTo(naviBar.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }

    

}
