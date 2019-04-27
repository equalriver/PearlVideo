//
//  PVPearlOrderDetailViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/15.
//  Copyright © 2019 equalriver. All rights reserved.
//


class PVPearlOrderDetailItemView: UIView {
    
    public var content = "" {
        didSet{
            detailLabel.text = " " + content
        }
    }
    
    lazy var iconIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_subText
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        l.backgroundColor = kColor_background
        let rect = CGRect.init(x: 0, y: 0, width: 230 * KScreenRatio_6, height: 25 * KScreenRatio_6)
        l.ypj.addCornerShape(rect: rect, cornerRadius: 5)
        return l
    }()
    lazy var actionBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text_3
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.backgroundColor = UIColor.white
        return b
    }()
    
    required convenience init(image: UIImage?, title: String, buttonColor: UIColor, buttonTitle: String) {
        self.init()
        iconIV.image = image
        titleLabel.text = title
        actionBtn.setTitle(buttonTitle, for: .normal)
        actionBtn.setTitleColor(buttonColor, for: .normal)
        actionBtn.layer.borderColor = buttonColor.cgColor
        initUI()
    }
    
    func initUI() {
        addSubview(iconIV)
        addSubview(titleLabel)
        addSubview(detailLabel)
        addSubview(actionBtn)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
            make.left.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(iconIV.snp.right).offset(10 * KScreenRatio_6)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 230 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        actionBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.centerY.equalTo(detailLabel)
            make.right.equalToSuperview().offset(-40 * KScreenRatio_6)
        }
    }
    
    
}

//MARK: - 付款信息
class PVPearlOrderDetailPayCell: PVBaseTableCell {
    
    
    lazy var contentBgView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        let rect = CGRect.init(x: 0, y: 0, width: 360 * KScreenRatio_6, height: 125 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: 5)
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.text = "付款信息"
        return l
    }()
    lazy var orderCodeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_subText
        l.textAlignment = .right
        return l
    }()
    lazy var sepView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var priceLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    lazy var moneyLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    lazy var payWayLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    lazy var finishStateIV: UIImageView = {
        let v = UIImageView.init()
        return v
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_text
        l.textAlignment = .right
        return l
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(contentBgView)
        contentBgView.addSubview(titleLabel)
        contentBgView.addSubview(orderCodeLabel)
        contentBgView.addSubview(sepView)
        contentBgView.addSubview(priceLabel)
        contentBgView.addSubview(countLabel)
        contentBgView.addSubview(moneyLabel)
        contentBgView.addSubview(payWayLabel)
        contentBgView.addSubview(finishStateIV)
        contentBgView.addSubview(dateLabel)
        contentBgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 360 * KScreenRatio_6, height: 125 * KScreenRatio_6))
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        orderCodeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10 * KScreenRatio_6)
        }
        sepView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.centerX.width.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(sepView.snp.bottom).offset(8 * KScreenRatio_6)
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
        }
        moneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(priceLabel)
            make.top.equalTo(countLabel.snp.bottom).offset(5)
        }
        payWayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(priceLabel)
            make.top.equalTo(moneyLabel.snp.bottom).offset(5)
        }
        finishStateIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(payWayLabel)
            make.right.equalToSuperview().offset(-10 * KScreenRatio_6)
        }
    }
    
}


//MARK: - 买家信息
protocol PVPearlOrderDetailBuyerDelegate: NSObjectProtocol {
    func didSelectedNameCopy(cell: UITableViewCell)
    func didSelectedRingUp(cell: UITableViewCell)
}
class PVPearlOrderDetailBuyerCell: PVBaseTableCell {
    
    weak public var delegate: PVPearlOrderDetailBuyerDelegate?
    
    lazy var contentBgView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        let rect = CGRect.init(x: 0, y: 0, width: 360 * KScreenRatio_6, height: 145 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: 5)
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.text = "买家信息"
        return l
    }()
    lazy var sepView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var nameItemView: PVPearlOrderDetailItemView = {
        let v = PVPearlOrderDetailItemView.init(image: UIImage.init(named: ""), title: "买家姓名", buttonColor: kColor_pink!, buttonTitle: "复制")
        v.actionBtn.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        return v
    }()
    lazy var phoneItemView: PVPearlOrderDetailItemView = {
        let v = PVPearlOrderDetailItemView.init(image: UIImage.init(named: ""), title: "手机号码", buttonColor: UIColor.init(hexString: "#FCCF53")!, buttonTitle: "拨打")
        v.actionBtn.addTarget(self, action: #selector(ringUpAction), for: .touchUpInside)
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(contentBgView)
        contentBgView.addSubview(titleLabel)
        contentBgView.addSubview(sepView)
        contentBgView.addSubview(nameItemView)
        contentBgView.addSubview(phoneItemView)
        contentBgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 360 * KScreenRatio_6, height: 125 * KScreenRatio_6))
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        sepView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.centerX.width.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        nameItemView.snp.makeConstraints { (make) in
            make.height.equalTo(50 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
            make.top.equalTo(sepView.snp.bottom)
        }
        phoneItemView.snp.makeConstraints { (make) in
            make.centerX.width.height.equalTo(nameItemView)
            make.top.equalTo(nameItemView.snp.bottom)
        }
    }
    
    @objc func copyAction() {
        delegate?.didSelectedNameCopy(cell: self)
    }
    
    @objc func ringUpAction() {
        delegate?.didSelectedRingUp(cell: self)
    }
    
}


//MARK: - 卖家信息
protocol PVPearlOrderDetailSellerDelegate: NSObjectProtocol {
    func didSelectedSellerNameCopy(cell: UITableViewCell)
    func didSelectedSellerRingUp(cell: UITableViewCell)
    func didSelectedAliPayCopy(cell: UITableViewCell)
}
class PVPearlOrderDetailSellerCell: PVBaseTableCell {
    
    weak public var delegate: PVPearlOrderDetailSellerDelegate?
    
    lazy var contentBgView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        let rect = CGRect.init(x: 0, y: 0, width: 360 * KScreenRatio_6, height: 200 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: 5)
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.text = "卖家信息"
        return l
    }()
    lazy var sepView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var nameItemView: PVPearlOrderDetailItemView = {
        let v = PVPearlOrderDetailItemView.init(image: UIImage.init(named: ""), title: "卖家姓名", buttonColor: kColor_pink!, buttonTitle: "复制")
        v.actionBtn.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        return v
    }()
    lazy var phoneItemView: PVPearlOrderDetailItemView = {
        let v = PVPearlOrderDetailItemView.init(image: UIImage.init(named: ""), title: "手机号码", buttonColor: UIColor.init(hexString: "#FCCF53")!, buttonTitle: "拨打")
        v.actionBtn.addTarget(self, action: #selector(ringUpAction), for: .touchUpInside)
        return v
    }()
    lazy var payItemView: PVPearlOrderDetailItemView = {
        let v = PVPearlOrderDetailItemView.init(image: UIImage.init(named: ""), title: "支付宝", buttonColor: UIColor.init(hexString: "#53BBFD")!, buttonTitle: "复制")
        v.actionBtn.addTarget(self, action: #selector(alipayCopy), for: .touchUpInside)
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(contentBgView)
        contentBgView.addSubview(titleLabel)
        contentBgView.addSubview(sepView)
        contentBgView.addSubview(nameItemView)
        contentBgView.addSubview(phoneItemView)
        contentBgView.addSubview(payItemView)
        contentBgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 360 * KScreenRatio_6, height: 125 * KScreenRatio_6))
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        sepView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.centerX.width.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        nameItemView.snp.makeConstraints { (make) in
            make.height.equalTo(50 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
            make.top.equalTo(sepView.snp.bottom)
        }
        phoneItemView.snp.makeConstraints { (make) in
            make.centerX.width.height.equalTo(nameItemView)
            make.top.equalTo(nameItemView.snp.bottom)
        }
        payItemView.snp.makeConstraints { (make) in
            make.centerX.width.height.equalTo(nameItemView)
            make.top.equalTo(phoneItemView.snp.bottom)
        }
    }
    
    @objc func copyAction() {
        delegate?.didSelectedSellerNameCopy(cell: self)
    }
    
    @objc func ringUpAction() {
        delegate?.didSelectedSellerRingUp(cell: self)
    }
    
    @objc func alipayCopy() {
        delegate?.didSelectedAliPayCopy(cell: self)
    }
}


//MARK: - 支付截图
protocol PVPearlOrderDetailScreenShotDelegate: NSObjectProtocol {
    func didSelectedAddImage(sender: UIImageView, cell: UITableViewCell)
}
class PVPearlOrderDetailScreenShotCell: PVBaseTableCell {
    
    
    weak public var delegate: PVPearlOrderDetailScreenShotDelegate?
    
    lazy var contentBgView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        let rect = CGRect.init(x: 0, y: 0, width: 360 * KScreenRatio_6, height: 200 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: 5)
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.text = "卖家信息"
        return l
    }()
    lazy var imgIV: UIImageView = {
        let v = UIImageView()
        v.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(addImage))
        v.addGestureRecognizer(tap)
        let rect = CGRect.init(x: 0, y: 0, width: 345 * KScreenRatio_6, height: 260 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: 5)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func initUI() {
        contentView.addSubview(contentBgView)
        contentBgView.addSubview(titleLabel)
        contentBgView.addSubview(imgIV)
        contentBgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 360 * KScreenRatio_6, height: 125 * KScreenRatio_6))
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        imgIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 345 * KScreenRatio_6, height: 260 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
    }
    
    @objc func addImage() {
        delegate?.didSelectedAddImage(sender: imgIV, cell: self)
    }
    
}
