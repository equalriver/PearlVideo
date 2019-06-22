//
//  PVLoginPro.swift
//  yjkj-PV-ios
//
//  Created by equalriver on 2019/1/21.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - action
extension PVLoginVC {
    
    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //获取验证码
    @objc func getAuthCode(sender: UIButton) {
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
                        sender.setTitle("重新发送(\(t)s)", for: .normal)
                        sender.backgroundColor = UIColor.gray
                        sender.isEnabled = false
                    }
                }
            }
            if isTimerRun == false { timer.resume() }
            isTimerRun = true
            authCodeTF.becomeFirstResponder()
        }

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

        }
        
    }
    
    //登录方式切换
    @objc func loginTypeChange(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isPasswordLogin = !sender.isSelected
        if sender.isSelected {
            UIView.animate(withDuration: 0.3) {
                self.passwordTF.transform = CGAffineTransform.init(translationX: -kScreenWidth, y: 0)
                self.authCodeTF.transform = CGAffineTransform.init(translationX: -kScreenWidth, y: 0)
                self.getAuthCodeBtn.transform = CGAffineTransform.init(translationX: -kScreenWidth, y: 0)
            }
        }
        else {
            UIView.animate(withDuration: 0.3) {
                self.passwordTF.transform = CGAffineTransform.identity
                self.authCodeTF.transform = CGAffineTransform.identity
                self.getAuthCodeBtn.transform = CGAffineTransform.identity
            }
        }
    }
    
    @objc func forgetPassword(sender: UIButton) {
        let vc = PVForgetPsdVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func login(sender: UIButton) {
//        guard UserDefaults.standard.string(forKey: kUserLocation) != nil else {
//            YPJOtherTool.ypj.getLocationAuth(target: self, manager: locationManager)
//            return
//        }
        
        func userLogin() {
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
                if let token = resp["result"]["token"].string {
                    UserDefaults.standard.set(token, forKey: kToken)
                }
                if let userId = resp["result"]["userId"].string {
                    UserDefaults.standard.set(userId, forKey: kUserId)
                }
                UserDefaults.standard.synchronize()
                self.loginCallback?(true)
                self.dismiss(animated: true, completion: nil)
                
            }) { (e) in
                sender.isEnabled = true
            }
        }
        
        //
        userLogin()
    }
    
    @objc func register(sender: UIButton) {
        let vc = PVRegisterVC()
        navigationController?.pushViewController(vc, animated: true)
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
    
    @objc func textFieldChange(sender: UITextField) {
        if isPasswordLogin {
            loginBtn.isEnabled = phoneTF.hasText && passwordTF.hasText
        }
        else {
            loginBtn.isEnabled = phoneTF.hasText && authCodeTF.hasText
        }
        loginBtn.backgroundColor = loginBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
}

extension PVLoginVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            view.makeToast("获取定位信息失败")
            return
        }
        let coder = CLGeocoder.init()
        coder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                self.view.makeToast("获取定位信息失败")
                return
            }
            guard let placemark = placemarks?.first else { return }
            guard let city = placemark.addressDictionary?["City"] as? String else {
                self.view.makeToast("获取定位信息失败")
                return
            }
            
        }
        
    }
    
}
