//
//  PVMeAttentionCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeAttentionCell: PVBaseTableCell {

    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    lazy var genderIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var locationLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_subText
        return l
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        return l
    }()
    lazy var statusIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "me_已关注"))
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderIV)
        contentView.addSubview(locationLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(statusIV)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
        }
        genderIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        locationLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(genderIV)
            make.left.equalTo(genderIV.snp.right).offset(15 * KScreenRatio_6)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(genderIV.snp.bottom).offset(5)
            make.right.equalTo(statusIV.snp.left).offset(-10)
        }
        statusIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        
        //addShape
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iconIV.ypj.makeViewRoundingMask(roundedRect: rect, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: rect.height / 2, height: rect.height / 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        nameLabel.text = nil
        genderIV.image = nil
        locationLabel.text = nil
        contentLabel.text = nil
        statusIV.image = nil
    }
    
}
