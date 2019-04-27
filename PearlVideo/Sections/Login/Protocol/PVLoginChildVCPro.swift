//
//  PVLoginChildVCPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import Foundation

//MARK: - 登录
extension PVPhoneLoginVC {
    
    //显示密码
    @objc func passwordSecure(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTF.isSecureTextEntry = !sender.isSelected
    }
 
    //获取验证码
    @objc func didClickGetAuthCode(sender: UIButton) {
        
        sender.isUserInteractionEnabled = false
        var t = 59
        
        self.timer.setEventHandler {
            if t <= 1 {
                self.timer.suspend()
                DispatchQueue.main.async {
                    sender.setTitle("获取验证码", for: .normal)
                    sender.isEnabled = true
                }
            }
            else {
                t -= 1
                DispatchQueue.main.async {
                    sender.setTitle("已发送(\(t))", for: .normal)
                    sender.isEnabled = false
                }
            }
        }
        self.timer.resume()
    }
    
    //切换登录模式 selected为验证码登录
    @objc func didSelectedLoginType(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isPasswordLogin = !sender.isSelected
        if sender.isSelected == false {//切换到密码登录
            UIView.animate(withDuration: 0.5, animations: {
                self.authCodeTF.alpha = 0
                self.getAuthCodeBtn.alpha = 0
                self.passwordTF.alpha = 1
                
            }) { (isFinish) in
                self.authCodeTF.isHidden = true
                self.getAuthCodeBtn.isHidden = true
                self.passwordTF.isHidden = false
            }
        }
        else {//切换到验证码登录
            UIView.animate(withDuration: 0.5, animations: {
                self.authCodeTF.alpha = 1
                self.getAuthCodeBtn.alpha = 1
                self.passwordTF.alpha = 0
                
            }) { (isFinish) in
                self.authCodeTF.isHidden = false
                self.getAuthCodeBtn.isHidden = false
                self.passwordTF.isHidden = true
            }
        }
    }
    
    //忘记密码
    @objc func didSelectedForgetPassword() {
        let vc = PVForgetPsdVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //登录
    @objc func login(sender: UIButton) {
        guard phoneTF.hasText else {
            view.makeToast("请输入手机号")
            return
        }
        guard phoneTF.text!.ypj.isPhoneNumber else {
            view.makeToast("手机号输入不正确")
            return
        }
        var psd = ""
        var code = ""
        if isPasswordLogin {
            guard passwordTF.hasText else {
                view.makeToast("请输入密码")
                return
            }
            psd = passwordTF.text!
        }
        else {
            guard authCodeTF.hasText else {
                view.makeToast("请输入验证码")
                return
            }
            code = authCodeTF.text!
        }
        
        sender.isEnabled = false
        PVNetworkTool.Request(router: .login(phone: phoneTF.text!, psd: psd, msgcode: code), success: { (resp) in
            sender.isEnabled = true
            
            self.dismiss(animated: true, completion: nil)
            
        }) { (e) in
            sender.isEnabled = true
            self.view.makeToast(e.localizedDescription)
        }
    }
    
    //用户协议
    @objc func didSelectedAgreement() {
        let vc = PVAgreementWebVC.init(url: "", title: "用户协议")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //隐私
    @objc func didSelectedPrivacy() {
        let vc = PVAgreementWebVC.init(url: "", title: "隐私政策")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK: - 注册
extension PVRegisterVC {
    
    //获取验证码
    @objc func didClickGetAuthCode(sender: UIButton) {
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
            var t = 59
            
            self.timer.setEventHandler {
                if t <= 1 {
                    self.timer.suspend()
                    DispatchQueue.main.async {
                        sender.setTitle("获取验证码", for: .normal)
                        sender.isEnabled = true
                    }
                }
                else {
                    t -= 1
                    DispatchQueue.main.async {
                        sender.setTitle("已发送(\(t))", for: .normal)
                        sender.isEnabled = false
                    }
                }
            }
            self.timer.resume()
        }
        
    }
    
    @objc func register(sender: UIButton) {
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
        sender.isEnabled = false
        PVNetworkTool.Request(router: .register(phone: phoneTF.text!, msgcode: authCodeTF.text!, inviteCode: ""), success: { (resp) in
            sender.isEnabled = true
            
            let vc = PVRegisterPsdVC.init(phone: self.phoneTF.text!)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }) { (e) in
            sender.isEnabled = true
            self.view.makeToast(e.localizedDescription)
        }
    }
    
    @objc func checkboxSelected(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isSelectedClause = sender.isSelected
        registerBtn.isEnabled = phoneTF.hasText && authCodeTF.hasText && isSelectedClause
    }
    
    //用户协议
    func didSelectedAgreement() {
        let vc = PVAgreementWebVC.init(url: "", title: "用户协议")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //隐私
    func didSelectedPrivacy() {
        let vc = PVAgreementWebVC.init(url: "", title: "隐私政策")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PVRegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        registerBtn.isEnabled = phoneTF.hasText && authCodeTF.hasText && isSelectedClause
    }
}

//MARK: - 注册设置密码
extension PVRegisterPsdVC {
    
    @objc func confirmAction(sender: UIButton) {
        guard psdTF_1.hasText else {
            view.makeToast("请输入密码")
            return
        }
        guard psdTF_2.hasText else {
            view.makeToast("请再次输入密码")
            return
        }
        guard psdTF_1.text! == psdTF_2.text! else {
            view.makeToast("两次输入的密码不一致")
            return
        }
        sender.isEnabled = false
        PVNetworkTool.Request(router: .changePsd(userId: "", phone: phone, psd: psdTF_1.text!), success: { (resp) in
            sender.isEnabled = true
            
        }) { (e) in
            sender.isEnabled = true
            self.view.makeToast(e.localizedDescription)
        }
    }
    
}
