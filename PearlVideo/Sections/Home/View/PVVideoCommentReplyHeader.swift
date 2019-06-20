//
//  PVVideoCommentReplyHeader.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/24.
//  Copyright © 2019 equalriver. All rights reserved.
//

protocol PVVideoCommentReplyHeaderDelegate: NSObjectProtocol {
    func didSelectedAvatar()
    func didSelectedLike(sender: UIButton)
    func didSelectedDismiss()
}

class PVVideoCommentReplyHeader: UIView {
    
    public var delegate: PVVideoCommentReplyHeaderDelegate?
    
    public var data: PVCommentReplyModel! {
        didSet{
            titleLabel.text = "\(data.replyCount)条回复"
            iconIV.kf.setImage(with: URL.init(string: data.avatarUrl))
            nameLabel.text = data.nickname
            contentLabel.text = data.content
            dateLabel.text = data.createAt
            likeBtn.isSelected = data.status == 1
            likeBtn.setTitle("\(data.commentThumbupCount)", for: .normal)
        }
    }
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        l.textAlignment = .center
        return l
    }()
    lazy var dismissBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "video_close"), for: .normal)
        b.addTarget(self, action: #selector(dismissAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iv.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2, fillColor: kColor_deepBackground!)
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(headerTap))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        return l
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
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
    lazy var likeBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "video_评论点赞"), for: .normal)
        b.setImage(UIImage.init(named: "video_评论点赞_s"), for: .selected)
        b.titleLabel?.font = kFont_text_4
        b.setTitleColor(kColor_subText, for: .normal)
        b.addTarget(self, action: #selector(likeAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var sepView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var replyLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.backgroundColor = kColor_deepBackground
        l.text = "全部回复"
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_deepBackground
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(titleLabel)
        addSubview(dismissBtn)
        addSubview(iconIV)
        addSubview(nameLabel)
        addSubview(contentLabel)
        addSubview(dateLabel)
        addSubview(likeBtn)
        addSubview(sepView)
        addSubview(replyLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(2)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(15)
        }
        dismissBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(25)
        }
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalTo(titleLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
            make.top.equalTo(iconIV)
            make.height.equalTo(15)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.equalTo(kCommentContentWidth)
            make.bottom.equalTo(dateLabel.snp.top).offset(-8 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.width.equalTo(contentLabel)
            make.bottom.equalTo(sepView.snp.top).offset(-10 * KScreenRatio_6)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(iconIV)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.height.equalTo(40)
        }
        sepView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(8)
            make.bottom.equalTo(replyLabel.snp.top).offset(-20 * KScreenRatio_6)
        }
        replyLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.bottom.equalToSuperview().offset(-15 * KScreenRatio_6)
        }
    }
    
    
    @objc func headerTap() {
        delegate?.didSelectedAvatar()
    }
    
    @objc func likeAction(sender: UIButton) {
        delegate?.didSelectedLike(sender: sender)
    }
    
    @objc func dismissAction(sender: UIButton) {
        delegate?.didSelectedDismiss()
    }
    
}
