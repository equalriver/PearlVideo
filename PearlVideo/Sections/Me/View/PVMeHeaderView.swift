//
//  PVMeHeaderView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

protocol PVMeHeaderViewDelegate: NSObjectProtocol {
    func didSelectedInvitation()
    func didSelectedTeam()
    func didSelectedEdit()
}

class PVMeHeaderView: UIView {

    weak public var delegate: PVMeHeaderViewDelegate?
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 55 * KScreenRatio_6
        iv.layer.masksToBounds = true
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24 * KScreenRatio_6, weight: .semibold)
        l.textColor = UIColor.black
        l.text = "登录/注册"
        return l
    }()
    lazy var genderIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var locationIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "me_location")
        iv.isHidden = true
        return iv
    }()
    lazy var locationLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.text = "点击登录，获得经验值"
        return l
    }()
    lazy var ageLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = kColor_background
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.font = kFont_text_3
        l.layer.cornerRadius = 4
        l.layer.masksToBounds = true
        l.isHidden = true
        return l
    }()
    lazy var descriptionLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    lazy var invitationCodeBtn: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.setTitle("我的邀请码", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 4
        b.layer.masksToBounds = true
        b.addBlock(for: .touchUpInside, block: {[weak self] (btn) in
            self?.delegate?.didSelectedInvitation()
        })
        return b
    }()
    lazy var teamBtn: UIButton = {
        let b = UIButton()
        b.setTitle("团队", for: .normal)
        b.setTitleColor(kColor_text, for: .normal)
        b.layer.cornerRadius = 5
        b.layer.masksToBounds = true
        b.layer.borderColor = kColor_text!.cgColor
        b.layer.borderWidth = 0.5
        b.backgroundColor = UIColor.white
        b.addBlock(for: .touchUpInside, block: {[weak self] (btn) in
            self?.delegate?.didSelectedTeam()
        })
        return b
    }()
    lazy var editBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "me_编辑"), for: .normal)
        b.layer.cornerRadius = 5
        b.layer.masksToBounds = true
        b.layer.borderColor = kColor_text!.cgColor
        b.layer.borderWidth = 0.5
        b.backgroundColor = UIColor.white
        b.addBlock(for: .touchUpInside, block: {[weak self] (btn) in
            self?.delegate?.didSelectedEdit()
        })
        return b
    }()
    lazy var hotCountItem: PVMeHeaderViewItem = {
        let v = PVMeHeaderViewItem.init(name: "关注")
        return v
    }()
    lazy var fansCountItem: PVMeHeaderViewItem = {
        let v = PVMeHeaderViewItem.init(name: "粉丝")
        return v
    }()
    lazy var praiseCountItem: PVMeHeaderViewItem = {
        let v = PVMeHeaderViewItem.init(name: "获赞")
        return v
    }()
    lazy var shadowView: UIView = {
        let v = UIView()
        v.layer.shadowColor = UIColor.init(hexString: "#843EB0")!.cgColor
        v.layer.shadowRadius = 5
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = CGSize.zero
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(iconIV)
        addSubview(nameLabel)
        addSubview(genderIV)
        addSubview(locationIV)
        addSubview(locationLabel)
        addSubview(ageLabel)
        addSubview(descriptionLabel)
        addSubview(invitationCodeBtn)
        addSubview(teamBtn)
        addSubview(editBtn)
        addSubview(hotCountItem)
        addSubview(fansCountItem)
        addSubview(praiseCountItem)
        addSubview(shadowView)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 110 * KScreenRatio_6, height: 110 * KScreenRatio_6))
            make.left.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(iconIV).offset(15 * KScreenRatio_6)
            make.width.equalTo(60)
        }
        genderIV.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(15 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
        }
        locationIV.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV)
            make.top.equalTo(nameLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
        }
        locationLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(locationIV)
            make.left.equalTo(locationIV.snp.right).offset(2)
            make.width.equalTo(30)
        }
        ageLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50, height: 20))
            make.centerY.equalTo(locationIV)
            make.left.equalTo(locationLabel.snp.right).offset(20 * KScreenRatio_6)
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel).offset(3)
            make.top.equalTo(locationIV.snp.bottom).offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.height.equalTo(20)
        }
        invitationCodeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 80 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.left.equalTo(nameLabel).offset(5)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        teamBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 45 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.centerY.equalTo(invitationCodeBtn)
            make.left.equalTo(invitationCodeBtn.snp.right).offset(10)
        }
        editBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 45 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.centerY.equalTo(invitationCodeBtn)
            make.left.equalTo(teamBtn.snp.right).offset(10)
        }
        hotCountItem.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(iconIV.snp.bottom).offset(60 * KScreenRatio_6)
        }
        fansCountItem.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.left.equalTo(hotCountItem.snp.right).offset(60 * KScreenRatio_6)
            make.centerY.equalTo(hotCountItem)
        }
        praiseCountItem.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.left.equalTo(fansCountItem.snp.right).offset(60 * KScreenRatio_6)
            make.centerY.equalTo(hotCountItem)
        }
        shadowView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 1))
            make.bottom.centerX.equalToSuperview()
        }
    }
}


class PVMeHeaderViewItem: UIView {
    
    public var count = "" {
        willSet{
            countLabel.text = newValue
        }
    }
    
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_btn_weight
        l.textColor = kColor_text
        l.text = "0"
        return l
    }()
    
    required convenience init(name: String) {
        self.init()
        backgroundColor = UIColor.white
        nameLabel.text = name
        addSubview(nameLabel)
        addSubview(countLabel)
        countLabel.snp.makeConstraints { (make) in
            make.top.width.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
        }
    }
}
