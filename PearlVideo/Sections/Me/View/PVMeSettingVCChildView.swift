//
//  PVMeSettingVCChildView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - 实名认证

protocol PVMeNameValidateAlertDelegate: NSObjectProtocol {
    func didSelectedValidate()
}

class PVMeNameValidateAlert: UIView {
    
    weak public var delegate: PVMeNameValidateAlertDelegate?
    
    lazy var contentView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: 400 * KScreenRatio_6))
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_btn_weight
        l.textColor = UIColor.white
        l.text = "确认认证"
        l.textAlignment = .center
        return l
    }()
    lazy var closeBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "video_close"), for: .normal)
        b.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return b
    }()
    lazy var sepView_1: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_border
        return v
    }()
    lazy var sepView_2: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_border
        return v
    }()
    lazy var specsLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.text = "开通实名认证需支付"
        l.textAlignment = .center
        return l
    }()
    lazy var costLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24 * KScreenRatio_6, weight: .semibold)
        l.textColor = kColor_pink
        l.textAlignment = .center
        return l
    }()
    lazy var alipayBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text_2
        b.setImage(UIImage.init(named: "me_支付宝"), for: .normal)
        b.setTitle("支付宝  ", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.isUserInteractionEnabled = false
        return b
    }()
    lazy var selectedIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var validateBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_pink
        b.titleLabel?.font = kFont_text
        b.setTitle("立即认证", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(validateAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        initUI()
        contentView.ypj.viewAnimateComeFromBottom(duration: 0.25, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(closeBtn)
        contentView.addSubview(sepView_1)
        contentView.addSubview(sepView_2)
        contentView.addSubview(specsLabel)
        contentView.addSubview(costLabel)
        contentView.addSubview(alipayBtn)
        contentView.addSubview(selectedIV)
        contentView.addSubview(validateBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        closeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
        }
        sepView_1.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.centerX.width.equalToSuperview()
            make.top.equalTo(closeBtn.snp.bottom).offset(10)
        }
        specsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(sepView_1.snp.bottom).offset(30 * KScreenRatio_6)
        }
        costLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(specsLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        alipayBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(costLabel.snp.bottom).offset(30 * KScreenRatio_6)
        }
        selectedIV.snp.makeConstraints { (make) in
            make.centerX.equalTo(closeBtn)
            make.centerY.equalTo(alipayBtn)
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
        }
        sepView_2.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.centerX.width.equalToSuperview()
            make.top.equalTo(alipayBtn.snp.bottom).offset(10)
        }
        validateBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kIphoneXLatterInsetHeight - 30 * KScreenRatio_6)
        }
    }
    
    @objc public func closeAction() {
        contentView.ypj.viewAnimateDismissFromBottom(duration: 0.25) { (isFinish) in
            if isFinish { self.removeFromSuperview() }
        }
    }
    
    @objc func validateAction(sender: UIButton) {
        contentView.ypj.viewAnimateDismissFromBottom(duration: 0.25) { (isFinish) in
            if isFinish {
                self.delegate?.didSelectedValidate()
                self.removeFromSuperview()
            }
        }
    }
}

//MARK: - 收款方式
protocol PVMePayWayAlertDelegate: NSObjectProtocol {
    func didSelectedConfirm(name: String, account: String)
}

class PVMePayWayAlert: UIView {
    
    weak public var delegate: PVMePayWayAlertDelegate?
    
    lazy var contentView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: 270 * KScreenRatio_6))
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.text = "添加支付宝"
        l.textAlignment = .center
        return l
    }()
    lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 40 * KScreenRatio_6))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.layer.borderColor = kColor_text!.cgColor
        tf.layer.borderWidth = 1
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入姓名", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var accountTF: UITextField = {
        let tf = UITextField()
        tf.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 40 * KScreenRatio_6))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.layer.borderColor = kColor_text!.cgColor
        tf.layer.borderWidth = 1
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入支付宝账号", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var cancelBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.gray
        b.titleLabel?.font = kFont_text
        b.setTitle("取消", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var confirmBtn: UIButton = {
        let b = UIButton()
        b.isEnabled = false
        b.backgroundColor = UIColor.gray
        b.titleLabel?.font = kFont_text
        b.setTitle("确认", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(confirmAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowAction(noti:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideAction(noti:)), name: UIApplication.keyboardWillHideNotification, object: nil)
        contentView.ypj.viewAnimateComeFromBottom(duration: 0.25, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initUI() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameTF)
        contentView.addSubview(accountTF)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(confirmBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
            make.centerX.width.equalToSuperview()
        }
        nameTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.top.equalTo(titleLabel.snp.bottom).offset(20 * KScreenRatio_6)
            make.height.equalTo(40 * KScreenRatio_6)
        }
        accountTF.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(nameTF)
            make.top.equalTo(nameTF.snp.bottom).offset(15 * KScreenRatio_6)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 165 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalTo(nameTF)
            make.bottom.equalToSuperview().offset(-kIphoneXLatterInsetHeight - 25 * KScreenRatio_6)
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(cancelBtn)
            make.right.equalTo(nameTF)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    @objc func keyboardShowAction(noti: Notification) {
        guard let info = noti.userInfo else { return }
        guard let duration = info[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        guard let keyboardFrame = info[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        UIView.animate(withDuration: duration) {
            self.contentView.centerY -= keyboardFrame.height
        }
        
    }
    
    @objc func keyboardHideAction(noti: Notification) {
        guard let info = noti.userInfo else { return }
        guard let duration = info[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        guard let keyboardFrame = info[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        UIView.animate(withDuration: duration) {
            self.contentView.centerY += keyboardFrame.height
        }
        
    }
    
    @objc func textFieldEditingChange(sender: UITextField) {
        confirmBtn.isEnabled = nameTF.hasText && accountTF.hasText
        confirmBtn.backgroundColor = confirmBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    @objc func cancelAction(sender: UIButton) {
        endEditing(true)
        contentView.ypj.viewAnimateDismissFromBottom(duration: 0.25) { (isFinish) in
            if isFinish { self.removeFromSuperview() }
        }
    }
    
    @objc func confirmAction(sender: UIButton) {
        guard nameTF.hasText && accountTF.hasText else { return }
        endEditing(true)
        contentView.ypj.viewAnimateDismissFromBottom(duration: 0.25) { (isFinish) in
            if isFinish {
                self.delegate?.didSelectedConfirm(name: self.nameTF.text!, account: self.accountTF.text!)
                self.removeFromSuperview()
            }
        }
    }
}

//MARK: - 意见反馈
class PVMeFeedbackTypeCell: PVBaseTableCell {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol PVMeFeedbackImageDelegate: NSObjectProtocol {
    func didSeletedDelete(cell: UICollectionViewCell)
}

class PVMeFeedbackCell: UICollectionViewCell {
    
    weak public var delegate: PVMeFeedbackImageDelegate?
    
    lazy var imgIV: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    lazy var deleteBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "setting_delete"), for: .normal)
        b.isHidden = true
        b.addBlock(for: .touchUpInside, block: {[weak self] (btn) in
            if self != nil {self?.delegate?.didSeletedDelete(cell: self!)}
        })
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgIV)
        contentView.addSubview(deleteBtn)
        imgIV.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
            make.top.equalTo(imgIV).offset(-10 * KScreenRatio_6)
            make.right.equalTo(imgIV).offset(10 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgIV.image = nil
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var v = super.hitTest(point, with: event)
        if v == nil {
            let p = deleteBtn.convert(point, from: contentView)
            if deleteBtn.bounds.contains(p){
                v = deleteBtn
            }
        }
        
        return v
    }
    
}

//MARK: - 我的反馈
protocol PVMeMyFeedbackDelegate: NSObjectProtocol {
    func didSelectedHandle(sender: UIButton, cell: PVMeMyFeedbackCell)
}
class PVMeMyFeedbackCell: PVBaseTableCell {
    
    weak public var delegate: PVMeMyFeedbackDelegate?
    
    public var data: PVMeFeedbackList! {
        didSet{
            contentLabel.text = data.content
            typeLabel.text = "类型：" + data.type
            dateLabel.text = data.createAt
            handleBtn.setTitle(data.status, for: .normal)
        }
    }
    
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var typeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.backgroundColor = kColor_deepBackground
        l.textAlignment = .right
        return l
    }()
    lazy var handleBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text_3
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.gray
        b.layer.cornerRadius = 5
        b.addTarget(self, action: #selector(handleAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_deepBackground
        contentView.backgroundColor = kColor_deepBackground
        contentView.addSubview(contentLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(handleBtn)
        contentLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15 * KScreenRatio_6)
            make.right.equalTo(handleBtn.snp.left).offset(-20 * KScreenRatio_6)
        }
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        handleBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(handleBtn)
            make.centerY.equalTo(typeLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentLabel.text = nil
        typeLabel.text = nil
        dateLabel.text = nil
        handleBtn.setTitle(nil, for: .normal)
    }
    
    @objc func handleAction(sender: UIButton) {
        delegate?.didSelectedHandle(sender: sender, cell: self)
    }
    
}

//MARK: - 关于我们
class PVMeAboutCell: PVBaseTableCell {
    
    lazy var iconIV: UIImageView = {
        return UIImageView()
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
    }()
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "right_arrow"))
        return iv
    }()
    
    required convenience init(image: String, title: String) {
        self.init(style: .default, reuseIdentifier: nil)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        iconIV.image = UIImage.init(named: image)
        titleLabel.text = title
        contentView.addSubview(iconIV)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowIV)
        iconIV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        arrowIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 10, height: 20))
            make.right.equalToSuperview().offset(-30 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
}

//MARK: - 检测更新
class PVMeVersionCell: PVBaseTableCell {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18 * KScreenRatio_6)
        l.textColor = UIColor.white
        return l
    }()
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "right_arrow"))
        return iv
    }()
    
    required convenience init(title: String) {
        self.init(style: .default, reuseIdentifier: nil)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        titleLabel.text = title
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowIV)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(35 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        arrowIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 10, height: 20))
            make.right.equalToSuperview().offset(-30 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
}
