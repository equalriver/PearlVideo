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
        
        PVNetworkTool.Request(router: .getAuthCode(phone: phoneTF.text!), success: { (resp) in
            auth()
            
        }) { (e) in
            sender.isEnabled = true
 
        }
        
        func auth() {
            var t = 60
            self.timer.setEventHandler { [weak self] in
                if t <= 1 {
                    self?.timer.suspend()
                    self?.isTimerRun = false
                    DispatchQueue.main.async {
                        sender.setTitle("获取验证码", for: .normal)
                        sender.backgroundColor = kColor_pink
                        sender.isEnabled = true
                    }
                }
                else {
                    t -= 1
                    DispatchQueue.main.async {
                        sender.setTitle("已发送(\(t))", for: .normal)
                        sender.backgroundColor = UIColor.gray
                        sender.isEnabled = false
                    }
                }
            }
            if isTimerRun == false { timer.resume() }
            isTimerRun = true
            authCodeTF.becomeFirstResponder()
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
            if let token = resp["result"]["token"].string {
                UserDefaults.standard.set(token, forKey: kToken)
            }
            if let userId = resp["result"]["userId"].string {
                UserDefaults.standard.set(userId, forKey: kUserId)
            }
            UserDefaults.standard.synchronize()
            let vc = PVRegisterPsdVC.init(phone: self.phoneTF.text!)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }) { (e) in
            sender.isEnabled = true
            
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
        let vc = PVAgreementWebVC.init(url: kUserAgreementURL, title: "用户协议")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //隐私
    func didSelectedPrivacy() {
        let vc = PVAgreementWebVC.init(url: kSecureURL, title: "隐私政策")
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
    
    @objc func textFieldChange(sender: UITextField) {
        registerBtn.isEnabled = phoneTF.hasText && authCodeTF.hasText && inviteTF.hasText && isSelectedClause
        registerBtn.backgroundColor = registerBtn.isEnabled ? kColor_pink : UIColor.gray
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
        let userId = UserDefaults.standard.string(forKey: kUserId) ?? ""
        PVNetworkTool.Request(router: .changePsd(userId: userId, phone: phone, psd: psd_1), success: { (resp) in
            sender.isEnabled = true
            NotificationCenter.default.post(name: .kNotiName_refreshMeVC, object: nil)
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }) { (e) in
            sender.isEnabled = true
            
        }
    }
    
    @objc func textFieldChange(sender: UITextField) {
        if sender.tag == 0 { psd_1 = sender.text ?? "" }
        else { psd_2 = sender.text ?? "" }
        confirmBtn.isEnabled = psd_1.count > 0 && psd_2.count > 0
        confirmBtn.backgroundColor = confirmBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
}


