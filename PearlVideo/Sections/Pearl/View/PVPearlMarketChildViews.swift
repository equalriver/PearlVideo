//
//  PVPearlMarketChildViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 买单
class PVPearlMarketBuyCollectionCell: UICollectionViewCell {
    
    
    lazy var numberLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_pink
        l.textAlignment = .center
        return l
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        l.textAlignment = .center
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = kColor_background
        contentView.ypj.addCornerShape(rect: CGRect.init(origin: .zero, size: frame.size), cornerRadius: 5)
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(numberLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberLabel.text = nil
        nameLabel.text = nil
    }
    
}


protocol PVPearlMarketBuyDelegate: NSObjectProtocol {
    func didSelectedBuy(cell: UITableViewCell)
}

class PVPearlMarketBuyCell: PVBaseTableCell {

    
    weak public var delegate: PVPearlMarketBuyDelegate?
    
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 23 * KScreenRatio_6, height: 23 * KScreenRatio_6)
        iv.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2)
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var priceLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    lazy var sepView_1: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var sepView_2: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var buyButton: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text_3
        b.setTitle("买进", for: .normal)
        b.setTitleColor(kColor_pink, for: .normal)
        b.layer.borderColor = kColor_pink!.cgColor
        b.layer.borderWidth = 1
        let rect = CGRect.init(x: 0, y: 0, width: 60 * KScreenRatio_6, height: 25 * KScreenRatio_6)
        b.ypj.addCornerShape(rect: rect, cornerRadius: 5)
 
        b.addTarget(self, action: #selector(didSelectedBuy), for: .touchUpInside)
        return b
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isNeedSeparatorView = false
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(sepView_1)
        contentView.addSubview(sepView_2)
        contentView.addSubview(buyButton)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 23 * KScreenRatio_6, height: 23 * KScreenRatio_6))
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconIV)
            make.left.equalTo(iconIV.snp.right).offset(10)
        }
        sepView_1.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 0.5))
            make.centerX.equalToSuperview()
            make.top.equalTo(iconIV.snp.bottom).offset(5)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV)
            make.top.equalTo(sepView_1.snp.bottom).offset(10 * KScreenRatio_6)
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV)
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
        }
        buyButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.top.equalTo(sepView_1.snp.bottom).offset(15 * KScreenRatio_6)
        }
        sepView_2.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 10 * KScreenRatio_6))
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    @objc func didSelectedBuy() {
        delegate?.didSelectedBuy(cell: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        nameLabel.text = nil
        priceLabel.attributedText = nil
        countLabel.attributedText = nil
    }
}
