//
//  PVLoginChildVCs.swift
//  PearlVideo
//
//  Created by equalriver on 2019/3/30.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 注册
class PVRegisterVC: PVBaseNavigationVC {
    
    ///是否选中用户协议和隐私政策
    var isSelectedClause = true
    
    ///当前编辑的text field frame
    var currentTextFieldRect = CGRect.zero
    
    
    lazy var iconIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "logo"))
        return v
    }()
    lazy var phoneTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入手机号码", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
        tf.keyboardType = .numberPad
        tf.clearButtonMode = .whileEditing
        tf.textAlignment = .center
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var authCodeTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入验证码", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
        tf.keyboardType = .numberPad
        tf.clearButtonMode = .whileEditing
        tf.textAlignment = .center
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldChange(sender:)), for: .editingChanged)
        if #available(iOS 12.0, *) {
            tf.textContentType = UITextContentType.oneTimeCode
        }
        return tf
    }()
    lazy var getAuthCodeBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("获取验证码", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = kColor_pink
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(getAuthCode(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var inviteTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入邀请码", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
        tf.clearButtonMode = .whileEditing
        tf.textAlignment = .center
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldChange(sender:)), for: .editingChanged)
        return tf
    }()
    lazy var registerBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.gray
        b.titleLabel?.font = kFont_text
        b.setTitle("下一步", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.isEnabled = false
        b.addTarget(self, action: #selector(register(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var loginBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_deepBackground
        let att = NSMutableAttributedString.init(string: "已有账号去登录")
        att.addAttributes([.font: kFont_text_2, .foregroundColor: UIColor.white], range: NSMakeRange(0, 5))
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_pink!], range: NSMakeRange(5, 2))
        b.setAttributedTitle(att, for: .normal)
        b.addBlock(for: .touchUpInside, block: {[weak self] (btn) in
            self?.navigationController?.popViewController(animated: true)
        })
        return b
    }()
    lazy var checkboxBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "login_unselected"), for: .normal)
        b.setImage(UIImage.init(named: "login_selected"), for: .selected)
        b.addTarget(self, action: #selector(checkboxSelected(sender:)), for: .touchUpInside)
        b.isSelected = true
        return b
    }()
    lazy var bottomLabel: YYLabel = {
        let l = YYLabel()
        let s1 = "我已阅读并同意"
        let s2 = "《用户协议》"
        let s3 = "和"
        let s4 = "《隐私政策》"
        let s5: NSString = "我已阅读并同意《用户协议》和《隐私政策》"
        let att  = NSMutableAttributedString.init(string: s5 as String)
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_subText!], range: s5.range(of: s1))
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_pink!], range: s5.range(of: s2))
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_subText!], range: s5.range(of: s3))
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_pink!], range: s5.range(of: s4))
        l.attributedText = att
        
        l.textTapAction = {[weak self] (containerView, text, range, rect) in
            let r: NSRange = range
            //用户协议
            if s5.range(of: s2).contains(r.location) {
                self?.didSelectedAgreement()
                return
            }
            //隐私
            if s5.range(of: s4).contains(r.location) {
                self?.didSelectedPrivacy()
                return
            }
        }
        return l
    }()
    lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        t.schedule(deadline: .now(), repeating: 1)
        return t
    }()
    
    //life cycle
    override func loadView() {
        view = UIScrollView.init(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        title = "注册"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowAction(noti:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideAction(noti:)), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func initUI() {
        view.addSubview(iconIV)
        view.addSubview(phoneTF)
        view.addSubview(authCodeTF)
        view.addSubview(getAuthCodeBtn)
        view.addSubview(inviteTF)
        view.addSubview(registerBtn)
        view.addSubview(loginBtn)
        view.addSubview(checkboxBtn)
        view.addSubview(bottomLabel)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 85 * KScreenRatio_6, height: 85 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100 * KScreenRatio_6)
        }
        phoneTF.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 295 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalToSuperview().offset(40 * KScreenRatio_6)
            make.top.equalTo(iconIV.snp.bottom).offset(60 * KScreenRatio_6)
        }
        authCodeTF.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 140 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalTo(phoneTF)
            make.top.equalTo(phoneTF.snp.bottom).offset(30 * KScreenRatio_6)
        }
        getAuthCodeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 125 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerY.equalTo(authCodeTF)
            make.left.equalTo(authCodeTF.snp.right).offset(30 * KScreenRatio_6)
        }
        inviteTF.snp.makeConstraints { (make) in
            make.size.left.equalTo(phoneTF)
            make.top.equalTo(authCodeTF.snp.bottom).offset(30 * KScreenRatio_6)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(phoneTF)
            make.top.equalTo(inviteTF.snp.bottom).offset(30 * KScreenRatio_6)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(registerBtn)
            make.height.equalTo(30)
            make.top.equalTo(registerBtn.snp.bottom).offset(15 * KScreenRatio_6)
        }
        checkboxBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 35 * KScreenRatio_6, height: 35 * KScreenRatio_6))
            make.left.equalToSuperview().offset(35 * KScreenRatio_6)
            make.top.equalTo(registerBtn.snp.bottom).offset(100 * KScreenRatio_6)
        }
        bottomLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(checkboxBtn)
            make.left.equalTo(checkboxBtn.snp.right)
        }
    }
    
    
}


//MARK: - 注册设置密码
class PVRegisterPsdVC: PVBaseNavigationVC {
    
    var phone = ""
    
    var psd_1 = ""
    var psd_2 = ""
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24 * KScreenRatio_6, weight: .semibold)
        l.textColor = UIColor.white
        l.text = "设置密码"
        return l
    }()
    lazy var psdTF_1: UIView = {
        let v = makeItemView(tag: 0)
        return v
    }()
    lazy var psdTF_2: UIView = {
        let v = makeItemView(tag: 1)
        return v
    }()
    lazy var confirmBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.gray
        b.titleLabel?.font = kFont_text
        b.setTitle("进入", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.isEnabled = false
        b.addTarget(self, action: #selector(confirmAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    //init
    required convenience init(phone: String) {
        self.init()
        self.phone = phone
    }
    
    //life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    func makeItemView(tag: Int) -> UIView {
        let v = UIView()
        v.backgroundColor = kColor_deepBackground
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 20 * KScreenRatio_6
        
        let tf = UITextField()
        tf.tag = tag
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入密码", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
        tf.clearButtonMode = .whileEditing
        tf.textAlignment = .center
        tf.addTarget(self, action: #selector(textFieldChange(sender:)), for: .editingChanged)
        tf.isSecureTextEntry = true
        v.addSubview(tf)
        
        let secureBtn = UIButton()
        secureBtn.setImage(UIImage.init(named: "login_闭眼"), for: .normal)
        secureBtn.setImage(UIImage.init(named: "login_睁眼"), for: .selected)
        secureBtn.addBlock(for: .touchUpInside) { (btn) in
            tf.isSecureTextEntry = secureBtn.isSelected
        }
        v.addSubview(secureBtn)
        
        tf.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.height.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-60 * KScreenRatio_6)
        }
        secureBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
        }
        return v
    }
    
    func initUI() {
        view.addSubview(titleLabel)
        view.addSubview(psdTF_1)
        view.addSubview(psdTF_2)
        view.addSubview(confirmBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom).offset(20 * KScreenRatio_6)
        }
        psdTF_1.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(40 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 295 * KScreenRatio_6, height: 40 * KScreenRatio_6))
        }
        psdTF_2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(psdTF_1.snp.bottom).offset(50 * KScreenRatio_6)
            make.size.centerX.equalTo(psdTF_1)
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(psdTF_2.snp.bottom).offset(30 * KScreenRatio_6)
        }
    }
 
    
}
