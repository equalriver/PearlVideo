//
//  PVExchangeRecordItem.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVExchangeRecordMsgItemView: UIView {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        return l
    }()
    
    required convenience init(isWhiteColor: Bool) {
        self.init()
        backgroundColor = kColor_background
        detailLabel.textColor = isWhiteColor ? UIColor.white : kColor_subText
        detailLabel.font = isWhiteColor ? kFont_text_2 : kFont_text_3
        addSubview(titleLabel)
        addSubview(detailLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
}


class PVExchangeRecordUserInfoItemView: UIView {
    
    public lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    private lazy var iconIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    
    
    required convenience init(title: String, image: String) {
        self.init()
        backgroundColor = kColor_background
        titleLabel.text = title
        iconIV.image = UIImage.init(named: image)
        addSubview(iconIV)
        addSubview(titleLabel)
        addSubview(detailLabel)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.bottom.equalToSuperview().offset(-5)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(iconIV.snp.right).offset(10 * KScreenRatio_6)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 230 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.bottom.equalToSuperview()
            make.left.equalTo(titleLabel).offset(1)
        }
    }
}
