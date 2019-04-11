//
//  PVMeInvitationCodeVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/8.
//  Copyright © 2019 equalriver. All rights reserved.
//


class PVMeInvitationCodeVC: PVBaseNavigationVC {
    
    
    lazy var codeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = UIColor.white
        return l
    }()
    lazy var copyBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text_3
        b.setTitle("复制", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 10
        b.addTarget(self, action: #selector(copyCode), for: .touchUpInside)
        return b
    }()
    lazy var inputCodeTF: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 18 * KScreenRatio_6)
        tf.textColor = UIColor.init(hexString: "#F98FCF")
        tf.textAlignment = .center
//        let s = NSMutableParagraphStyle.init()
//        s.alignment = .center
        let att = NSAttributedString.init(string: "输入邀请码", attributes: [.font: UIFont.systemFont(ofSize: 18 * KScreenRatio_6), .foregroundColor: UIColor.init(hexString: "#F98FCF")!])//.paragraphStyle
        tf.attributedPlaceholder = att
        return tf
    }()
    lazy var bindingBtn: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "me_ 邀请码绑定"), for: .normal)
        b.addTarget(self, action: #selector(binding), for: .touchUpInside)
        return b
    }()
    lazy var bindingSuccessView: PVMeInvitationBindingView = {
        let v = PVMeInvitationBindingView.init(frame: .zero)
        v.isHidden = true
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        title = "邀请码"
        
    }
    
    
    func initUI() {
        view.addSubview(codeLabel)
        view.addSubview(copyBtn)
        view.addSubview(inputCodeTF)
        view.addSubview(bindingBtn)
        view.addSubview(bindingSuccessView)
        codeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(inputCodeTF).offset(15 * KScreenRatio_6)
            make.bottom.equalTo(codeLabel.snp.top).offset(-30 * KScreenRatio_6)
        }
        inputCodeTF.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 230 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bindingBtn.snp.top).offset(-30 * KScreenRatio_6)
        }
        bindingBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 230 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-130 * KScreenRatio_6)
        }
        bindingSuccessView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 260 * KScreenRatio_6, height: 130 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-120 * KScreenRatio_6)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if codeLabel.width > 0 {
            copyBtn.snp.remakeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 60, height: 20))
                make.centerY.equalTo(codeLabel)
                make.left.equalTo(codeLabel.snp.right).offset(10)
            }
        }
    }
    
    //复制邀请码
    @objc func copyCode() {
        let pasteboard = UIPasteboard.init()
        pasteboard.string = ""
        view.makeToast("复制成功")
    }
    
    @objc func binding() {
        
        
        //绑定成功
        bindingSuccessView.isHidden = false
        inputCodeTF.isHidden = true
        bindingBtn.isHidden = true
    }
    
}
