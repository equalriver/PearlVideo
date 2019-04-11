//
//  PVMeUserinfoEditCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeUserinfoEditCell: PVBaseTableCell {
    

    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var contentTF: UITextField = {
        let l = UITextField()
        l.font = kFont_text
        l.textColor = kColor_text
        l.isUserInteractionEnabled = false
        return l
    }()
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "right_arrow"))
        return iv
    }()
    
    required convenience init(placeholder: String) {
        self.init(style: .default, reuseIdentifier: nil)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentTF)
        contentView.addSubview(arrowIV)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        contentTF.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(100 * KScreenRatio_6)
            make.right.equalTo(arrowIV.snp.left).offset(-180 * KScreenRatio_6)
        }
        arrowIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }

}


//MARK: - signing view
protocol SigningViewDelegate: NSObjectProtocol {
    func signingTextChange(textView: YYTextView, _ count: @escaping (String) -> Void)
}

class PVMeUserinfoEditSigningView: UIView, YYTextViewDelegate {
    
    weak public var delegate: SigningViewDelegate?
    
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.text = "签名"
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.text = "0/\(kSigningLimitCount)"
        l.textAlignment = .right
        return l
    }()
    lazy var backgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var contentTV: YYTextView = {
        let v = YYTextView()
        v.backgroundColor = kColor_background
        v.placeholderText = "编辑你的个性签名"
        v.placeholderFont = kFont_text_3
        v.placeholderTextColor = kColor_subText
        v.delegate = self
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(countLabel)
        addSubview(backgroundView)
        backgroundView.addSubview(contentTV)
        nameLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        countLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-30 * KScreenRatio_6)
        }
        backgroundView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 90 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        contentTV.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 300 * KScreenRatio_6, height: 60 * KScreenRatio_6))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidChange(_ textView: YYTextView) {
        delegate?.signingTextChange(textView: textView, { (count) in
            self.countLabel.text = count
        })
    }
    
}
