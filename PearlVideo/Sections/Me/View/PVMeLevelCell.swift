//
//  PVMeLevelCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/24.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVMeLevelCell: UICollectionViewCell {
    
    lazy var imgIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgIV)
        imgIV.addSubview(nameLabel)
        imgIV.snp.makeConstraints { (make) in
            make.width.centerX.top.equalToSuperview()
            make.height.equalTo(75 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(imgIV.snp.bottom).offset(20 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgIV.image = nil
        nameLabel.text = nil
    }
    
    
}
