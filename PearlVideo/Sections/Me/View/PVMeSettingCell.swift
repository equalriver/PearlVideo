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
    lazy var arrowIV: UIImageView = {
        return UIImageView.init(image: UIImage.init(named: "right_arrow"))
    }()
    lazy var badgeView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 2.5
        v.layer.masksToBounds = true
        v.backgroundColor = UIColor.red
        return v
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        l.textAlignment = .right
        return l
    }()
    
    required convenience init(img: String, title: String, detail: String? = nil, showBadge: Bool = false) {
        self.init(style: .default, reuseIdentifier: nil)
        initUI()
        iconIV.image = UIImage.init(named: img)
        titleLabel.text = title
        contentLabel.text = detail
        badgeView.isHidden = !showBadge
    }
    
    func initUI() {
        contentView.addSubview(iconIV)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowIV)
        contentView.addSubview(badgeView)
        contentView.addSubview(contentLabel)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
        }
        arrowIV.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 14 * KScreenRatio_6, height: 26 * KScreenRatio_6))
        }
        contentLabel.snp.makeConstraints { (make) in
            make.right.equalTo(arrowIV.snp.left).offset(-10 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if titleLabel.width > 0 {
            badgeView.snp.remakeConstraints { (make) in
                make.top.equalTo(titleLabel).offset(-5)
                make.right.equalTo(titleLabel).offset(5)
                make.size.equalTo(CGSize.init(width: 5, height: 5))
            }
        }
    }

}
