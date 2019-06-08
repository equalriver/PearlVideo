//
//  PVExchangeRecordCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: -

class PVExchangeRecordCell: PVBaseTableCell {
    
    
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        v.ypj.addCornerShape(rect: CGRect.init(x: 0, y: 0, width: 25 * KScreenRatio_6, height: 25 * KScreenRatio_6), cornerRadius: 12.5 * KScreenRatio_6, fillColor: kColor_background!)
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_subText
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
    }()
    lazy var handleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_pink
        l.textAlignment = .right
        return l
    }()
    lazy var exchangeCostLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = UIColor.white
        l.textAlignment = .right
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.textAlignment = .right
        return l
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kColor_background
        separatorView.backgroundColor = kColor_deepBackground
        separatorView.snp.updateConstraints { (make) in
            make.height.equalTo(5)
        }
        contentView.addSubview(avatarIV)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(handleLabel)
        contentView.addSubview(exchangeCostLabel)
        contentView.addSubview(dateLabel)
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV.snp.right).offset(7)
            make.centerY.equalTo(avatarIV)
        }
        handleLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV)
            make.top.equalTo(avatarIV.snp.bottom).offset(20 * KScreenRatio_6)
        }
        exchangeCostLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.top.equalTo(handleLabel.snp.bottom).offset(25 * KScreenRatio_6)
            make.width.equalTo(kScreenWidth / 2)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(exchangeCostLabel)
            make.top.equalTo(exchangeCostLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarIV.image = nil
        nameLabel.text = nil
        handleLabel.text = nil
        countLabel.text = nil
        exchangeCostLabel.text = nil
        dateLabel.text = nil
    }
    
}
