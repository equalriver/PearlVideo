//
//  PVMeFansCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/5.
//  Copyright © 2019 equalriver. All rights reserved.
//

protocol PVMeFansDelegate: NSObjectProtocol {
    func didSelectedAttention(cell: PVMeFansCell, sender: UIButton)
}

class PVMeFansCell: PVBaseTableCell {
    
    public var data: PVMeAttentionModel! {
        didSet{
            iconIV.kf.setImage(with: URL.init(string: data.avatarImageUrl))
            nameLabel.text = data.nickName
            genderIV.image = UIImage.init(named: data.gender == "男" ? "me_male" : "me_female")
            attentionBtn.setTitle(data.isFollow ? "取消关注" : "关注", for: .normal)
        }
    }
    
    weak public var delegate: PVMeFansDelegate?
    
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
    lazy var attentionBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_pink
        b.titleLabel?.font = kFont_text_3
        b.setTitle("关注", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 5
        b.addTarget(self, action: #selector(attention(sender:)), for: .touchUpInside)
        return b
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderIV)
        contentView.addSubview(attentionBtn)
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
        attentionBtn.snp.makeConstraints { (make) in
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
    }
    
    @objc func attention(sender: UIButton) {
        delegate?.didSelectedAttention(cell: self, sender: sender)
    }
}