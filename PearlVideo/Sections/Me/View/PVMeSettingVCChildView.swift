//
//  PVMeSettingVCChildView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - 实名认证
class PVMeNameValidateCell: PVBaseTableCell {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var detailTF: UITextField = {
        let tf = UITextField()
        tf.font = kFont_text
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    required convenience init(title: String, tag: Int, textField delegate: UITextFieldDelegate) {
        self.init(style: .default, reuseIdentifier: nil)
        titleLabel.text = title
        detailTF.placeholder = "请输入" + title
        detailTF.tag = tag
        detailTF.delegate = delegate
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailTF)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if titleLabel.width > 0 {
            detailTF.snp.remakeConstraints { (make) in
                make.left.equalTo(titleLabel.snp.right).offset(40 * KScreenRatio_6)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            }
        }
    }
}



//MARK: - 意见反馈
class PVMeFeedbackItemView: UIView {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var contentTV: YYTextView = {
        let tv = YYTextView()
        tv.font = kFont_text
        tv.textColor = kColor_text
        tv.placeholderFont = kFont_text
        tv.placeholderTextColor = kColor_subText
        return tv
    }()
    lazy var sepView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    
    required convenience init(title: String, placeholder: String, delegate: YYTextViewDelegate) {
        self.init()
        titleLabel.text = title
        contentTV.placeholderText = placeholder
        contentTV.delegate = delegate
        
        addSubview(titleLabel)
        addSubview(contentTV)
        addSubview(sepView)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        contentTV.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(15 * KScreenRatio_6)
            make.left.equalTo(titleLabel)
            make.right.bottom.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        sepView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.bottom.width.centerX.equalToSuperview()
        }
    }
    
}

protocol PVMeFeedbackImageDelegate: NSObjectProtocol {
    func didSeletedDelete(cell: UICollectionViewCell)
}

class PVMeFeedbackCell: UICollectionViewCell {
    
    weak public var delegate: PVMeFeedbackImageDelegate?
    
    lazy var imgIV: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    lazy var deleteBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "setting_delete"), for: .normal)
        b.isHidden = true
        b.addBlock(for: .touchUpInside, block: {[weak self] (btn) in
            if self != nil {self?.delegate?.didSeletedDelete(cell: self!)}
        })
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgIV)
        contentView.addSubview(deleteBtn)
        imgIV.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
            make.top.equalTo(imgIV).offset(-10 * KScreenRatio_6)
            make.right.equalTo(imgIV).offset(10 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgIV.image = nil
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var v = super.hitTest(point, with: event)
        if v == nil {
            let p = deleteBtn.convert(point, from: contentView)
            if deleteBtn.bounds.contains(p){
                v = deleteBtn
            }
        }
        
        return v
    }
    
}


//MARK: - 检测更新
class PVMeVersionCell: PVBaseTableCell {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18 * KScreenRatio_6)
        l.textColor = kColor_text
        return l
    }()
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "right_arrow"))
        return iv
    }()
    
    required convenience init(title: String) {
        self.init(style: .default, reuseIdentifier: nil)
        titleLabel.text = title
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowIV)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(35 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        arrowIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 10, height: 20))
            make.right.equalToSuperview().offset(-30 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
}
