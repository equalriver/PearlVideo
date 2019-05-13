//
//  PVLoginChildVCPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - 注册
extension PVRegisterVC {
    
    //获取验证码
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
        PVNetworkTool.Request(router: .register(phone: phoneTF.text!, msgcode: authCodeTF.text!, inviteCode: inviteTF.text ?? ""), success: { (resp) in
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
        registerBtn.isEnabled = phoneTF.hasText && authCodeTF.hasText && inviteTF.hasText && isSelectedClause
        registerBtn.backgroundColor = registerBtn.isEnabled ? kColor_pink : UIColor.gray
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
    
    @objc func keyboardShowAction(noti: Notification) {
        guard let info = noti.userInfo else { return }
        guard let duration = info[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        guard let keyboardFrame = info[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let tf_y = currentTextFieldRect.origin.y + currentTextFieldRect.height + 10
        let y = keyboardFrame.origin.y - tf_y
        if y > 0 { return }
        UIView.animate(withDuration: duration) {
            self.view.centerY = kScreenHeight / 2 + y
        }
        
    }
    
    @objc func keyboardHideAction(noti: Notification) {
        guard let info = noti.userInfo else { return }
        guard let duration = info[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        UIView.animate(withDuration: duration) {
            self.view.center = CGPoint.init(x: kScreenWidth / 2, y: kScreenHeight / 2)
        }
        
    }
    
}

extension PVRegisterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentTextFieldRect = textField.frame
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        registerBtn.isEnabled = phoneTF.hasText && authCodeTF.hasText && inviteTF.hasText && isSelectedClause
        registerBtn.backgroundColor = registerBtn.isEnabled ? kColor_pink : UIColor.gray
        return true
    }
    
}

//MARK: - 注册设置密码
extension PVRegisterPsdVC {
    
    @objc func confirmAction(sender: UIButton) {
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
        PVNetworkTool.Request(router: .changePsd(userId: "", phone: phone, psd: psd_1), success: { (resp) in
            sender.isEnabled = true
            
        }) { (e) in
            sender.isEnabled = true
            self.view.makeToast(e.localizedDescription)
        }
    }
    
}

extension PVRegisterPsdVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard textField.hasText else { return true }
        if textField.tag == 0 { psd_1 = textField.text! }
        else { psd_2 = textField.text! }
        confirmBtn.isEnabled = psd_1.count > 0 && psd_1 == psd_2
        confirmBtn.backgroundColor = confirmBtn.isEnabled ? kColor_pink : UIColor.gray
        return true
    }
    
}
