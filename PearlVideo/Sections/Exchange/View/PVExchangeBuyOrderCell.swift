//
//  PVExchangeBuyOrderCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVExchangeBuyOrderCell: PVBaseTableCell {
    
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_subText
        return l
    }()
    lazy var detailTF: UITextField = {
        let tf = UITextField()
        tf.font = kFont_text
        tf.textColor = kColor_pink
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailTF)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        detailTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(120 * KScreenRatio_6)
            make.height.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
