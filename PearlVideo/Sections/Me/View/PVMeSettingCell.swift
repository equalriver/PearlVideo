//
//  PVMeSettingCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeSettingCell: PVBaseTableCell {

    lazy var iconIV: UIImageView = {
        return UIImageView()
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var rightBtn: TitleFrontButton = {
        let b = TitleFrontButton()
        b.titleLabel?.font = kFont_text_2
        b.setTitleColor(kColor_text, for: .normal)
        b.isUserInteractionEnabled = false
        return b
    }()
    lazy var badgeView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 2.5
        v.layer.masksToBounds = true
        v.backgroundColor = UIColor.red
        return v
    }()
    
    required convenience init(img: UIImage?, title: String?, detail: String?, rightImage: UIImage?, showBadge: Bool) {
        self.init(style: .default, reuseIdentifier: nil)
        
        iconIV.image = img
        titleLabel.text = title
        badgeView.isHidden = !showBadge
        rightBtn.setTitle(detail, for: .normal)
        rightBtn.setImage(rightImage, for: .normal)
        initUI()
    }
    
    func initUI() {
        contentView.addSubview(iconIV)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightBtn)
        contentView.addSubview(badgeView)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
        }
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        badgeView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel).offset(-5)
            make.right.equalTo(titleLabel).offset(5)
            make.size.equalTo(CGSize.init(width: 5, height: 5))
        }
    }

}
