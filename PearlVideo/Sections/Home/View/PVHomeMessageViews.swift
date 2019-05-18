//
//  PVHomeMessageViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/14.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 通知
class PVHomeMsgNoticeCell: PVBaseTableCell {
    
    public var data: PVHomeNoticeMessageList! {
        didSet{
            titleLabel.text = data.title
            detailLabel.text = data.content
            dateLabel.text = data.createAt
            iconIV.kf.setImage(with: URL.init(string: data.senderAvatarUrl))
        }
    }
    
    lazy var iconIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "home_系统通知"))
        return v
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
        l.textColor = UIColor.white
        l.numberOfLines = 0
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        return l
    }()
    lazy var arrowIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "right_arrow"))
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kColor_background
        contentView.addSubview(iconIV)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(arrowIV)
        separatorView.backgroundColor = kColor_deepBackground
        separatorView.snp.updateConstraints { (make) in
            make.height.equalTo(5)
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconIV)
            make.left.equalTo(iconIV.snp.right).offset(10 * KScreenRatio_6)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.right.equalTo(arrowIV.snp.left)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
        arrowIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20, height: 20))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
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
        iconIV.image = nil
    }
    
}

//MARK: - 评论
class PVHomeMsgCommentCell: PVBaseTableCell {
    
    public var data: PVHomeMessageList! {
        didSet{
            avatarIV.kf.setImage(with: URL.init(string: data.senderAvatarUrl))
            titleLabel.text = data.senderNickname
            dateLabel.text = data.createAt
            imgIV.kf.setImage(with: URL.init(string: data.videoThumbnailUrl))
        }
    }
    
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2, fillColor: kColor_background!)
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.numberOfLines = 0
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        return l
    }()
    lazy var imgIV: UIImageView = {
        let v = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: 4, fillColor: kColor_background!)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kColor_background
        contentView.addSubview(avatarIV)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(imgIV)
        separatorView.backgroundColor = kColor_deepBackground
        separatorView.snp.updateConstraints { (make) in
            make.height.equalTo(5)
        }
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarIV)
            make.left.equalTo(avatarIV.snp.right).offset(10 * KScreenRatio_6)
            make.right.equalTo(imgIV.snp.left).offset(5)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
        imgIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarIV.image = nil
        titleLabel.attributedText = nil
        detailLabel.text = nil
        dateLabel.text = nil
        imgIV.image = nil
    }
    
}

//MARK: - 点赞
class PVHomeMsgLikeCell: PVBaseTableCell {
    
    public var data: PVHomeMessageList! {
        didSet{
            avatarIV.kf.setImage(with: URL.init(string: data.senderAvatarUrl))
            titleLabel.text = data.senderNickname
            dateLabel.text = data.createAt
            imgIV.kf.setImage(with: URL.init(string: data.videoThumbnailUrl))
        }
    }
    
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2, fillColor: kColor_background!)
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = kColor_text
        l.font = kFont_text
        return l
    }()
    lazy var badgeView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_pink
        v.layer.cornerRadius = 2.5
        v.isHidden = true
        return v
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.text = "赞了你的视频"
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        return l
    }()
    lazy var imgIV: UIImageView = {
        let v = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: 4, fillColor: kColor_background!)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kColor_background
        contentView.addSubview(avatarIV)
        contentView.addSubview(titleLabel)
        contentView.addSubview(badgeView)
        contentView.addSubview(detailLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(imgIV)
        separatorView.backgroundColor = kColor_deepBackground
        separatorView.snp.updateConstraints { (make) in
            make.height.equalTo(5)
        }
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarIV)
            make.left.equalTo(avatarIV.snp.right).offset(10 * KScreenRatio_6)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
        imgIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if titleLabel.width > 0 && badgeView.isHidden == false {
            badgeView.snp.remakeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 5, height: 5))
                make.left.equalTo(titleLabel.snp.right).offset(1)
                make.bottom.equalTo(titleLabel.snp.top).offset(-1)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarIV.image = nil
        titleLabel.text = nil
        detailLabel.text = nil
        dateLabel.text = nil
        imgIV.image = nil
        badgeView.isHidden = true
    }
    
}

//MARK: - 关注
class PVHomeMsgAttentionCell: PVBaseTableCell {
    
    public var data: PVHomeMessageList! {
        didSet{
            avatarIV.kf.setImage(with: URL.init(string: data.senderAvatarUrl))
            titleLabel.text = data.senderNickname
            dateLabel.text = data.createAt
        }
    }
    
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2, fillColor: kColor_background!)
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = kColor_text
        l.font = kFont_text
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.text = "关注了你"
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = kColor_background
        contentView.addSubview(avatarIV)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(dateLabel)
        separatorView.backgroundColor = kColor_deepBackground
        separatorView.snp.updateConstraints { (make) in
            make.height.equalTo(5)
        }
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarIV)
            make.left.equalTo(avatarIV.snp.right).offset(10 * KScreenRatio_6)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarIV.image = nil
        titleLabel.text = nil
        detailLabel.text = nil
        dateLabel.text = nil
    }
    
}
