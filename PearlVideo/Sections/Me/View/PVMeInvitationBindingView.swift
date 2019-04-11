//
//  PVMeInvitationBindingView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/8.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeInvitationBindingView: UIView {

    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = UIColor.white
        return l
    }()
    lazy var imgIV: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 35 * KScreenRatio_6
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.contents = UIImage.init(named: "me_绑定成功bg")?.cgImage
        addSubview(nameLabel)
        addSubview(imgIV)
        nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20 * KScreenRatio_6)
            make.right.equalToSuperview()
        }
        imgIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6))
            make.centerX.bottom.equalToSuperview()
        }
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
