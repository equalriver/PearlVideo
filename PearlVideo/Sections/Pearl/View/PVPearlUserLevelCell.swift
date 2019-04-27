//
//  PVPearlUserLevelCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVPearlUserLevelCell: PVBaseTableCell {

    lazy var titleLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    lazy var explainLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        l.textAlignment = .right
        return l
    }()
    lazy var shadowView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.shadowPath = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: 345 * KScreenRatio_6, height: 70 * KScreenRatio_6), cornerRadius: 5).cgPath
        v.layer.shadowColor = kColor_background!.cgColor
        v.layer.shadowOffset = CGSize.init(width: 0, height: 6)
        v.layer.shadowOpacity = 1
        let rect = CGRect.init(x: 0, y: 0, width: 345 * KScreenRatio_6, height: 70 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: 5)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(shadowView)
        shadowView.addSubview(titleLabel)
        shadowView.addSubview(contentLabel)
        shadowView.addSubview(explainLabel)
        isNeedSeparatorView = false
        shadowView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 345 * KScreenRatio_6, height: 70 * KScreenRatio_6))
            make.centerX.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10 * KScreenRatio_6)
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        explainLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
        contentLabel.text = nil
        explainLabel.text = nil
    }
    
}
