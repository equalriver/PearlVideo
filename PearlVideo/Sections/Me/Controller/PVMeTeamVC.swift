//
//  PVMeTeamVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/8.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeTeamVC: PVBaseWMPageVC {
    
    var popoverIndex = 0
    
    
    lazy var popBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "back_arrow"), for: .normal)
        b.addTarget(self, action: #selector(popAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var headerIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "me_team_bg"))
        return iv
    }()
    lazy var teamCountLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        return l
    }()
    lazy var meRecommendBtn: UIButton = {
        let b = UIButton()
        b.setTitle("我推荐的", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.setTitleColor(UIColor.init(hexString: "#6654C6"), for: .selected)
        b.setBackgroundImage(UIImage.init(color: UIColor.clear), for: .normal)
        b.setBackgroundImage(UIImage.init(color: UIColor.white), for: .selected)
        b.layer.cornerRadius = 15 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.white.cgColor
        b.addTarget(self, action: #selector(meRecommend(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var friendRecommendBtn: UIButton = {
        let b = UIButton()
        b.setTitle("好友推荐", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.setTitleColor(UIColor.init(hexString: "#6654C6"), for: .selected)
        b.setBackgroundImage(UIImage.init(color: UIColor.clear), for: .normal)
        b.setBackgroundImage(UIImage.init(color: UIColor.white), for: .selected)
        b.layer.cornerRadius = 15 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.white.cgColor
        b.addTarget(self, action: #selector(friendRecommend(sender:)), for: .touchUpInside)
        return b
    }()
    

    override func viewDidLoad() {
        
        titleColorNormal = kColor_subText!
        titleColorSelected = kColor_text!
        menuViewStyle = .line
        progressColor = kColor_pink
        super.viewDidLoad()
        
        naviBar.isHidden = true
        view.backgroundColor = UIColor.white
        initUI()
        
    }
    
    func initUI() {
        view.addSubview(headerIV)
        headerIV.addSubview(popBtn)
        headerIV.addSubview(teamCountLabel)
        headerIV.addSubview(meRecommendBtn)
        headerIV.addSubview(friendRecommendBtn)
        headerIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 200 * KScreenRatio_6))
        }
        popBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(40)
        }
        teamCountLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80 * KScreenRatio_6)
        }
        meRecommendBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 120 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.bottom.equalToSuperview().offset(-30 * KScreenRatio_6)
            make.left.equalToSuperview().offset(40 * KScreenRatio_6)
        }
        friendRecommendBtn.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(meRecommendBtn)
            make.right.equalToSuperview().offset(-40 * KScreenRatio_6)
        }
    }
    

}
