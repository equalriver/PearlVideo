//
//  PVAttentionCommentDetailViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - header view
protocol PVAttentionCommentDetailHeaderDelegate: NSObjectProtocol {
    func didSelectedLike(sender: UIButton)
}

class PVAttentionCommentDetailHeaderView: UIView {
    
    weak public var delegate: PVAttentionCommentDetailHeaderDelegate?
    
    
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iv.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2)
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        l.numberOfLines = 0
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    lazy var likeBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "attention_点赞"), for: .normal)
        b.setImage(UIImage.init(named: "attention_点赞_s"), for: .selected)
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
        l.textColor = kColor_text
        l.text = "全部回复"
        return l
    }()
    
    required convenience init(frame: CGRect, delegate: PVAttentionCommentDetailHeaderDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
        initUI()
    }
    
    func initUI() {
        addSubview(iconIV)
        addSubview(nameLabel)
        addSubview(contentLabel)
        addSubview(dateLabel)
        addSubview(likeBtn)
        addSubview(sepView)
        addSubview(replyLabel)
        
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.left.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
            make.top.equalTo(iconIV)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.equalTo(230 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(contentLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.equalTo(contentLabel)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.height.equalTo(40)
        }
        sepView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 10 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        replyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV)
            make.top.equalTo(sepView.snp.bottom).offset(20 * KScreenRatio_6)
        }
        
    }
    
    @objc func likeAction(sender: UIButton) {
        delegate?.didSelectedLike(sender: sender)
    }
    
}


//MARK: - cell
protocol PVAttentionCommentDetailDelegate: NSObjectProtocol {
    func didSelectedHeader(cell: PVAttentionCommentDetailCell)
    func didSelectedLike(cell: PVAttentionCommentDetailCell, sender: UIButton)
}

class PVAttentionCommentDetailCell: PVBaseTableCell {
    
    
    weak public var delegate: PVAttentionCommentDetailDelegate?
    
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iv.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2)
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(headerTap))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_text
        l.numberOfLines = 0
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    lazy var likeBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "attention_点赞"), for: .normal)
        b.setImage(UIImage.init(named: "attention_点赞_s"), for: .selected)
        b.titleLabel?.font = kFont_text_4
        b.setTitleColor(kColor_subText, for: .normal)
        b.addTarget(self, action: #selector(likeAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var ownerTagLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = kColor_pink
        l.text = "作者"
        l.font = kFont_text_4
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.isHidden = true
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(likeBtn)
        contentView.addSubview(ownerTagLabel)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.left.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
            make.top.equalTo(iconIV)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.equalTo(230 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(contentLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.equalTo(contentLabel)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.height.equalTo(40)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if nameLabel.width > 0 {
            ownerTagLabel.snp.remakeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 25 * KScreenRatio_6, height: 13 * KScreenRatio_6))
                make.centerY.equalTo(nameLabel)
                make.left.equalTo(nameLabel.snp.right).offset(10 * KScreenRatio_6)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        nameLabel.text = nil
        contentLabel.text = nil
        dateLabel.text = nil
        likeBtn.setTitle(nil, for: .normal)
    }
    
    @objc func headerTap() {
        delegate?.didSelectedHeader(cell: self)
    }
    
    @objc func likeAction(sender: UIButton) {
        delegate?.didSelectedLike(cell: self, sender: sender)
    }
    
}
