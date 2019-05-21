
//
//  PVHomeReportCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVHomeReportCell: PVBaseTableCell {
    
    
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "right_arrow"))
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowIV)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        arrowIV.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
