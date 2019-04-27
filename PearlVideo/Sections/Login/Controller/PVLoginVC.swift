//
//  PVLoginViewController.swift
//  yjkj-PV-ios
//
//  Created by equalriver on 2019/1/7.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVLoginVC: PVBaseWMPageVC {

    lazy var dismissBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "back_arrow"), for: .normal)
        b.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return b
    }()
    lazy var backgroundIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "login_bg"))
        return v
    }()
    lazy var ipTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numbersAndPunctuation
        tf.addTarget(self, action: #selector(ipTextFieldChange(sender:)), for: .editingDidEnd)
        return tf
    }()
    
    
    
    override func viewDidLoad() {
        menuItemWidth = 60 * KScreenRatio_6
        titleSizeNormal = 18 * KScreenRatio_6
        titleSizeSelected = 24 * KScreenRatio_6
        titleColorNormal = kColor_subText!
        titleColorSelected = kColor_text!
        itemsMargins = [20 * KScreenRatio_6, 0, 0] as [NSNumber]
        super.viewDidLoad()
        
        naviBar.isHidden = true
        backgroundIV.addSubview(dismissBtn)
        view.addSubview(backgroundIV)
        backgroundIV.snp.makeConstraints { (make) in
            make.top.width.centerX.equalToSuperview()
            make.height.equalTo(200 * KScreenRatio_6)
        }
        dismissBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(30 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        }
        #if DEBUG
        backgroundIV.addSubview(ipTextField)
        ipTextField.snp.makeConstraints { (make) in
            make.size.equalToSuperview().multipliedBy(0.7)
            make.center.equalToSuperview()
        }
        #endif
        
    }
    
    @objc func ipTextFieldChange(sender: UITextField) {
        guard sender.hasText else { return }
        let ip = "http://192.168.0.\(sender.text!):8080/api/"
        UserDefaults.standard.set(ip, forKey: kLocalIP)
        UserDefaults.standard.synchronize()
    }
    
}
