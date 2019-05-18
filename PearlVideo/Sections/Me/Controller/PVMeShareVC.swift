//
//  PVMeShareVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/27.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeShareVC: PVBaseNavigationVC {

    
    lazy var backBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "back_arrow"), for: .normal)
        return b
    }()
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 50 * KScreenRatio_6, height: 50 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2)
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.numberOfLines = 2
        return l
    }()
    lazy var inviteLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
    }()
    lazy var qrCodeIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var copyBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = UIFont.systemFont(ofSize: 18 * KScreenRatio_6)
        b.setTitle("复制链接", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 25 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(copyAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var shareBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "me_分享"), for: .normal)
        b.addTarget(self, action: #selector(shareAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        naviBar.backgroundColor = UIColor.clear
        naviBar.leftBarButtons = [backBtn]
    }
    
    func initUI() {
        view.addSubview(avatarIV)
        view.addSubview(nameLabel)
        view.addSubview(inviteLabel)
        view.addSubview(qrCodeIV)
        view.addSubview(copyBtn)
        view.addSubview(shareBtn)
        shareBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 340 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50 * KScreenRatio_6 - kIphoneXLatterInsetHeight)
        }
        copyBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(shareBtn)
            make.bottom.equalTo(shareBtn.snp.top).offset(-15 * KScreenRatio_6)
        }
        qrCodeIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100 * KScreenRatio_6, height: 100 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-30 * KScreenRatio_6)
            make.bottom.equalTo(copyBtn.snp.top).offset(-20 * KScreenRatio_6)
        }
        inviteLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30 * KScreenRatio_6)
            make.bottom.equalTo(qrCodeIV)
            make.right.equalTo(qrCodeIV.snp.left).offset(-10)
        }
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.left.equalTo(inviteLabel)
            make.bottom.equalTo(inviteLabel.snp.top).offset(-20 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV.snp.right).offset(10 * KScreenRatio_6)
            make.centerY.equalTo(avatarIV)
            make.right.equalTo(inviteLabel)
        }
    }
    
    override func leftButtonsAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    //复制链接
    @objc func copyAction(sender: UIButton) {
        
    }
    
    //分享
    @objc func shareAction(sender: UIButton) {
        
    }

}
