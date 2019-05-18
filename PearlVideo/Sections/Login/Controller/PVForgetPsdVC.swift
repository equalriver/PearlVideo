//
//  PVForgetPsdVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVForgetPsdVC: PVBaseNavigationVC {
    
    var psd_1 = ""
    var psd_2 = ""
    
    var isChangePsdView = false
    
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24 * KScreenRatio_6, weight: .semibold)
        l.textColor = UIColor.white
        l.text = "重置密码"
        return l
    }()
    lazy var phoneTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = kColor_deepBackground
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入手机号码", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
        tf.keyboardType = .numbersAndPunctuation
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
        tf.keyboardType = .numbersAndPunctuation
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
    lazy var psdTF_1: UIView = {
        let v = makeItemView(tag: 11)
        return v
    }()
    lazy var psdTF_2: UIView = {
        let v = makeItemView(tag: 22)
        return v
    }()
    lazy var nextBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.gray
        b.titleLabel?.font = kFont_text
        b.setTitle("下一步", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.isEnabled = false
        b.addTarget(self, action: #selector(nextAction(sender:)), for: .touchUpInside)
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
        
    }
    
    deinit {
        timer.resume()
        timer.cancel()
    }

    func initUI() {
        view.addSubview(titleLabel)
        view.addSubview(phoneTF)
        view.addSubview(authCodeTF)
        view.addSubview(getAuthCodeBtn)
        view.addSubview(psdTF_1)
        view.addSubview(psdTF_2)
        view.addSubview(nextBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom).offset(20)
        }
        phoneTF.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 295 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalToSuperview().offset(40 * KScreenRatio_6)
            make.top.equalTo(titleLabel.snp.bottom).offset(25 * KScreenRatio_6)
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
        psdTF_1.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(phoneTF)
            make.left.equalTo(view.snp.right).offset(40 * KScreenRatio_6)
        }
        psdTF_2.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(psdTF_1)
            make.top.equalTo(psdTF_1.snp.bottom).offset(30 * KScreenRatio_6)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(phoneTF)
            make.top.equalTo(getAuthCodeBtn.snp.bottom).offset(30 * KScreenRatio_6)
        }

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
        tf.keyboardType = .numbersAndPunctuation
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
    
    @objc func textFieldChange(sender: UITextField) {
        if sender.hasText {
            if sender.tag == 11 {
                psd_1 = sender.text!
            }
            if sender.tag == 22 {
                psd_2 = sender.text!
            }
        }
        if isChangePsdView == false {//下一步页面
            nextBtn.isEnabled = phoneTF.hasText && authCodeTF.hasText
        }
        else {//确认修改页面
            nextBtn.isEnabled = psd_1.count > 0 && psd_2.count > 0
        }
        nextBtn.backgroundColor = nextBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    @objc func getAuthCode(sender: UIButton) {
        guard phoneTF.hasText else {
            view.makeToast("请输入手机号")
            return
        }
        guard phoneTF.text!.ypj.isPhoneNumber else {
            view.makeToast("手机号输入不正确")
            return
        }
        sender.isEnabled = false
        PVNetworkTool.Request(router: .getAuthCode(phone: phoneTF.text!), success: { (resp) in
            auth()
            
        }) { (e) in
            sender.isEnabled = true
            self.view.makeToast(e.localizedDescription)
        }
        
        func auth() {
            var t = 60
            self.timer.setEventHandler {
                if t <= 1 {
                    self.timer.suspend()
                    DispatchQueue.main.async {
                        sender.setTitle("获取验证码", for: .normal)
                        sender.backgroundColor = kColor_pink
                        sender.isEnabled = true
                    }
                }
                else {
                    t -= 1
                    DispatchQueue.main.async {
                        sender.setTitle("重新发送(\(t)s)", for: .normal)
                        sender.backgroundColor = UIColor.gray
                        sender.isEnabled = false
                    }
                }
            }
            self.timer.resume()
            authCodeTF.becomeFirstResponder()
        }
    }
    
    @objc func nextAction(sender: UIButton) {
        if isChangePsdView == false {//下一步页面
            guard phoneTF.hasText else {
                view.makeToast("请输入手机号")
                return
            }
            guard phoneTF.text!.ypj.isPhoneNumber else {
                view.makeToast("手机号输入不正确")
                return
            }
            guard authCodeTF.hasText else {
                view.makeToast("请输入验证码")
                return
            }
            goNext()
            
        }
        else {//确认修改页面
            guard psd_1.count > 0 else {
                view.makeToast("请输入密码")
                return
            }
            guard psd_2.count > 0 else {
                view.makeToast("请再次输入密码")
                return
            }
            guard psd_1 == psd_2 else {
                view.makeToast("两次输入的密码不一致")
                return
            }
            sender.isEnabled = false
            let userId = UserDefaults.standard.string(forKey: kUserId) ?? ""
            PVNetworkTool.Request(router: .changePsd(userId: userId, phone: phoneTF.text!, psd: psd_1), success: { (resp) in
                sender.isEnabled = true
                
            }) { (e) in
                sender.isEnabled = true
                self.view.makeToast(e.localizedDescription)
            }
        }
        
    }
    
    func goNext() {
        nextBtn.setTitle("进入", for: .normal)
        nextBtn.backgroundColor = UIColor.gray
        nextBtn.isEnabled = false
        let trans = CGAffineTransform.init(translationX: -kScreenWidth, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.phoneTF.transform = trans
            self.authCodeTF.transform = trans
            self.getAuthCodeBtn.transform = trans
            self.psdTF_1.transform = trans
            self.psdTF_2.transform = trans
        }
    }
    
    override func leftButtonsAction(sender: UIButton) {
        if isChangePsdView {
            nextBtn.setTitle("下一步", for: .normal)
            nextBtn.backgroundColor = kColor_pink
            nextBtn.isEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.phoneTF.transform = .identity
                self.authCodeTF.transform = .identity
                self.getAuthCodeBtn.transform = .identity
                self.psdTF_1.transform = .identity
                self.psdTF_2.transform = .identity
            }
        }
        else {
            navigationController?.popViewController(animated: true)
        }
    }

}



