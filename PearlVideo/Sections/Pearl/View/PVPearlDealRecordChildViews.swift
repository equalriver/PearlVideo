//
//  PVPearlDealRecordChildViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/15.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 买单
protocol PVPearlDealRecordBuyDelegate: NSObjectProtocol {
    func didSelectedHeader(cell: UITableViewCell)
    func didSelectedDealDetail(cell: UITableViewCell)
}
class PVPearlDealRecordBuyCell: PVBaseTableCell {
    
    
    weak var delegate: PVPearlDealRecordBuyDelegate?
    
    
    lazy var iconIV: UIImageView = {
        let v = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 45 * KScreenRatio_6, height: 45 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(headerAction))
        v.addGestureRecognizer(tap)
        v.isUserInteractionEnabled = true
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var flagLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.backgroundColor = kColor_pink
        let rect = CGRect.init(x: 0, y: 0, width: 25, height: 13)
        l.ypj.addCornerShape(rect: rect, cornerRadius: 2)
        return l
    }()
    lazy var billCodeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_subText
        return l
    }()
    lazy var priceLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        return l
    }()
    lazy var detailBtn: TitleFrontButton = {
        let b = TitleFrontButton()
        b.titleLabel?.font = kFont_text_2
        b.setTitle("交易明细", for: .normal)
        b.setTitleColor(kColor_pink, for: .normal)
//        b.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        b.addTarget(self, action: #selector(detailAction), for: .touchUpInside)
        return b
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if nameLabel.width > 0 {
            flagLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(nameLabel.snp.right).offset(5)
                make.centerY.equalTo(nameLabel)
                make.size.equalTo(CGSize.init(width: 25, height: 13))
            }
        }
    }
    
    func initUI() {
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLabel)
        contentView.addSubview(flagLabel)
        contentView.addSubview(billCodeLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(detailBtn)
        contentView.addSubview(sepView_1)
        contentView.addSubview(sepView_2)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 45 * KScreenRatio_6, height: 45 * KScreenRatio_6))
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
            make.centerY.equalTo(iconIV)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconIV)
            make.left.equalTo(iconIV.snp.right).offset(190 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-10)
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
        }
        sepView_1.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 0.5))
            make.centerX.equalToSuperview()
            make.top.equalTo(iconIV.snp.bottom).offset(10 * KScreenRatio_6)
        }
        billCodeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV)
            make.top.equalTo(sepView_1.snp.bottom).offset(15 * KScreenRatio_6)
        }
        detailBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 80 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.centerY.equalTo(billCodeLabel)
        }
        sepView_2.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 10 * KScreenRatio_6))
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    
    @objc func headerAction() {
        delegate?.didSelectedHeader(cell: self)
    }
    
    @objc func detailAction() {
        delegate?.didSelectedDealDetail(cell: self)
    }
    
}
