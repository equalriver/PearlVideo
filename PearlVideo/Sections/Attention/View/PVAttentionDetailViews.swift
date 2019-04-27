//
//  PVAttentionDetailViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 导航
protocol PVAttentionDetailNaviDelegate: NSObjectProtocol {
    func didSelectedBack()
    func didSelectedLike(sender: UIButton)
    func didSelectedShare()
    func didSelectedReport()
}

class PVAttentionDetailNaviBar: UIView {
    
    weak public var delegate: PVAttentionDetailNaviDelegate?
    
    lazy var backBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "back_arrow"), for: .normal)
        b.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
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
        addSubview(backBtn)
        addSubview(likeBtn)
        addSubview(shareBtn)
        addSubview(reportBtn)
        backBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.left.equalToSuperview().offset(10 * KScreenRatio_6)
            make.top.equalToSuperview().offset(30 * KScreenRatio_6)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(backBtn)
            make.left.equalTo(backBtn.snp.right).offset(20 * KScreenRatio_6)
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
                make.centerY.equalTo(backBtn)
                make.left.equalTo(likeBtn.snp.right).offset(20 * KScreenRatio_6)
            }
            reportBtn.snp.remakeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 30, height: 30))
                make.centerY.equalTo(backBtn)
                make.left.equalTo(shareBtn.snp.right).offset(20 * KScreenRatio_6)
            }
        }
    }
    
    @objc func back(sender: UIButton) {
        delegate?.didSelectedBack()
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


//MARK: - 关注详情主页
protocol PVAttentionDetailMainViewDelegate: NSObjectProtocol {
    ///点击头像
    func didClickHeader()
}
class PVAttentionDetailMainView: UIScrollView {
    
    weak public var pv_delegate: PVAttentionDetailMainViewDelegate?
    
    lazy var headerBtn: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.contentMode = .scaleAspectFill
        b.addTarget(self, action: #selector(didClickHeader), for: .touchUpInside)
        return b
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
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
        addSubview(detailLabel)
        headerBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10 * KScreenRatio_6)
            make.bottom.equalTo(detailLabel.snp.top).offset(-15 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerBtn)
            make.left.equalTo(headerBtn.snp.right).offset(10)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerBtn)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(550 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didClickHeader() {
        pv_delegate?.didClickHeader()
    }
    
}


//MARK: - 评论header view
class PVAttentionDetailCommentHeaderView: UIView {
    
    
    lazy var playTimesLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        return l
    }()
    lazy var commentCountLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        l.textAlignment = .right
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(playTimesLabel)
        addSubview(commentCountLabel)
        addSubview(dateLabel)
        playTimesLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        commentCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(playTimesLabel)
            make.top.equalTo(playTimesLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.centerY.equalTo(playTimesLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

//MARK: - 评论 cell
protocol PVAttentionDetailCommentDelegate: NSObjectProtocol {
    func didSelectedLike(cell: PVAttentionDetailCommentCell, sender: UIButton)
    func didSelectedMoreComment(cell: PVAttentionDetailCommentCell)
}

class PVAttentionDetailCommentCell: PVBaseTableCell {
    
    weak public var delegate: PVAttentionDetailCommentDelegate?
    
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
    lazy var moreCommentBg: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        let rect = CGRect.init(x: 0, y: 0, width: 230 * KScreenRatio_6, height: 30 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: 5)
        v.isHidden = true
        return v
    }()
    lazy var moreCommentBtn: TitleFrontButton = {
        let b = TitleFrontButton()
        b.titleLabel?.font = kFont_text_4
        b.setTitleColor(kColor_subText, for: .normal)
        b.setImage(UIImage.init(named: "attention_more"), for: .normal)
        b.addTarget(self, action: #selector(moreAction(sender:)), for: .touchUpInside)
        return b
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
        contentView.addSubview(moreCommentBg)
        moreCommentBg.addSubview(moreCommentBtn)
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
        moreCommentBg.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.width.equalTo(230 * KScreenRatio_6)
            make.top.equalTo(dateLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.bottom.equalToSuperview().offset(-10 * KScreenRatio_6)
        }
        moreCommentBtn.snp.makeConstraints { (make) in
            make.centerY.height.equalToSuperview()
            make.left.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        nameLabel.text = nil
        contentLabel.text = nil
        dateLabel.text = nil
        likeBtn.setTitle(nil, for: .normal)
        moreCommentBtn.setTitle(nil, for: .normal)
    }
    
    
    @objc func likeAction(sender: UIButton) {
        delegate?.didSelectedLike(cell: self, sender: sender)
    }
    
    @objc func moreAction(sender: UIButton) {
        delegate?.didSelectedMoreComment(cell: self)
    }
    
}

//MARK: - 评论input view
protocol PVAttentionDetailCommentInputViewDelegate: NSObjectProtocol {
    func didSelectedDone(textView: YYTextView)
}

class PVAttentionDetailCommentInputView: UIView {
    
    weak public var delegate: PVAttentionDetailCommentInputViewDelegate?
    
    lazy var inputTV: YYTextView = {
        let tv = YYTextView()
        tv.font = kFont_text
        tv.textColor = kColor_text
        tv.placeholderFont = kFont_text
        tv.placeholderText = "输入您的评论"
        tv.placeholderTextColor = kColor_subText
        tv.backgroundColor = kColor_background
        tv.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneAction(sender:)), titleText: "发送")
        return tv
    }()
    
    required convenience init(frame: CGRect, delegate: YYTextViewDelegate) {
        self.init(frame: frame)
        backgroundColor = kColor_background
        inputTV.delegate = delegate
        addSubview(inputTV)
        inputTV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    @objc func keyboardDoneAction(sender: YYTextView) {
        delegate?.didSelectedDone(textView: sender)
    }
    
}
