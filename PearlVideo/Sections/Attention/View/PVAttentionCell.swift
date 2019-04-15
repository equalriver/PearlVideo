//
//  PVAttentionCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

protocol PVAttentionCellDelegate: NSObjectProtocol {
    func didSelectedLike(cell: PVAttentionCell)
}

class PVAttentionCell: UICollectionViewCell {
    
    weak public var delegate: PVAttentionCellDelegate?
    
    lazy var imgIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.numberOfLines = 2
        return l
    }()
    lazy var headerIV: UIImageView = {
        let iv = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 25 * KScreenRatio_6, height: 25 * KScreenRatio_6)
        iv.ypj.makeViewRoundingMask(roundedRect: rect, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: rect.height / 2, height: rect.height / 2))
        return iv
    }()
    lazy var likeBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text_weight
        b.setTitleColor(UIColor.white, for: .normal)
        b.setImage(UIImage.init(named: "attention_点赞"), for: .normal)
        b.contentHorizontalAlignment = .left
        b.addTarget(self, action: #selector(didSelectedLike(sender:)), for: .touchUpInside)
        return b
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgIV)
        imgIV.addSubview(nameLabel)
        imgIV.addSubview(headerIV)
        imgIV.addSubview(likeBtn)
        imgIV.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-25 * KScreenRatio_6)
            make.top.equalToSuperview().offset(220 * KScreenRatio_6)
        }
        headerIV.snp.makeConstraints { (make) in
            make.left.lessThanOrEqualTo(nameLabel)
            make.size.equalTo(CGSize.init(width: 25 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.bottom.equalToSuperview().offset(-10 * KScreenRatio_6)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.centerY.equalTo(headerIV)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgIV.image = nil
        nameLabel.text = nil
        headerIV.image = nil
        likeBtn.setTitle(nil, for: .normal)
    }
    
    @objc func didSelectedLike(sender: UIButton) {
        delegate?.didSelectedLike(cell: self)
    }
    
}
