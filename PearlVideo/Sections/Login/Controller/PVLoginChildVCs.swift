//
//  PVLoginChildVCs.swift
//  PearlVideo
//
//  Created by equalriver on 2019/3/30.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

//MARK: - 登录
class PVPhoneLoginVC: PVBaseNavigationVC {
    
    var isPasswordLogin = true
    

    lazy var phoneTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请输入手机号码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        return tf
    }()
    lazy var passwordTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请输入密码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.isSecureTextEntry = true
        return tf
    }()
    lazy var passwordSecureBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "login_闭眼"), for: .normal)
        b.setImage(UIImage.init(named: "login_睁眼"), for: .selected)
        b.addTarget(self, action: #selector(passwordSecure(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var authCodeTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请输入验证码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.isHidden = true
        return tf
    }()
    lazy var getAuthCodeBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("获取验证码", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.addTarget(self, action: #selector(didClickGetAuthCode(sender:)), for: .touchUpInside)
        b.isHidden = true
        return b
    }()
    lazy var loginTypeBtn: UIButton = {
        let b = UIButton()
        b.contentHorizontalAlignment = .left
        b.setTitle("短信快捷登录", for: .normal)
        b.setTitle("密码登录", for: .selected)
        b.setTitleColor(kColor_text, for: .normal)
        b.titleLabel?.font = kFont_text
        b.addTarget(self, action: #selector(didSelectedLoginType(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var forgetPsdBtn: UIButton = {
        let b = UIButton()
        b.contentHorizontalAlignment = .right
        b.setTitle("忘记密码？", for: .normal)
        b.setTitleColor(UIColor.init(hexString: "#355EDB"), for: .normal)
        b.addTarget(self, action: #selector(didSelectedForgetPassword), for: .touchUpInside)
        return b
    }()
    lazy var loginBtn: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.titleLabel?.font = kFont_text
        b.setTitle("登录", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(login), for: .touchUpInside)
        return b
    }()
    lazy var bottomLabel_1: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = kColor_subText
        l.font = kFont_text_2
        l.text = "点击登录代表你已阅读并同意"
        return l
    }()
    lazy var bottomLabel_2: UILabel = {
        let l = UILabel()
        l.textColor = kColor_subText
        l.font = kFont_text_2
        l.text = "和"
        return l
    }()
    lazy var agreementBtn: UIButton = {
        let b = UIButton()
        b.setTitle("《用户协议》", for: .normal)
        b.setTitleColor(UIColor.init(hexString: "#E11379"), for: .normal)
        b.addTarget(self, action: #selector(didSelectedAgreement), for: .touchUpInside)
        return b
    }()
    lazy var privacyBtn: UIButton = {
        let b = UIButton()
        b.setTitle("《隐私政策》", for: .normal)
        b.setTitleColor(UIColor.init(hexString: "#E11379"), for: .normal)
        b.addTarget(self, action: #selector(didSelectedPrivacy), for: .touchUpInside)
        return b
    }()
    lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        t.schedule(deadline: .now(), repeating: 1)
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        naviBar.isHidden = true
    }
    
    deinit {
        timer.resume()
        timer.cancel()
    }
    
    func initUI() {
        view.addSubview(phoneTF)
        view.addSubview(passwordTF)
        view.addSubview(passwordSecureBtn)
        view.addSubview(authCodeTF)
        view.addSubview(getAuthCodeBtn)
        view.addSubview(loginTypeBtn)
        view.addSubview(forgetPsdBtn)
        view.addSubview(loginBtn)
        view.addSubview(bottomLabel_1)
        view.addSubview(bottomLabel_2)
        view.addSubview(agreementBtn)
        view.addSubview(privacyBtn)
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 300 * KScreenRatio_6, height: 30 * KScreenRatio_6))
        }
        passwordTF.snp.makeConstraints { (make) in
            make.left.size.equalTo(phoneTF)
            make.top.equalTo(phoneTF.snp.bottom).offset(40 * KScreenRatio_6)
        }
        passwordSecureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(passwordTF.snp.right).offset(2)
            make.centerY.equalTo(passwordTF)
            make.size.equalTo(CGSize.init(width: 30 * KScreenRatio_6, height: 30 * KScreenRatio_6))
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
        loginTypeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(phoneTF)
            make.top.equalTo(passwordTF.snp.bottom).offset(30 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 80 * KScreenRatio_6, height: 30 * KScreenRatio_6))
        }
        forgetPsdBtn.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(loginTypeBtn)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(loginTypeBtn.snp.bottom).offset(30 * KScreenRatio_6)
        }
        agreementBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 20 * KScreenRatio_6))
            make.left.equalToSuperview().offset(100 * KScreenRatio_6)
            make.bottom.equalToSuperview().offset(-30 * KScreenRatio_6)
        }
        bottomLabel_2.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(agreementBtn)
            make.left.equalTo(agreementBtn.snp.right).offset(5)
        }
        privacyBtn.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(agreementBtn)
            make.left.equalTo(bottomLabel_2.snp.right).offset(5)
        }
        bottomLabel_1.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.bottom.equalTo(agreementBtn.snp.top).offset(-2)
        }
        
    }
    
    

}


//MARK: - 注册
class PVRegisterVC: PVBaseNavigationVC {
    
    lazy var phoneTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请输入手机号码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        return tf
    }()
    lazy var authCodeTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请输入验证码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        return tf
    }()
    lazy var getAuthCodeBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("获取验证码", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.addTarget(self, action: #selector(didClickGetAuthCode(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var registerBtn: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.titleLabel?.font = kFont_text
        b.setTitle("下一步", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(register), for: .touchUpInside)
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
        att.addAttributes([.font: kFont_text_2, .foregroundColor: UIColor.init(hexString: "#E11379")!], range: s5.range(of: s2))
        att.addAttributes([.font: kFont_text_2, .foregroundColor: kColor_subText!], range: s5.range(of: s3))
        att.addAttributes([.font: kFont_text_2, .foregroundColor: UIColor.init(hexString: "#E11379")!], range: s5.range(of: s4))
        l.attributedText = att
        
        l.highlightTapAction = {[weak self] (containerView, text, range, rect) in
            let r: NSRange = range
            //用户协议
            if r == s5.range(of: s2) {
                self?.didSelectedAgreement()
            }
            //隐私
            if r == s5.range(of: s4) {
                self?.didSelectedPrivacy()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        naviBar.isHidden = true
    }
    
    deinit {
        timer.resume()
        timer.cancel()
    }
    
    
    func initUI() {
        view.addSubview(phoneTF)
        view.addSubview(authCodeTF)
        view.addSubview(getAuthCodeBtn)
        view.addSubview(registerBtn)
        view.addSubview(checkboxBtn)
        view.addSubview(bottomLabel)
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 300 * KScreenRatio_6, height: 30 * KScreenRatio_6))
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
        registerBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(getAuthCodeBtn.snp.bottom).offset(30 * KScreenRatio_6)
        }
        checkboxBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.left.equalToSuperview().offset(30 * KScreenRatio_6)
            make.bottom.equalToSuperview().offset(-30 * KScreenRatio_6)
        }
        bottomLabel.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(checkboxBtn)
            make.right.equalToSuperview()
            make.left.equalTo(checkboxBtn.snp.right).offset(5)
        }
    }
    
    
}


//MARK: - 注册设置密码
class PVRegisterPsdVC: PVBaseNavigationVC {
    
    var phone = ""
    
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24 * KScreenRatio_6, weight: .semibold)
        l.textColor = kColor_text
        l.text = "设置密码"
        return l
    }()
    lazy var psdTF_1: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请输入密码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.isSecureTextEntry = true
        return tf
    }()
    lazy var psdTF_2: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请再次输入密码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.isSecureTextEntry = true
        return tf
    }()
    lazy var confirmBtn: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.titleLabel?.font = kFont_text
        b.setTitle("进入", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
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
    
    func initUI() {
        view.addSubview(titleLabel)
        view.addSubview(psdTF_1)
        view.addSubview(psdTF_2)
        view.addSubview(confirmBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom).offset(20)
        }
        psdTF_1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(titleLabel.snp.bottom).offset(40 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 300 * KScreenRatio_6, height: 30 * KScreenRatio_6))
        }
        psdTF_2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(psdTF_1.snp.bottom).offset(50 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 300 * KScreenRatio_6, height: 30 * KScreenRatio_6))
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(psdTF_2.snp.bottom).offset(30 * KScreenRatio_6)
        }
    }
 
    
}
