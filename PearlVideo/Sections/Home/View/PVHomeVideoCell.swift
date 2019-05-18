//
//  PVHomeVideoCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVHomeVideoCell: UICollectionViewCell {
    
    public var data: PVHomeVideoModel! {
        didSet{
            imgIV.kf.setImage(with: URL.init(string: data.coverUrl))
            avatarIV.kf.setImage(with: URL.init(string: data.avatarUrl))
            nameLabel.text = data.nickname
            likeBtn.setTitle(" \(data.commentCount)", for: .normal)
        }
    }
    
    lazy var imgIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
    }()
    lazy var likeBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitleColor(UIColor.white, for: .normal)
        b.setImage(UIImage.init(named: "home_点赞"), for: .normal)
        return b
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        contentView.addSubview(imgIV)
        contentView.addSubview(avatarIV)
        contentView.addSubview(nameLabel)
        contentView.addSubview(likeBtn)
        imgIV.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.bottom.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.left.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV.snp.right).offset(7)
            make.centerY.equalTo(avatarIV)
            make.right.equalTo(likeBtn.snp.left).offset(-5)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalTo(avatarIV)
            make.height.equalTo(40 * KScreenRatio_6)
            make.width.equalTo(70)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgIV.image = nil
        avatarIV.image = nil
        nameLabel.text = nil
        likeBtn.setTitle(nil, for: .normal)
    }
}
