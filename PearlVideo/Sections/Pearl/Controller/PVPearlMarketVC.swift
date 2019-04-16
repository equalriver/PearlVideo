//
//  PVPearlMarketVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVPearlMarketVC: PVBaseWMPageVC {
    
    
    lazy var segmentedView: UISegmentedControl = {
        let v = UISegmentedControl.init(items: ["买单", "卖单"])
        v.tintColor = kColor_pink
        v.backgroundColor = UIColor.white
        v.addTarget(self, action: #selector(segmentedDidSelected(sender:)), for: .touchUpInside)
        return v
    }()
    lazy var sepView: UIView = {
        let v = UIView.init()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var recordBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("交易记录", for: .normal)
        b.setTitleColor(kColor_pink, for: .normal)
        return b
    }()
    lazy var sendBillButton: UIButton = {
        let b = UIButton()
        b.layer.shadowColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1).cgColor
        b.layer.shadowOffset = CGSize(width: 0, height: 6)
        b.layer.shadowOpacity = 1
        b.layer.shadowRadius = 36.5
        b.titleLabel?.font = kFont_btn_weight
        b.setTitle("发单", for: .normal)
        b.setTitleColor(UIColor.init(hexString: "#FF7561"), for: .normal)
        b.layer.cornerRadius = 35 * KScreenRatio_6
        b.backgroundColor = UIColor.white
        b.addTarget(self, action: #selector(didSelectedSendBill), for: .touchUpInside)
        return b
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "珍珠集市"
        naviBar.rightBarButtons = [recordBtn]
        initUI()
    }
    
    func initUI() {
        view.addSubview(segmentedView)
        view.addSubview(sepView)
        view.addSubview(sendBillButton)
        segmentedView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 250 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.top.equalTo(naviBar.snp.bottom).offset(20 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        sepView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 0.5))
            make.centerX.equalToSuperview()
            make.top.equalTo(segmentedView.snp.bottom).offset(15 * KScreenRatio_6)
        }
        sendBillButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-60 * KScreenRatio_6)
        }
    }
    
    @objc func segmentedDidSelected(sender: UISegmentedControl) {
        
    }

    @objc func didSelectedSendBill() {
        
    }

}
