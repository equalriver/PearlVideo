//
//  PVMeMessageVCChildView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/8.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 通知
class PVMeMessageNoticeCell: PVBaseTableCell {
    
    lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_subText
        return l
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kColor_background
        initUI()
        //addShape
        let rect = CGRect.init(x: 0, y: 0, width: 360 * KScreenRatio_6, height: 80 * KScreenRatio_6)
        bgView.ypj.makeViewRoundingMask(roundedRect: rect, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: 5, height: 5))
        
        let rect_1 = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iconIV.ypj.makeViewRoundingMask(roundedRect: rect_1, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: rect.height / 2, height: rect.height / 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(iconIV)
        bgView.addSubview(titleLabel)
        bgView.addSubview(detailLabel)
        bgView.addSubview(dateLabel)
        bgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 360 * KScreenRatio_6, height: 80 * KScreenRatio_6))
            make.center.equalToSuperview()
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.left.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconIV)
            make.left.equalTo(iconIV.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        titleLabel.text = nil
        detailLabel.text = nil
        dateLabel.text = nil
    }
    
}


//MARK: - 评论
class PVMeMessageCommentCell: PVBaseTableCell {
    
    lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_subText
        return l
    }()
    lazy var rightImgIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kColor_background
        initUI()
        addShape()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(iconIV)
        bgView.addSubview(titleLabel)
        bgView.addSubview(detailLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(rightImgIV)
        bgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 360 * KScreenRatio_6, height: 80 * KScreenRatio_6))
            make.center.equalToSuperview()
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.left.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconIV)
            make.left.equalTo(iconIV.snp.right).offset(10)
            make.right.equalTo(rightImgIV.snp.left).offset(-10)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        rightImgIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    func addShape() {
        let rect = CGRect.init(x: 0, y: 0, width: 360 * KScreenRatio_6, height: 80 * KScreenRatio_6)
        bgView.ypj.makeViewRoundingMask(roundedRect: rect, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: 5, height: 5))
        
        let rect_1 = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iconIV.ypj.makeViewRoundingMask(roundedRect: rect_1, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: rect.height / 2, height: rect.height / 2))
        
        let rect_2 = CGRect.init(x: 0, y: 0, width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6)
        rightImgIV.ypj.makeViewRoundingMask(roundedRect: rect_2, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: 5, height: 5))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        titleLabel.attributedText = nil
        detailLabel.text = nil
        dateLabel.text = nil
        rightImgIV.image = nil
    }
    
}


//MARK: - 点赞
class PVMeMessageLikeCell: PVBaseTableCell {
    
    lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var badgeView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.red
        v.isHidden = true
        let rect = CGRect.init(x: 0, y: 0, width: 5, height: 5)
        v.ypj.makeViewRoundingMask(roundedRect: rect, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: rect.height / 2, height: rect.height / 2))
        
        return v
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_subText
        return l
    }()
    lazy var rightImgIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kColor_background
        initUI()
        addShape()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(iconIV)
        bgView.addSubview(titleLabel)
        bgView.addSubview(badgeView)
        bgView.addSubview(detailLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(rightImgIV)
        bgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 360 * KScreenRatio_6, height: 80 * KScreenRatio_6))
            make.center.equalToSuperview()
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.left.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconIV)
            make.left.equalTo(iconIV.snp.right).offset(10)
            make.right.equalTo(rightImgIV.snp.left).offset(-10)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        rightImgIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        badgeView.frame = CGRect.init(x: titleLabel.origin.x + titleLabel.width + 1, y: titleLabel.origin.y - 5 - 1, width: 5, height: 5)
    }
    
    func addShape() {
        let rect = CGRect.init(x: 0, y: 0, width: 360 * KScreenRatio_6, height: 80 * KScreenRatio_6)
        bgView.ypj.makeViewRoundingMask(roundedRect: rect, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: 5, height: 5))
        
        let rect_1 = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iconIV.ypj.makeViewRoundingMask(roundedRect: rect_1, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: rect.height / 2, height: rect.height / 2))
        
        let rect_2 = CGRect.init(x: 0, y: 0, width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6)
        rightImgIV.ypj.makeViewRoundingMask(roundedRect: rect_2, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: 5, height: 5))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        titleLabel.text = nil
        detailLabel.text = nil
        dateLabel.text = nil
        rightImgIV.image = nil
    }
    
}


//MARK: - 关注
class PVMeMessageAttentionCell: PVBaseTableCell {
    
    lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_subText
        return l
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kColor_background
        initUI()
        addShape()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(iconIV)
        bgView.addSubview(titleLabel)
        bgView.addSubview(detailLabel)
        bgView.addSubview(dateLabel)
        bgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 360 * KScreenRatio_6, height: 80 * KScreenRatio_6))
            make.center.equalToSuperview()
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.left.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconIV)
            make.left.equalTo(iconIV.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
    }
    
    func addShape() {
        let rect = CGRect.init(x: 0, y: 0, width: 360 * KScreenRatio_6, height: 80 * KScreenRatio_6)
        bgView.ypj.makeViewRoundingMask(roundedRect: rect, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: 5, height: 5))
        
        let rect_1 = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iconIV.ypj.makeViewRoundingMask(roundedRect: rect_1, corners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: rect.height / 2, height: rect.height / 2))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        titleLabel.text = nil
        detailLabel.text = nil
        dateLabel.text = nil
    }
    
}
