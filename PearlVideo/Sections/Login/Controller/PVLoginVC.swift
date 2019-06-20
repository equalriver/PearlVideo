//
//  PVLoginViewController.swift
//  yjkj-PV-ios
//
//  Created by equalriver on 2019/1/7.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVLoginVC: PVBaseViewController {

    public var loginCallback: ((_ isLogin: Bool) -> Void)?
    
    var isPasswordLogin = true
    
    var isTimerRun = false
    
    
    lazy var dismissBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "back_arrow"), for: .normal)
        b.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return b
    }()
    lazy var iconIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "logo"))
        return v
    }()
//    lazy var ipTextField: UITextField = {
//        let tf = UITextField()
//        tf.backgroundColor = UIColor.white
//        tf.textColor = kColor_text
//        tf.keyboardType = .numbersAndPunctuation
//        tf.placeholder = "ip:  "
//        tf.addTarget(self, action: #selector(ipTextFieldChange(sender:)), for: .editingDidEnd)
//        return tf
//    }()
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
        tf.addTarget(self, action: #selector(textFieldChange(sender:)), for: .editingChanged)
        if #available(iOS 10.0, *) {
            tf.textContentType = UITextContentType.telephoneNumber
        }
        return tf
    }()
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = kColor_deepBackground
        tf.isSecureTextEntry = true
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入密码", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
        tf.clearButtonMode = .whileEditing
        tf.textAlignment = .center
        tf.layer.cornerRadius = 20 * KScreenRatio_6
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
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
    lazy var loginTypeChangeBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_deepBackground
        b.titleLabel?.font = kFont_text
        b.setTitle("短信快捷登录", for: .normal)
        b.setTitle("密码登录", for: .selected)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(loginTypeChange(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var forgetBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_deepBackground
        b.titleLabel?.font = kFont_text_3
        b.setTitle("忘记密码？", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(forgetPassword(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var loginBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("登录", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.gray
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var registerBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_deepBackground
        let att = NSMutableAttributedString.init(string: "没有账号去注册")
        att.addAttributes([.font: kFont_text_2, .foregroundColor: UIColor.white], range: NSMakeRange(0, 5))
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_pink!], range: NSMakeRange(5, 2))
        b.setAttributedTitle(att, for: .normal)
        b.addTarget(self, action: #selector(register(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var privacyLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = UIColor.white
        l.text = "点击登录代表你已阅读并同意"
        return l
    }()
    lazy var privacyTapLabel: YYLabel = {
        let l = YYLabel()
        l.backgroundColor = kColor_deepBackground
        let s1 = "《用户协议》"
        let s2 = "和"
        let s3 = "《隐私政策》"
        let s4: NSString = "《用户协议》和《隐私政策》"
        let att  = NSMutableAttributedString.init(string: s4 as String)
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_pink!], range: s4.range(of: s1))
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_subText!], range: s4.range(of: s2))
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_pink!], range: s4.range(of: s3))
        l.attributedText = att

        l.textTapAction = {[weak self] (containerView, text, range, rect) in
            let r: NSRange = range
            //用户协议
            if s4.range(of: s1).contains(r.location) {
                self?.didSelectedAgreement()
                return
            }
            //隐私
            if s4.range(of: s3).contains(r.location) {
                self?.didSelectedPrivacy()
                return
            }
        }
        return l
    }()
    lazy var timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        timer.schedule(deadline: .now(), repeating: 1)
        return timer
    }()
    lazy var locationManager: CLLocationManager = {
        let l = CLLocationManager.init()
        l.delegate = self
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        view.backgroundColor = kColor_deepBackground
        
    }
    
    deinit {
        if isTimerRun == false { timer.resume() }
        timer.cancel()
    }
    
    
    func initUI() {
        view.addSubview(dismissBtn)
        view.addSubview(iconIV)
        view.addSubview(phoneTF)
        view.addSubview(passwordTF)
        view.addSubview(authCodeTF)
        view.addSubview(getAuthCodeBtn)
        view.addSubview(loginTypeChangeBtn)
        view.addSubview(forgetBtn)
        view.addSubview(loginBtn)
        view.addSubview(registerBtn)
        view.addSubview(privacyLabel)
        view.addSubview(privacyTapLabel)
        
        dismissBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        }
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
        passwordTF.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(phoneTF)
            make.top.equalTo(phoneTF.snp.bottom).offset(20 * KScreenRatio_6)
        }
        authCodeTF.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 140 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalTo(view.snp.right).offset(40 * KScreenRatio_6)
            make.top.equalTo(phoneTF.snp.bottom).offset(20 * KScreenRatio_6)
        }
        getAuthCodeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 125 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerY.equalTo(authCodeTF)
            make.left.equalTo(authCodeTF.snp.right).offset(30 * KScreenRatio_6)
        }
        loginTypeChangeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100, height: 30))
            make.left.equalToSuperview().offset(40 * KScreenRatio_6)
            make.top.equalTo(phoneTF.snp.bottom).offset(90 * KScreenRatio_6)
        }
        forgetBtn.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.centerY.equalTo(loginTypeChangeBtn)
            make.right.equalToSuperview().offset(-40 * KScreenRatio_6)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(phoneTF)
            make.top.equalTo(loginTypeChangeBtn.snp.bottom).offset(20 * KScreenRatio_6)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn)
            make.height.equalTo(30)
            make.top.equalTo(loginBtn.snp.bottom).offset(15 * KScreenRatio_6)
        }
        privacyTapLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30 - kIphoneXLatterInsetHeight * KScreenRatio_6)
            make.height.equalTo(20)
        }
        privacyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(privacyTapLabel.snp.top).offset(-5)
        }
//        #if DEBUG
//        view.addSubview(ipTextField)
//        ipTextField.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize.init(width: 100, height: 30))
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(40)
//        }
//        #endif
    }
    
    
    
}
