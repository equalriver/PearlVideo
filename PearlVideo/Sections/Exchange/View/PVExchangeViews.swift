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
protocol PVExchangeOrderDelegate: NSObjectProtocol {
    func didSelectedDeal(cell: PVExchangeCell, isBuyOrder: Bool)
}
class PVExchangeCell: PVBaseTableCell {
    
    public var isBuyOrder = true {
        didSet{
            actionBtn.setTitle(isBuyOrder ? "买进" : "卖出", for: .normal)
        }
    }
    
    public var data: PVExchangeOrderList! {
        didSet{
            avatarIV.kf.setImage(with: URL.init(string: data.avatarURL))
            nameLabel.text = data.nickname
            let att_price = NSMutableAttributedString.init(string: "单价    ¥\(data.price)")
            att_price.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_subText!], range: NSMakeRange(0, 6))
            att_price.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_pink!], range: NSMakeRange(6, att_price.string.count - 6))
            priceLabel.attributedText = att_price
            
            countLabel.text = "数量    \(data.count)平安果"
        }
    }
    
    weak public var delegate: PVExchangeOrderDelegate?
    
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
        delegate?.didSelectedDeal(cell: self, isBuyOrder: isBuyOrder)
    }
    
}


//MARK: - header section view
protocol PVExchangeHeaderSectionDelegate: NSObjectProtocol {
    func didSelectedSearch()
    func didSelectedSendOrder()
}
class PVExchangeHeaderSectionView: UIView {
    
    weak public var delegate: PVExchangeHeaderSectionDelegate?
    
    lazy var searchBtn: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(searchAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var sendOrderBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_btn_weight
        b.setTitle("发单", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = kColor_pink
        b.layer.cornerRadius = 18 * KScreenRatio_6
        b.addTarget(self, action: #selector(sendOrder(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBtn)
        addSubview(sendOrderBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 230 * KScreenRatio_6, height: 36 * KScreenRatio_6))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        sendOrderBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 80 * KScreenRatio_6, height: 36 * KScreenRatio_6))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchAction(sender: UIButton) {
        delegate?.didSelectedSearch()
    }
    
    @objc func sendOrder(sender: UIButton) {
        delegate?.didSelectedSendOrder()
    }
    
}

//MARK: - buy alert view
class PVExchangeBuyAlert: UIView {
    
    typealias callback = (_ count: String, _ password: String) -> Void
    
    private var handle: callback?
    
    lazy var contentView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: 380 * KScreenRatio_6 + kIphoneXLatterInsetHeight))
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_btn_weight
        l.textColor = UIColor.white
        l.text = "买进平安果"
        return l
    }()
    lazy var iconIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "me_平安果"))
        return v
    }()
    lazy var currentCountLabel: UILabel = {
        let l = UILabel()
        l.textColor = kColor_subText
        l.textAlignment = .right
        l.font = kFont_text
        return l
    }()
    lazy var priceLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white
        l.font = kFont_text_2
        return l
    }()
    lazy var totalPriceLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    lazy var payWayLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        l.text = "支付方式"
        return l
    }()
    lazy var payWayIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "me_支付宝"))
        return v
    }()
    lazy var countTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入整数数量", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: 20))
        tf.leftViewMode = .always
        tf.keyboardType = .numbersAndPunctuation
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入交换密码", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: 20))
        tf.leftViewMode = .always
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var cancelBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("取消", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.backgroundColor = kColor_background
        b.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var orderBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("立即下单", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.backgroundColor = UIColor.gray
        b.isEnabled = false
        b.addTarget(self, action: #selector(orderAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    
    required convenience init(frame: CGRect, handle: @escaping callback) {
        self.init(frame: frame)
        self.handle = handle
        backgroundColor = UIColor.init(white: 0.2, alpha: 0.4)
        initUI()
        contentView.ypj.viewAnimateComeFromBottom(duration: 0.3, completion: nil)
    }
    
    deinit {
        print("****************** PVExchangeBuyAlert deinit")
    }
    
    func initUI() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconIV)
        contentView.addSubview(currentCountLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(totalPriceLabel)
        contentView.addSubview(payWayLabel)
        contentView.addSubview(payWayIV)
        contentView.addSubview(countTF)
        contentView.addSubview(passwordTF)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(orderBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(30 * KScreenRatio_6)
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20, height: 20))
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.centerY.equalTo(titleLabel)
        }
        currentCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(5)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.centerY.equalTo(titleLabel)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
        totalPriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
        payWayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(25 * KScreenRatio_6)
        }
        payWayIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25, height: 25))
            make.centerY.equalTo(payWayLabel)
            make.left.equalTo(payWayLabel.snp.right).offset(10)
        }
        countTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.height.equalTo(40 * KScreenRatio_6)
            make.top.equalTo(payWayLabel.snp.bottom).offset(25 * KScreenRatio_6)
        }
        passwordTF.snp.makeConstraints { (make) in
            make.centerX.width.height.equalTo(countTF)
            make.top.equalTo(countTF.snp.bottom).offset(15 * KScreenRatio_6)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 165 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalTo(passwordTF)
            make.top.equalTo(passwordTF.snp.bottom).offset(25 * KScreenRatio_6)
        }
        orderBtn.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(cancelBtn)
            make.right.equalTo(passwordTF)
        }
    }
    
    @objc func textFieldEditingChange(sender: UITextField) {
        orderBtn.isEnabled = countTF.hasText && passwordTF.hasText
        orderBtn.backgroundColor = orderBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    @objc func cancelAction(sender: UIButton) {
        contentView.ypj.viewAnimateDismissFromBottom(duration: 0.3) { (isFinish) in
            if isFinish {
                self.handle = nil
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func orderAction(sender: UIButton) {
        guard countTF.hasText && passwordTF.hasText else { return }
        handle?(countTF.text!, passwordTF.text!)
        contentView.ypj.viewAnimateDismissFromBottom(duration: 0.3) { (isFinish) in
            if isFinish {
                self.handle = nil
                self.removeFromSuperview()
            }
        }
        
        
    }
}
