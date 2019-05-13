//
//  PVHomeVCChildViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 会员等级
class PVHomeUserLevelHeaderView: UIView {
    
    lazy var levelLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 30 * KScreenRatio_6, weight: UIFont.Weight.semibold)
        l.textColor = kColor_yellow
        l.textAlignment = .center
        return l
    }()
    lazy var levelBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = UIFont.systemFont(ofSize: 24 * KScreenRatio_6, weight: UIFont.Weight.semibold)
        b.setTitleColor(kColor_text, for: .normal)
        b.setTitle(" 会员等级", for: .normal)
        b.setImage(UIImage.init(named: "home_level_diamond"), for: .normal)
        return b
    }()
    lazy var xpLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var noticeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.contents = UIImage.init(named: "home_level_bg")!.cgImage
        addSubview(levelLabel)
        addSubview(levelBtn)
        addSubview(xpLabel)
        addSubview(noticeLabel)
        levelLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
            make.centerX.width.equalToSuperview()
        }
        levelBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(levelLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
        xpLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(levelBtn.snp.bottom).offset(15 * KScreenRatio_6)
        }
        noticeLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(xpLabel)
            make.top.equalTo(xpLabel.snp.bottom).offset(12 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PVHomeUserLevelCell: PVBaseTableCell {
    
    lazy var backgroundBgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var levelLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    lazy var chargeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        l.textAlignment = .right
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isNeedSeparatorView = false
        backgroundColor = kColor_deepBackground
        contentView.backgroundColor = kColor_deepBackground
        contentView.addSubview(backgroundBgView)
        backgroundBgView.addSubview(levelLabel)
        backgroundBgView.addSubview(detailLabel)
        backgroundBgView.addSubview(chargeLabel)
        backgroundBgView.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        levelLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(levelLabel)
            make.top.equalTo(levelLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        chargeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.centerY.equalTo(detailLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        levelLabel.attributedText = nil
        detailLabel.text = nil
        chargeLabel.text = nil
    }
}

//MARK: - 活跃度
class PVHomeActivenessHeaderView: UIView {
    
    lazy var activenessLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 30 * KScreenRatio_6, weight: UIFont.Weight.semibold)
        l.textColor = UIColor.white
        l.textAlignment = .center
        return l
    }()
    lazy var activenessBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = UIFont.systemFont(ofSize: 24 * KScreenRatio_6, weight: UIFont.Weight.semibold)
        b.setTitleColor(kColor_text, for: .normal)
        b.setTitle(" 当前活跃度", for: .normal)
        b.setImage(UIImage.init(named: "home_活跃度"), for: .normal)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_deepBackground
        addSubview(activenessLabel)
        addSubview(activenessBtn)
        activenessLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
            make.centerX.width.equalToSuperview()
        }
        activenessBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(activenessLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PVHomeActivenessCell: PVBaseTableCell {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = UIColor.white
        l.textAlignment = .right
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isNeedSeparatorView = false
        backgroundColor = kColor_deepBackground
        contentView.backgroundColor = kColor_deepBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(dateLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        detailLabel.text = nil
        dateLabel.text = nil
    }
}


//MARK: - 商学院
//视频区
class PVHomeSchoolVideoCell: PVBaseTableCell {
    
    lazy var imgIV: UIImageView = {
        let iv = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 120 * KScreenRatio_6, height: 70 * KScreenRatio_6)
        iv.ypj.addCornerShape(rect: rect, cornerRadius: 3, fillColor: kColor_background!)
        return iv
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_btn_weight
        l.textColor = UIColor.white
        return l
    }()
    lazy var timeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        contentView.addSubview(imgIV)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        imgIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 120 * KScreenRatio_6, height: 70 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgIV.snp.right).offset(15 * KScreenRatio_6)
            make.top.equalTo(imgIV)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(imgIV).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgIV.image = nil
        timeLabel.text = nil
        titleLabel.text = nil
    }
}

//新手指南
class PVHomeSchoolGuideCell: PVBaseTableCell {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.numberOfLines = 0
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.bottom.equalTo(dateLabel.snp.top).offset(-15 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        titleLabel.text = nil
    }
}
