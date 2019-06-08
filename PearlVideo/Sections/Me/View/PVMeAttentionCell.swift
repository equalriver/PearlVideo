//
//  PVMeAttentionCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeAttentionCell: PVBaseTableCell {

    public var data: PVMeAttentionModel! {
        didSet{
            iconIV.kf.setImage(with: URL.init(string: data.avatarImageUrl))
            nameLabel.text = data.nickName
            genderIV.image = UIImage.init(named: data.gender == "男" ? "me_male" : "me_female")
            if data.status == 1 { stateLabel.text = "关注" }
            if data.status == 2 { stateLabel.text = "取消" }
            if data.status == 3 { stateLabel.text = "互相关注" }
        }
    }
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var genderIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = kColor_deepBackground
        return iv
    }()
    lazy var stateLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = kColor_deepBackground
        l.font = kFont_text_3
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.layer.cornerRadius = 5
        l.layer.borderColor = kColor_subText!.cgColor
        l.layer.borderWidth = 0.5
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderIV)
        contentView.addSubview(stateLabel)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
            make.left.equalTo(iconIV.snp.right).offset(20 * KScreenRatio_6)
        }
        genderIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
        }
        stateLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        
        //addShape
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iconIV.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2, fillColor: kColor_deepBackground!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        nameLabel.text = nil
        genderIV.image = nil
        stateLabel.text = nil
    }
    
}
