//
//  PVMeProductionCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeProductionCell: UICollectionViewCell {
    
    public var data: PVMeVideoList! {
        didSet{
            imgIV.kf.setImage(with: URL.init(string: data.coverUrl))
            praiseBtn.setTitle("\(data.thumbCount)", for: .normal)
        }
    }
    
    lazy var imgIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var praiseBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "me_like"), for: .normal)
        b.titleLabel?.font = kFont_text_3
        b.setTitleColor(UIColor.white, for: .normal)
        b.isUserInteractionEnabled = false
        return b
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgIV)
        imgIV.addSubview(praiseBtn)
        imgIV.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        praiseBtn.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-15 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgIV.image = nil
        praiseBtn.setTitle(nil, for: .normal)
    }
    
    
}
