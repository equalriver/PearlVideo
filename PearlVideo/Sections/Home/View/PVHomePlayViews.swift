//
//  PVHomeViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - navigation bar view
protocol PVHomeNaviBarDelegate: NSObjectProtocol {
    func didSelectedComment()
    func didSelectedLike(sender: UIButton)
    func didSelectedShare()
    func didSelectedReport()
}

class PVHomeNaviBarView: UIView {
    
    weak public var delegate: PVHomeNaviBarDelegate?
    
    lazy var commentBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "home_comment"), for: .normal)
        b.addTarget(self, action: #selector(comment(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var likeBtn: UIButton = {
        let b = UIButton()
        b.contentHorizontalAlignment = .left
        b.titleLabel?.font = kFont_text_3
        b.setTitleColor(kColor_subText, for: .normal)
        b.setImage(UIImage.init(named: "attention_点赞"), for: .normal)
        b.setImage(UIImage.init(named: "attention_点赞_s"), for: .selected)
        b.addTarget(self, action: #selector(likeAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var shareBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "attention_转发"), for: .normal)
        b.addTarget(self, action: #selector(share(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var reportBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "attention_举报"), for: .normal)
        b.addTarget(self, action: #selector(report(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(commentBtn)
        addSubview(likeBtn)
        addSubview(shareBtn)
        addSubview(reportBtn)
        commentBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.left.equalToSuperview().offset(10 * KScreenRatio_6)
            make.top.equalToSuperview().offset(30 * KScreenRatio_6)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(commentBtn)
            make.left.equalTo(commentBtn.snp.right).offset(20 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if likeBtn.width > 0 {
            shareBtn.snp.remakeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 30, height: 30))
                make.centerY.equalTo(commentBtn)
                make.left.equalTo(likeBtn.snp.right).offset(20 * KScreenRatio_6)
            }
            reportBtn.snp.remakeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 30, height: 30))
                make.centerY.equalTo(commentBtn)
                make.left.equalTo(shareBtn.snp.right).offset(20 * KScreenRatio_6)
            }
        }
    }
    
    @objc func comment(sender: UIButton) {
        delegate?.didSelectedComment()
    }
    
    @objc func likeAction(sender: UIButton) {
        delegate?.didSelectedLike(sender: sender)
    }
    
    @objc func share(sender: UIButton) {
        delegate?.didSelectedShare()
    }
    
    @objc func report(sender: UIButton) {
        delegate?.didSelectedReport()
    }
    
}


//MARK: - info view
protocol PVHomeVideoInfoDelegate: NSObjectProtocol {
    ///点击头像
    func didClickHead()
    func didSelectedAttention(sender: UIButton)
}

class PVHomeVideoInfoView: UIView {
    
    weak public var delegate: PVHomeVideoInfoDelegate?
    
    
    lazy var headerBtn: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.contentMode = .scaleAspectFill
        b.addTarget(self, action: #selector(didClickHead), for: .touchUpInside)
        return b
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
    }()
    lazy var attentionBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "home_关注"), for: .normal)
        b.setImage(UIImage.init(named: "home_已关注"), for: .selected)
        b.addTarget(self, action: #selector(attention(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.numberOfLines = 2
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerBtn)
        addSubview(nameLabel)
        addSubview(attentionBtn)
        addSubview(detailLabel)
        headerBtn.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerBtn)
            make.left.equalTo(headerBtn.snp.right).offset(10)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerBtn)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(headerBtn.snp.bottom).offset(15 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if nameLabel.width > 0 {
            attentionBtn.snp.remakeConstraints { (make) in
                make.left.equalTo(nameLabel.snp.right).offset(15 * KScreenRatio_6)
                make.centerY.equalTo(nameLabel)
            }
        }
    }
    
    public func clearData() {
        headerBtn.setImage(nil, for: .normal)
        nameLabel.text = nil
        detailLabel.text = nil
        attentionBtn.isSelected = false
    }
    
    @objc func didClickHead() {
        delegate?.didClickHead()
    }
    
    @objc func attention(sender: UIButton) {
        delegate?.didSelectedAttention(sender: sender)
    }
    
}


//MARK: - collection view cell
class PVHomeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: - 评论弹出页
protocol PVHomeCommentDelegate: NSObjectProtocol {
    func didSelectedClose()
}

class PVHomeCommentView: UIView {
    
    
    weak public var delegate: PVHomeCommentDelegate?
    
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.textAlignment = .center
        return l
    }()
    lazy var closeBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "attention_close"), for: .normal)
        b.addTarget(self, action: #selector(closeAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.register(PVAttentionCommentDetailCell.self, forCellReuseIdentifier: "PVAttentionCommentDetailCell")
        return tb
    }()
    lazy var commentInputView: PVAttentionDetailCommentInputView = {
        let v = PVAttentionDetailCommentInputView.init(frame: .zero, delegate: self)
        v.delegate = self
        return v
    }()
    
    
    required convenience init(delegate: PVHomeCommentDelegate) {
        self.init()
        self.delegate = delegate
        initUI()
        self.ypj.viewAnimateComeFromBottom(duration: 0.3) { (isFinish) in
            if isFinish { self.isHidden = false }
        }
    }
    
    func initUI() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(closeBtn)
        contentView.addSubview(tableView)
        contentView.addSubview(commentInputView)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        closeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(CGSize.init(width: 30 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-10)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50 * KScreenRatio_6)
            make.centerX.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50 * KScreenRatio_6)
        }
        commentInputView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 50 * KScreenRatio_6))
            make.bottom.centerX.equalToSuperview()
        }
    }
    
    
    
    
}


