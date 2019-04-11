//
//  PVLoginChildVCPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import Foundation


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
    
    //切换登录模式
    @objc func didSelectedLoginType(sender: UIButton) {
        sender.isSelected = !sender.isSelected
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
    @objc func login() {
        
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
    
    @objc func register() {
        
    }
    
    @objc func checkboxSelected(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {}
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
        
    }
    
}
