//
//  PVExchangeRecordDetailViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 买单
class PVExchangeRecordBuyDetailView: UIView {
    
    lazy var headBgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_pink
        return v
    }()
    lazy var iconIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "ex_time"))
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_btn_weight
        l.textColor = UIColor.white
        l.text = "寻找卖家"
        return l
    }()
    lazy var costItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: true)
        v.titleLabel.text = "交换金额："
        return v
    }()
    lazy var priceItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: true)
        v.titleLabel.text = "单价："
        return v
    }()
    lazy var countItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: true)
        v.titleLabel.text = "数量："
        return v
    }()
    lazy var orderNumberItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: false)
        v.titleLabel.text = "订单号："
        return v
    }()
    lazy var orderTimeItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: false)
        v.titleLabel.text = "订单时间："
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_deepBackground
        addSubview(headBgView)
        headBgView.addSubview(iconIV)
        headBgView.addSubview(titleLabel)
        addSubview(costItemView)
        addSubview(priceItemView)
        addSubview(countItemView)
        addSubview(orderNumberItemView)
        addSubview(orderTimeItemView)
        headBgView.snp.makeConstraints { (make) in
            make.width.top.centerX.equalToSuperview()
            make.height.equalTo(150 * KScreenRatio_6)
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20, height: 20))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconIV.snp.right).offset(10)
        }
        costItemView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(30 * KScreenRatio_6)
            make.top.equalTo(headBgView.snp.bottom)
        }
        priceItemView.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(costItemView)
            make.top.equalTo(costItemView.snp.bottom)
        }
        countItemView.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(costItemView)
            make.top.equalTo(priceItemView.snp.bottom)
        }
        orderNumberItemView.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(costItemView)
            make.top.equalTo(countItemView.snp.bottom)
        }
        orderTimeItemView.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(costItemView)
            make.top.equalTo(orderNumberItemView.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 卖单
class PVExchangeRecordSellDetailView: PVExchangeRecordBuyDetailView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "寻找买家"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 交换中
class ChangingDetailHeadView: UIView {
    
    public var type = ExchangeRecordChangingType.getFruit {
        didSet{
            switch type {
            case .waitForBuyerPay:
                iconIV.image = UIImage.init(named: "ex_time")
                titleLabel.text = "待买家付款"
                break
                
            case .waitForPay:
                iconIV.image = UIImage.init(named: "ex_time")
                titleLabel.text = "待买家付款"
                break
                
            case .getFruit:
                iconIV.image = UIImage.init(named: "ex_success")
                titleLabel.text = "买家已付款"
                break
                
            case .payWithFruit:
                iconIV.image = UIImage.init(named: "ex_success")
                titleLabel.text = "买家已付款"
                break
                
            case .none: break
            }
        }
    }
    
    lazy var headBgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_pink
        return v
    }()
    lazy var iconIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "ex_time"))
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_btn_weight
        l.textColor = UIColor.white
        return l
    }()
    lazy var leftTimeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = UIColor.white
        return l
    }()
    lazy var costItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: true)
        v.titleLabel.text = "交换金额："
        return v
    }()
    lazy var priceItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: true)
        v.titleLabel.text = "单价："
        return v
    }()
    lazy var countItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: true)
        v.titleLabel.text = "数量："
        return v
    }()
    lazy var orderNumberItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: false)
        v.titleLabel.text = "订单号："
        return v
    }()
    lazy var orderTimeItemView: PVExchangeRecordMsgItemView = {
        let v = PVExchangeRecordMsgItemView.init(isWhiteColor: false)
        v.titleLabel.text = "订单时间："
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_deepBackground
        addSubview(headBgView)
        headBgView.addSubview(iconIV)
        headBgView.addSubview(titleLabel)
        headBgView.addSubview(leftTimeLabel)
        addSubview(costItemView)
        addSubview(priceItemView)
        addSubview(countItemView)
        addSubview(orderNumberItemView)
        addSubview(orderTimeItemView)
        headBgView.snp.makeConstraints { (make) in
            make.width.top.centerX.equalToSuperview()
            make.height.equalTo(150 * KScreenRatio_6)
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20, height: 20))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
            make.left.equalTo(iconIV.snp.right).offset(10)
        }
        leftTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        costItemView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(30 * KScreenRatio_6)
            make.top.equalTo(headBgView.snp.bottom)
        }
        priceItemView.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(costItemView)
            make.top.equalTo(costItemView.snp.bottom)
        }
        countItemView.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(costItemView)
            make.top.equalTo(priceItemView.snp.bottom)
        }
        orderNumberItemView.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(costItemView)
            make.top.equalTo(countItemView.snp.bottom)
        }
        orderTimeItemView.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(costItemView)
            make.top.equalTo(orderNumberItemView.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

protocol ChangingFootDelegate: NSObjectProtocol {
    func didSelectedPhone(phone: String)
    func didSelectedCopy(content: String)
}
class ChangingFootView: UIView {
    
    weak public var delegate: ChangingFootDelegate?
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_btn_weight
        l.textColor = UIColor.white
        return l
    }()
    lazy var sepView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_subText
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.textColor = kColor_subText
        l.font = kFont_text
        return l
    }()
    lazy var nameItem: PVExchangeRecordUserInfoItemView = {
        let v = PVExchangeRecordUserInfoItemView.init(title: "真实姓名", image: "ex_user")
        return v
    }()
    lazy var phoneItem: PVExchangeRecordUserInfoItemView = {
        let v = PVExchangeRecordUserInfoItemView.init(title: "手机号码", image: "ex_phone")
        return v
    }()
    lazy var payItem: PVExchangeRecordUserInfoItemView = {
        let v = PVExchangeRecordUserInfoItemView.init(title: "支付宝账号", image: "ex_pay")
        return v
    }()
    lazy var phoneBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_deepBackground
        b.titleLabel?.font = kFont_text_3
        b.setTitle("拨打", for: .normal)
        b.setTitleColor(UIColor.init(hexString: "#FFC525"), for: .normal)
        b.layer.borderColor = UIColor.init(hexString: "#FFC525")!.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 5
        b.addTarget(self, action: #selector(phoneAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var copyBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_deepBackground
        b.titleLabel?.font = kFont_text_3
        b.setTitle("复制", for: .normal)
        b.setTitleColor(UIColor.init(hexString: "#4D7AFA"), for: .normal)
        b.layer.borderColor = UIColor.init(hexString: "#4D7AFA")!.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 5
        b.addTarget(self, action: #selector(copyAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(sepView)
        addSubview(nameLabel)
        addSubview(nameItem)
        addSubview(phoneItem)
        addSubview(payItem)
        addSubview(phoneBtn)
        addSubview(copyBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        sepView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.width.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(sepView.snp.bottom).offset(20 * KScreenRatio_6)
        }
        nameItem.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20 * KScreenRatio_6)
            make.height.equalTo(60 * KScreenRatio_6)
        }
        phoneItem.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(nameItem)
            make.top.equalTo(nameItem.snp.bottom)
        }
        payItem.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(phoneItem)
            make.top.equalTo(phoneItem.snp.bottom)
        }
        phoneBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.bottom.equalTo(phoneItem)
        }
        copyBtn.snp.makeConstraints { (make) in
            make.size.right.equalTo(phoneBtn)
            make.bottom.equalTo(payItem)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func phoneAction(sender: UIButton) {
        guard phoneItem.detailLabel.text != nil else { return }
        delegate?.didSelectedPhone(phone: phoneItem.detailLabel.text!)
    }
    
    @objc func copyAction(sender: UIButton) {
        guard payItem.detailLabel.text != nil else { return }
        delegate?.didSelectedCopy(content: payItem.detailLabel.text!)
    }
    
}

//MARK: - 上传截图
protocol ChangingScreenshotDelegate: NSObjectProtocol {
    func didSelectedUpload(success: @escaping () -> Void)
    func didTapScreenshot()
}
class ChangingScreenshotView: UIView {
    
    weak public var delegate: ChangingScreenshotDelegate?
    
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.text = "支付截图"
        return l
    }()
    lazy var imageIV: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = kColor_deepBackground
        v.isUserInteractionEnabled = true
        return v
    }()
    lazy var placeholderIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "ex_支付截图"))
        return v
    }()
    lazy var uploadBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("上传", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.gray
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(uploadAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_background
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageTapAction(sender:)))
        imageIV.addGestureRecognizer(tap)
        addSubview(titleLabel)
        addSubview(imageIV)
        imageIV.addSubview(placeholderIV)
        imageIV.addSubview(uploadBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        imageIV.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.height.equalTo(260 * KScreenRatio_6)
        }
        placeholderIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 80 * KScreenRatio_6, height: 80 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70 * KScreenRatio_6)
        }
        uploadBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(placeholderIV.snp.bottom).offset(15 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func uploadAction(sender: UIButton) {
        delegate?.didSelectedUpload(success: { [weak self] in
            self?.placeholderIV.isHidden = true
            self?.uploadBtn.isHidden = true
        })
    }
    
    @objc func imageTapAction(sender: UITapGestureRecognizer) {
        delegate?.didTapScreenshot()
    }
}

//MARK: - 底部按钮
protocol ChangingBottomButtonsDelegate: NSObjectProtocol {
    func didSelectedCancel()
    func didSelectedPay()
}
class ChangingBottomButtons: UIView {
    
    weak public var delegate: ChangingBottomButtonsDelegate?
    
    public var type = ExchangeRecordChangingType.getFruit {
        didSet{
            switch type {
            case .waitForBuyerPay:  //待买家付款
                break
                
            case .waitForPay: //待支付
                addSubview(payBtn)
                payBtn.snp.makeConstraints { (make) in
                    make.size.equalTo(CGSize.init(width: 260 * KScreenRatio_6, height: 40 * KScreenRatio_6))
                    make.center.equalToSuperview()
                }
                break
                
            case .payWithFruit: //待放平安果
                payBtn.setTitle("确认发放平安果", for: .normal)
                addSubview(cancelBtn)
                addSubview(payBtn)
                cancelBtn.snp.makeConstraints { (make) in
                    make.size.equalTo(CGSize.init(width: 165 * KScreenRatio_6, height: 40 * KScreenRatio_6))
                    make.left.equalToSuperview().offset(15 * KScreenRatio_6)
                    make.centerY.equalToSuperview()
                }
                payBtn.snp.makeConstraints { (make) in
                    make.size.centerY.equalTo(cancelBtn)
                    make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
                }
                break
                
            case .getFruit: //待收平安果
                break
                
            case .none: break
            }
        }
    }
    
    lazy var cancelBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_deepBackground
        b.titleLabel?.font = kFont_text
        b.setTitle("申诉", for: .normal)
        b.setTitleColor(kColor_subText, for: .normal)
        b.layer.borderColor = kColor_subText!.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var payBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_pink
        b.titleLabel?.font = kFont_text
        b.setTitle("已支付", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(payAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_background
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancelAction(sender: UIButton) {
        delegate?.didSelectedCancel()
    }
    
    @objc func payAction(sender: UIButton) {
        delegate?.didSelectedPay()
    }

}
