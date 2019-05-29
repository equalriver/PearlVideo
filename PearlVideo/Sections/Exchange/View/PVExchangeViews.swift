//
//  PVExchangeViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/27.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - header view

class PVExchangeHeaderView: UIView {
    
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
    lazy var sepView_3: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var sepView_4: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var sepView_5: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var lowPrice: PVExchangeHeaderItem = {
        let v = PVExchangeHeaderItem.init(frame: .zero)
        return v
    }()
    lazy var highPrice: PVExchangeHeaderItem = {
        let v = PVExchangeHeaderItem.init(frame: .zero)
        return v
    }()
    ///涨跌幅
    lazy var priceLimit: PVExchangeHeaderItem = {
        let v = PVExchangeHeaderItem.init(frame: .zero)
        return v
    }()
    ///成交量
    lazy var turnover: PVExchangeHeaderItem = {
        let v = PVExchangeHeaderItem.init(frame: .zero)
        return v
    }()
    lazy var buyOrder: PVExchangeHeaderItem = {
        let v = PVExchangeHeaderItem.init(frame: .zero)
        return v
    }()
    lazy var sellOrder: PVExchangeHeaderItem = {
        let v = PVExchangeHeaderItem.init(frame: .zero)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(sepView_1)
        addSubview(sepView_2)
        addSubview(sepView_3)
        addSubview(sepView_4)
        addSubview(sepView_5)
        addSubview(lowPrice)
        addSubview(highPrice)
        addSubview(priceLimit)
        addSubview(turnover)
        addSubview(buyOrder)
        addSubview(sellOrder)
        sepView_1.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.top.width.centerX.equalToSuperview()
        }
        lowPrice.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 110 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.top.equalTo(sepView_1.snp.bottom).offset(25 * KScreenRatio_6)
            make.right.equalTo(sepView_2.snp.left)
        }
        sepView_2.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 0.5, height: 120 * KScreenRatio_6))
            make.top.equalTo(lowPrice)
            make.right.equalTo(highPrice.snp.left)
        }
        highPrice.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.top.equalTo(lowPrice)
        }
        sepView_3.snp.makeConstraints { (make) in
            make.size.top.equalTo(sepView_2)
            make.left.equalTo(highPrice.snp.right)
        }
        priceLimit.snp.makeConstraints { (make) in
            make.size.top.equalTo(lowPrice)
            make.left.equalTo(sepView_3.snp.right)
        }
        sepView_4.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.top.equalTo(lowPrice.snp.bottom)
        }
        turnover.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(lowPrice)
            make.top.equalTo(sepView_4.snp.bottom)
        }
        buyOrder.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(highPrice)
            make.top.equalTo(sepView_4.snp.bottom)
        }
        sellOrder.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(priceLimit)
            make.top.equalTo(sepView_4.snp.bottom)
        }
        sepView_5.snp.makeConstraints { (make) in
            make.height.equalTo(10 * KScreenRatio_6)
            make.centerX.width.bottom.equalToSuperview()
        }
    }
    
   
    
}

class PVExchangeHeaderItem: UIView {
    
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_pink
        l.textAlignment = .center
        return l
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = UIColor.white
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_deepBackground
        addSubview(countLabel)
        addSubview(nameLabel)
        countLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(countLabel.snp.bottom).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - cell
class PVExchangeCell: PVBaseTableCell {
    
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        v.ypj.addCornerShape(rect: CGRect.init(x: 0, y: 0, width: 50 * KScreenRatio_6, height: 50 * KScreenRatio_6), cornerRadius: 25 * KScreenRatio_6, fillColor: kColor_deepBackground!)
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var priceLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var actionBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text_2
        b.setTitleColor(kColor_pink, for: .normal)
        b.layer.borderColor = kColor_pink!.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 5
        b.backgroundColor = kColor_deepBackground
        b.addTarget(self, action: #selector(dealAction(sender:)), for: .touchUpInside)
        return b
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorView.backgroundColor = kColor_background
        separatorView.snp.updateConstraints { (make) in
            make.height.equalTo(10 * KScreenRatio_6)
        }
        contentView.addSubview(avatarIV)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(actionBtn)
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(avatarIV)
            make.left.equalTo(avatarIV.snp.right).offset(10)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV)
            make.top.equalTo(avatarIV.snp.bottom).offset(20 * KScreenRatio_6)
            make.right.equalTo(actionBtn.snp.left).offset(-20)
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
        }
        actionBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.bottom.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarIV.image = nil
        nameLabel.text = nil
        priceLabel.attributedText = nil
        countLabel.text = nil
        actionBtn.setTitle(nil, for: .normal)
    }
    
    @objc func dealAction(sender: UIButton) {
        
    }
    
}
