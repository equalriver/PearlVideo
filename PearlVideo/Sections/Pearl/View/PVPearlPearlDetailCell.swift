//
//  PVPearlPearlDetailCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVPearlPearlDetailCell: PVBaseTableCell {

    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_weight
        l.textColor = kColor_text
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.font = kFont_text_2
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(detailLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
        detailLabel.text = nil
    }
    
}
