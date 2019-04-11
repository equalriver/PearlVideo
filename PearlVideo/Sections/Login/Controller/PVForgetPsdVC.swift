//
//  PVForgetPsdVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVForgetPsdVC: PVBaseNavigationVC {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24 * KScreenRatio_6, weight: .semibold)
        l.textColor = kColor_text
        l.text = "重置密码"
        return l
    }()
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
        b.setBackgroundImage(UIImage.init(named: ""), for: .normal)
        b.addTarget(self, action: #selector(didClickGetAuthCode(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var nextBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: ""), for: .normal)
        b.titleLabel?.font = kFont_text
        b.setTitle("下一步", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
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
        view.addSubview(nextBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom).offset(20)
        }
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(titleLabel.snp.bottom).offset(40 * KScreenRatio_6)
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
        nextBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(getAuthCodeBtn.snp.bottom).offset(30 * KScreenRatio_6)
        }

    }
    
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
    
    @objc func nextAction() {
        
    }

}


//MARK: -
class PVPasswordChangeVC: PVBaseNavigationVC {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24 * KScreenRatio_6, weight: .semibold)
        l.textColor = kColor_text
        l.text = "重置密码"
        return l
    }()
    lazy var psdTF_1: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请输入新密码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.isSecureTextEntry = true
        return tf
    }()
    lazy var psdTF_2: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请再次输入新密码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.isSecureTextEntry = true
        return tf
    }()
    lazy var confirmBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: ""), for: .normal)
        b.titleLabel?.font = kFont_text
        b.setTitle("进入", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(confirmAction(sender:)), for: .touchUpInside)
        return b
    }()
    
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
    
    @objc func confirmAction(sender: UIButton) {
        guard psdTF_1.hasText else {
            view.makeToast("请输入新密码")
            return
        }
        guard psdTF_2.hasText else {
            view.makeToast("请再次输入新密码")
            return
        }
        guard psdTF_1.text! == psdTF_2.text! else {
            view.makeToast("两次输入的密码不一致")
            return
        }
        sender.isEnabled = false
        
    }
    
}
