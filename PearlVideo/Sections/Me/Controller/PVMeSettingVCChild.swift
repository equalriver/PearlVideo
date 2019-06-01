
//
//  PVMeSettingVCChild.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 实名认证

class PVMeNameValidateVC: PVBaseNavigationVC {
    
    public var validateStateData: PVMeUserValidateModel! {
        didSet{
            didValidateContent.isHidden = false
            validateContent.isHidden = true
            setNameAndIdCard(name: validateStateData.name, idCard: validateStateData.idCard)
        }
    }
    
    var data = PVUserValidateModel()
    
    var alertView: PVMeNameValidateAlert?
    
    
    lazy var didValidateContent: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_deepBackground
        v.isHidden = true
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var sepView_1: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var idCardLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var sepView_2: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var validateContent: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_deepBackground
        v.isHidden = false
        return v
    }()
    lazy var noticeLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.backgroundColor = kColor_deepBackground
        l.textColor = kColor_pink
        l.font = kFont_text_2
        l.text = "温馨提示：若因用户填写资料有误等原因导致认证失败，再次认证也需支付相同费用。"
        return l
    }()
    lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入您的姓名", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: 20))
        tf.leftViewMode = .always
        tf.clearButtonMode = .whileEditing
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var idCardTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入您的身份证号", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: 20))
        tf.leftViewMode = .always
        tf.clearButtonMode = .whileEditing
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.backgroundColor = kColor_deepBackground
        l.textColor = kColor_subText
        l.font = kFont_text_2
        l.text = "注意：亲爱的福音用户，您好。为保证用户的真实性，福音将调用第三方公司认证系统进行实名认证，整个认证过程中只做用户真实性匹配对比，不做其他任何用途用户需支付1.5元认证费用，用于第三方公司认证付费及信息费，即可人脸认证成功。若因用户填写资料有误等原因导致认证失败，再次认证也需支付相同费用。如您不同意，请勿认证及支付。如您成功支付1.5元并认证完成，将视为同意此协议。"
        return l
    }()
    lazy var checkBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "login_unselected"), for: .normal)
        b.setImage(UIImage.init(named: "login_selected"), for: .selected)
        b.isSelected = true
        b.addTarget(self, action: #selector(acceptAgreement(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var protocolBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("同意福音《认证协议》", for: .normal)
        b.setTitleColor(kColor_pink, for: .normal)
        b.addTarget(self, action: #selector(protocolAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var confirmBtn: UIButton = {
        let b = UIButton()
        b.setTitleColor(UIColor.white, for: .normal)
        b.setTitle("开始认证", for: .normal)
        b.titleLabel?.font = kFont_text
        b.backgroundColor = UIColor.gray
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.isEnabled = false
        b.addTarget(self, action: #selector(confirm(sender:)), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "实名认证"
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(alipayCallbackNoti(sender:)), name: .kNotiName_alipaySuccess, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if validateStateData != nil && validateStateData.isVerfiedSuccess {
            validateContent.isHidden = true
            didValidateContent.isHidden = false
            loadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initUI() {
        view.addSubview(didValidateContent)
        didValidateContent.addSubview(nameLabel)
        didValidateContent.addSubview(sepView_1)
        didValidateContent.addSubview(idCardLabel)
        didValidateContent.addSubview(sepView_2)
        view.addSubview(validateContent)
        validateContent.addSubview(noticeLabel)
        validateContent.addSubview(nameTF)
        validateContent.addSubview(idCardTF)
        validateContent.addSubview(contentLabel)
        validateContent.addSubview(checkBtn)
        validateContent.addSubview(protocolBtn)
        validateContent.addSubview(confirmBtn)
        didValidateContent.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        sepView_1.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
        idCardLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.top.equalTo(sepView_1.snp.bottom).offset(20 * KScreenRatio_6)
        }
        sepView_2.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(idCardLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
        validateContent.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
        noticeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        nameTF.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(noticeLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
        idCardTF.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(nameTF)
            make.top.equalTo(nameTF.snp.bottom).offset(20 * KScreenRatio_6)
        }
        checkBtn.snp.makeConstraints { (make) in
            make.left.equalTo(idCardTF)
            make.top.equalTo(idCardTF.snp.bottom).offset(20 * KScreenRatio_6)
        }
        protocolBtn.snp.makeConstraints { (make) in
            make.left.equalTo(checkBtn.snp.right).offset(10)
            make.centerY.equalTo(checkBtn)
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.equalTo(checkBtn.snp.bottom).offset(30 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(confirmBtn.snp.bottom).offset(30 * KScreenRatio_6)
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
    }
    
}


//MARK: - 修改密码
class PVMePasswordChangeVC: PVBaseNavigationVC {
    
    lazy var phoneTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入手机号码", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.textColor = UIColor.white
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var authCodeTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入验证码", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.textColor = UIColor.white
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        if #available(iOS 12.0, *) {
            tf.textContentType = UITextContentType.oneTimeCode
        }
        return tf
    }()
    lazy var getAuthCodeBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.backgroundColor = kColor_pink
        b.setTitle("发送验证码", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 15 * KScreenRatio_6
        b.addTarget(self, action: #selector(didClickGetAuthCode(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var nextBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.gray
        b.titleLabel?.font = kFont_text
        b.setTitle("下一步", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(nextAction(sender:)), for: .touchUpInside)
        b.isEnabled = false
        return b
    }()
    lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        t.schedule(deadline: .now(), repeating: 1)
        return t
    }()
    
    
    //life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        title = "修改密码"
    }
    
    deinit {
        timer.resume()
        timer.cancel()
    }
    
    func initUI() {
        view.addSubview(phoneTF)
        view.addSubview(authCodeTF)
        view.addSubview(getAuthCodeBtn)
        view.addSubview(nextBtn)
        phoneTF.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom).offset(40 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 30 * KScreenRatio_6))
        }
        authCodeTF.snp.makeConstraints { (make) in
            make.left.height.equalTo(phoneTF)
            make.top.equalTo(phoneTF.snp.bottom).offset(40 * KScreenRatio_6)
            make.width.equalTo(170 * KScreenRatio_6)
        }
        getAuthCodeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 130 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.centerY.equalTo(authCodeTF)
            make.left.equalTo(authCodeTF.snp.right).offset(30 * KScreenRatio_6)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(getAuthCodeBtn.snp.bottom).offset(30 * KScreenRatio_6)
        }
        
    }
    
}

class PVMePasswordEditVC: PVBaseNavigationVC {
    
    public var phone = ""
    
    lazy var passwordTF_1: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入新密码", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.textColor = UIColor.white
        tf.clearButtonMode = .whileEditing
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var passwordTF_2: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.attributedPlaceholder = NSAttributedString.init(string: "请再次输入密码", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.textColor = UIColor.white
        tf.clearButtonMode = .whileEditing
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var secureBtn_1: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "login_闭眼"), for: .normal)
        b.setImage(UIImage.init(named: "login_睁眼"), for: .selected)
        b.addTarget(self, action: #selector(secureAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var secureBtn_2: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "login_闭眼"), for: .normal)
        b.setImage(UIImage.init(named: "login_睁眼"), for: .selected)
        b.addTarget(self, action: #selector(secureAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var commitBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.gray
        b.titleLabel?.font = kFont_text
        b.setTitle("确认修改", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(commitAction(sender:)), for: .touchUpInside)
        b.isEnabled = false
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        title = "修改密码"
    }
    
    func initUI() {
        view.addSubview(passwordTF_1)
        view.addSubview(passwordTF_2)
        view.addSubview(secureBtn_1)
        view.addSubview(secureBtn_2)
        view.addSubview(commitBtn)
        passwordTF_1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom).offset(50 * KScreenRatio_6)
            make.right.equalTo(secureBtn_1.snp.left).offset(-10)
            make.height.equalTo(25)
        }
        passwordTF_2.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(passwordTF_1)
            make.top.equalTo(passwordTF_1.snp.bottom).offset(40 * KScreenRatio_6)
        }
        secureBtn_1.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.centerY.equalTo(passwordTF_1)
        }
        secureBtn_2.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordTF_2)
            make.size.right.equalTo(secureBtn_1)
        }
        commitBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF_2.snp.bottom).offset(30 * KScreenRatio_6)
        }
    }
}

//MARK: - 交换密码
class PVMeExchangePsdVC: PVBaseNavigationVC {
    
    lazy var phoneTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.attributedPlaceholder = NSAttributedString.init(string: "输入您的手机号", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.textColor = UIColor.white
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var authCodeTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入验证码", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.textColor = UIColor.white
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        if #available(iOS 12.0, *) {
            tf.textContentType = UITextContentType.oneTimeCode
        }
        return tf
    }()
    lazy var getAuthCodeBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.backgroundColor = kColor_pink
        b.setTitle("发送验证码", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 15 * KScreenRatio_6
        b.addTarget(self, action: #selector(getAuthCode(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var passwordTF_1: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入新交换密码", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.textColor = UIColor.white
        tf.clearButtonMode = .whileEditing
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var passwordTF_2: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.attributedPlaceholder = NSAttributedString.init(string: "再次确认交换密码", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.textColor = UIColor.white
        tf.clearButtonMode = .whileEditing
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var confirmBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.gray
        b.titleLabel?.font = kFont_text
        b.setTitle("确认", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(confirmAction(sender:)), for: .touchUpInside)
        b.isEnabled = false
        return b
    }()
    lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        t.schedule(deadline: .now(), repeating: 1)
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "交换密码"
        initUI()
    }
    
    deinit {
        timer.resume()
        timer.cancel()
    }
    
    func initUI() {
        view.addSubview(phoneTF)
        view.addSubview(authCodeTF)
        view.addSubview(getAuthCodeBtn)
        view.addSubview(passwordTF_1)
        view.addSubview(passwordTF_2)
        view.addSubview(confirmBtn)
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom).offset(50 * KScreenRatio_6)
        }
        authCodeTF.snp.makeConstraints { (make) in
            make.left.equalTo(phoneTF)
            make.top.equalTo(phoneTF.snp.bottom).offset(45 * KScreenRatio_6)
            make.right.equalTo(getAuthCodeBtn.snp.left).offset(-30 * KScreenRatio_6)
        }
        getAuthCodeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 130 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.right.equalTo(phoneTF)
            make.bottom.equalTo(authCodeTF)
        }
        passwordTF_1.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTF)
            make.top.equalTo(authCodeTF.snp.bottom).offset(45 * KScreenRatio_6)
        }
        passwordTF_2.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTF)
            make.top.equalTo(passwordTF_1.snp.bottom).offset(45 * KScreenRatio_6)
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF_2.snp.bottom).offset(30 * KScreenRatio_6)
        }
    }
    
}

//MARK: - 收款方式
class PVMePayWayVC: PVBaseNavigationVC {
    
    lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        v.layer.cornerRadius = 5
        return v
    }()
    lazy var iconIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "me_支付宝"))
        return v
    }()
    lazy var addBtn: UIButton = {
        let b = UIButton()
        let att_normal = NSMutableAttributedString.init(string: "+ 添加支付宝账号")
        att_normal.addAttributes([.font: UIFont.systemFont(ofSize: 40 * KScreenRatio_6, weight: .semibold), .foregroundColor: kColor_text!], range: NSMakeRange(0, 2))
        att_normal.addAttributes([.font: kFont_btn_weight, .foregroundColor: kColor_text!], range: NSMakeRange(2, 7))
        b.setAttributedTitle(att_normal, for: .normal)
        b.backgroundColor = kColor_background
        b.addTarget(self, action: #selector(addAccount(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var specsLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.textAlignment = .center
        l.numberOfLines = 0
        l.text = "请仔细核对支付宝账号以及其对应的实名信息，如果转账的支付宝与实名信息不符将被封号"
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "收款方式"
        initUI()
        
    }
    
    func initUI() {
        view.addSubview(bgView)
        bgView.addSubview(iconIV)
        bgView.addSubview(addBtn)
        view.addSubview(specsLabel)
        bgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 345 * KScreenRatio_6, height: 80 * KScreenRatio_6))
            make.top.equalTo(naviBar.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        addBtn.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(20 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        specsLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(45 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-45 * KScreenRatio_6)
            make.top.equalTo(bgView.snp.bottom).offset(20 * KScreenRatio_6)
        }
    }
    
}

//MARK: - 意见反馈
class PVMeFeedbackVC: PVBaseNavigationVC {
    
    let addImg = UIImage.init(named: "setting_背景图")!
    var imgs: [UIImage]!
    var type = 0
    var name = ""
    var phone = ""
    var idCard = ""
    var content = ""
    
    var selectedImageIndex = 0
    
    lazy var topBgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var typeTitleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.text = "问题类型"
        l.backgroundColor = kColor_background
        return l
    }()
    lazy var typeBtn: TitleFrontButton = {
        let b = TitleFrontButton()
        b.backgroundColor = kColor_background
        b.titleLabel?.font = kFont_text
        b.setTitle("选择问题类型", for: .normal)
        b.setTitleColor(kColor_text, for: .normal)
        b.setImage(UIImage.init(named: "down_arrow"), for: .normal)
        b.addTarget(self, action: #selector(typeAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var typeBgView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(typeDismiss(sender:)))
        tap.delegate = self
        v.addGestureRecognizer(tap)
        return v
    }()
    lazy var typeTableView: UITableView = {
        let tb = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 0), style: .plain)
        tb.backgroundColor = kColor_deepBackground
        tb.separatorStyle = .none
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    lazy var nameTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "输入您的姓名", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var phoneTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "输入您的电话", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var idCardTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "输入您的身份证号码", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var contentTitleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.text = "请输入问题内容"
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var contentCountLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.textAlignment = .right
        return l
    }()
    lazy var contentTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "您遇到的问题以及建议", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        tf.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var imgTitleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.text = "上传问题截图"
        l.backgroundColor = kColor_deepBackground
        return l
    }()
    lazy var imgCollectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6)
        l.minimumLineSpacing = 12
        l.minimumInteritemSpacing = 12
        l.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.backgroundColor = kColor_deepBackground
        cv.dataSource = self
        cv.delegate = self
        cv.register(PVMeFeedbackCell.self, forCellWithReuseIdentifier: "PVMeFeedbackCell")
        return cv
    }()
    lazy var commitBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.gray
        b.titleLabel?.font = kFont_text
        b.setTitle("提交", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.isEnabled = false
        b.addTarget(self, action: #selector(commitAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var myFeedbackBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("我的反馈", for: .normal)
        b.setTitleColor(UIColor.init(hexString: "#F43C60"), for: .normal)
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "意见反馈"
        imgs = [addImg]
        naviBar.rightBarButtons = [myFeedbackBtn]
        initUI()
        
    }
    
    func initUI() {
        typeBgView.addSubview(typeTableView)
        view.addSubview(topBgView)
        topBgView.addSubview(typeTitleLabel)
        topBgView.addSubview(typeBtn)
        view.addSubview(nameTF)
        view.addSubview(phoneTF)
        view.addSubview(idCardTF)
        view.addSubview(contentTitleLabel)
        view.addSubview(contentCountLabel)
        view.addSubview(contentTF)
        view.addSubview(imgTitleLabel)
        view.addSubview(imgCollectionView)
        view.addSubview(commitBtn)
        topBgView.snp.makeConstraints { (make) in
            make.height.equalTo(50 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.equalToSuperview()
        }
        typeTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        typeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        nameTF.snp.makeConstraints { (make) in
            make.top.equalTo(topBgView.snp.bottom).offset(30 * KScreenRatio_6)
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.height.equalTo(25 * KScreenRatio_6)
        }
        phoneTF.snp.makeConstraints { (make) in
            make.centerX.size.equalTo(nameTF)
            make.top.equalTo(nameTF.snp.bottom).offset(30 * KScreenRatio_6)
        }
        idCardTF.snp.makeConstraints { (make) in
            make.centerX.size.equalTo(nameTF)
            make.top.equalTo(phoneTF.snp.bottom).offset(30 * KScreenRatio_6)
        }
        contentTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameTF)
            make.top.equalTo(idCardTF.snp.bottom).offset(30 * KScreenRatio_6)
        }
        contentCountLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.centerY.equalTo(contentTitleLabel)
        }
        contentTF.snp.makeConstraints { (make) in
            make.centerX.size.equalTo(nameTF)
            make.top.equalTo(contentTitleLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        imgTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentTF.snp.bottom).offset(20 * KScreenRatio_6)
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        imgCollectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(imgTitleLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.height.equalTo(90 * KScreenRatio_6)
            make.width.equalTo(kScreenWidth - 40 * KScreenRatio_6)
        }
        commitBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(imgCollectionView.snp.bottom).offset(30 * KScreenRatio_6)
        }
    }
    
}

//MARK: - 我的反馈
class PVMeMyFeedbackVC: PVBaseNavigationVC {
    
    var page = 0
    var dataArr = Array<PVMeFeedbackList>()
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_background
        tb.separatorStyle = .none
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kColor_background
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
        title = "我的反馈"
        setRefresh()
        loadData(page: 0)
    }
    
}

//MARK: - 我的反馈详情
class PVMeMyFeedbackDetailVC: PVBaseNavigationVC {
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_deepBackground
        return v
    }()
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
        return b
    }()
    lazy var resultTitleLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = kColor_background
        l.font = kFont_text
        l.textColor = UIColor.white
        l.text = "处理结果："
        return l
    }()
    lazy var resultLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = kColor_background
        l.font = kFont_text_2
        l.textColor = UIColor.white
        l.numberOfLines = 0
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        title = "反馈详情"
    }
    
    func initUI() {
        view.addSubview(contentView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(handleBtn)
        view.addSubview(resultTitleLabel)
        view.addSubview(resultLabel)
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(70 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.equalToSuperview()
        }
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
        resultTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalTo(contentView.snp.bottom).offset(15 * KScreenRatio_6)
        }
        resultLabel.snp.makeConstraints { (make) in
            make.left.equalTo(resultTitleLabel)
            make.right.equalToSuperview().offset(-30 * KScreenRatio_6)
            make.top.equalTo(resultTitleLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
    }
    
}

//MARK: - 关于我们
class PVMeAboutVC: PVBaseNavigationVC {
    
    let items = ["用户协议", "隐私政策", "社区管理公约"]
    let imgs = ["setting_用户协议", "setting_隐私政策", "setting_社区"]
    //最新版本号
    var newVersion = ""
    
    
    lazy var logoIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "logo"))
        return iv
    }()
    lazy var versionLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.backgroundColor = kColor_background
        let s = "福音\n" + "V" + (YPJOtherTool.ypj.getCurrentVersion ?? "1.0.0")
        let att = NSMutableAttributedString.init(string: s)
        att.addAttributes([.font: kFont_btn_weight,
                           .foregroundColor: UIColor.white], range: NSMakeRange(0, 2))
        att.addAttributes([.font: kFont_btn_weight,
                           .foregroundColor: kColor_text!], range: NSMakeRange(2, s.count - 2))
        l.attributedText = att
        return l
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = kColor_background
        tb.dataSource = self
        tb.delegate = self
        tb.isScrollEnabled = false
        return tb
    }()
    lazy var copyrightLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        l.textAlignment = .center
        l.text = "copyright©2019 鸣思网络"
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kColor_background
        title = "关于我们"
        initUI()
    }
    
    func initUI() {
        view.addSubview(logoIV)
        view.addSubview(versionLabel)
        view.addSubview(tableView)
        view.addSubview(copyrightLabel)
        logoIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom).offset(40 * KScreenRatio_6)
        }
        versionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoIV.snp.bottom).offset(30 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(versionLabel.snp.bottom).offset(60 * KScreenRatio_6)
            make.bottom.equalTo(copyrightLabel.snp.top).offset(-20)
        }
        copyrightLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kIphoneXLatterInsetHeight - 15)
        }
    }
    
}

//MARK: - 检测更新
class PVMeVersionVC: PVBaseNavigationVC {
    
    let items = ["去评分", "更新"]
    //最新版本号
    var newVersion = ""
    
    
    lazy var logoIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "logo"))
        return iv
    }()
    lazy var versionLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textAlignment = .center
        l.backgroundColor = kColor_background
        let s = "福音\n\n" + "V" + (YPJOtherTool.ypj.getCurrentVersion ?? "1.0.0")
        let att = NSMutableAttributedString.init(string: s)
        att.addAttributes([.font: kFont_btn_weight,
                           .foregroundColor: UIColor.white], range: NSMakeRange(0, 4))
        att.addAttributes([.font: kFont_btn_weight,
                           .foregroundColor: kColor_subText!], range: NSMakeRange(4, s.count - 4))
        l.attributedText = att
        return l
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = kColor_background
        tb.dataSource = self
        tb.delegate = self
        tb.isScrollEnabled = false
        return tb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kColor_background
        initUI()
    }
    
    func initUI() {
        view.addSubview(logoIV)
        view.addSubview(versionLabel)
        view.addSubview(tableView)
        logoIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom).offset(40 * KScreenRatio_6)
        }
        versionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoIV.snp.bottom).offset(30 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.width.bottom.centerX.equalToSuperview()
            make.top.equalTo(versionLabel.snp.bottom).offset(60 * KScreenRatio_6)
        }
    }
    
}
