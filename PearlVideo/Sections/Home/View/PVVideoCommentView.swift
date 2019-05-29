//
//  PVVideoCommentView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 评论弹出页
protocol PVVideoCommentDelegate: NSObjectProtocol {
    func didSelectedUser(id: String)
    ///1点赞 2取消
    func didSelectedLike(videoId: String, commentId: Int, action: Int)
    func didSelectedDone(content: String, completion: @escaping () -> Void)
}

class PVVideoCommentView: UIView {
    
    
    weak public var delegate: PVVideoCommentDelegate?
    
    var dataArr = Array<PVVideoCommentModel>()
    
    var videoId = ""
    
    var page = 0
    
    let inputViewRect = CGRect.init(x: 0, y: 420 * KScreenRatio_6, width: kScreenWidth, height: 50 * KScreenRatio_6)
    
    
    lazy var contentView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: 470 * KScreenRatio_6))
        v.backgroundColor = kColor_deepBackground
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        l.textAlignment = .center
        return l
    }()
    lazy var closeBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "video_close"), for: .normal)
        b.addTarget(self, action: #selector(closeAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_deepBackground
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.register(PVVideoCommentCell.self, forCellReuseIdentifier: "PVVideoCommentCell")
        return tb
    }()
    lazy var commentInputView: PVAttentionDetailCommentInputView = {
        let v = PVAttentionDetailCommentInputView.init(frame: inputViewRect, delegate: self)
        return v
    }()
    
    
    required convenience init(videoId: String, delegate: PVVideoCommentDelegate) {
        self.init()
        frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        backgroundColor = UIColor.clear
        self.videoId = videoId
        self.delegate = delegate
        initUI()
        setRefresh()
        loadData(page: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowAction(noti:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideAction(noti:)), name: UIApplication.keyboardWillHideNotification, object: nil)
        contentView.ypj.viewAnimateComeFromBottom(duration: 0.3) { (isFinish) in
           
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
            make.top.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 30 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-10)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50 * KScreenRatio_6)
            make.centerX.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50 * KScreenRatio_6)
        }
//        commentInputView.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 50 * KScreenRatio_6))
//            make.bottom.centerX.equalToSuperview()
//        }
    }
    
}

//MARK: - cell
protocol PVVideoCommentCellDelegate: NSObjectProtocol {
    func didSelectedAvatar(cell: PVVideoCommentCell)
    func didSelectedLike(cell: PVVideoCommentCell, sender: UIButton)
    func didSelectedMoreReply(cell: PVVideoCommentCell, sender: UIButton)
}

class PVVideoCommentCell: PVBaseTableCell {
    
    
    weak public var delegate: PVVideoCommentCellDelegate?
    
    public var data: PVVideoCommentModel! {
        didSet{
            iconIV.kf.setImage(with: URL.init(string: data.avatarUrl))
            nameLabel.text = data.nickname
            contentLabel.text = data.content
            dateLabel.text = data.createAt
            likeBtn.isSelected = data.status == 1
            likeBtn.setTitle("\(data.replyThumbCount)", for: .normal)
            if data.replyCount > 0 {
                moreReplyBtn.setTitle("查看\(data.replyCount)条回复", for: .normal)
                moreReplyBtn.snp.updateConstraints { (make) in
                    make.height.equalTo(30)
                }
            }
            else {
                moreReplyBtn.setTitle(nil, for: .normal)
                moreReplyBtn.snp.updateConstraints { (make) in
                    make.height.equalTo(0.1)
                }
            }
        }
    }
    
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
        l.font = kFont_text_3
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
    lazy var moreReplyBtn: TitleFrontButton = {
        let b = TitleFrontButton.init(frame: .zero)
        b.titleLabel?.font = kFont_text_3
        b.setTitleColor(kColor_subText, for: .normal)
        b.setImage(UIImage.init(named: "video_push"), for: .normal)
        b.addTarget(self, action: #selector(moreReply(sender:)), for: .touchUpInside)
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
        contentView.addSubview(moreReplyBtn)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.left.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
            make.top.equalTo(iconIV)
//            make.height.equalTo(15 * KScreenRatio_6)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.equalTo(230 * KScreenRatio_6)
            make.bottom.equalTo(dateLabel.snp.top).offset(-8 * KScreenRatio_6)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(moreReplyBtn.snp.top).offset(-10)
            make.width.equalTo(contentLabel)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.height.equalTo(40)
        }
        moreReplyBtn.snp.makeConstraints { (make) in
            make.height.equalTo(0.1)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalTo(dateLabel).offset(10)
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        nameLabel.text = nil
        contentLabel.text = nil
        dateLabel.text = nil
        likeBtn.setTitle(nil, for: .normal)
        moreReplyBtn.setTitle(nil, for: .normal)
        moreReplyBtn.isHidden = true
    }
    
    @objc func headerTap() {
        delegate?.didSelectedAvatar(cell: self)
    }
    
    @objc func likeAction(sender: UIButton) {
        delegate?.didSelectedLike(cell: self, sender: sender)
    }
    
    @objc func moreReply(sender: UIButton) {
        delegate?.didSelectedMoreReply(cell: self, sender: sender)
    }
    
}

//MARK: - 评论input view

class PVAttentionDetailCommentInputView: UIView {
    
    
    lazy var inputTV: YYTextView = {
        let tv = YYTextView.init(frame: CGRect.init(x: 15 * KScreenRatio_6, y: 5, width: kScreenWidth - 30 * KScreenRatio_6, height: 40 * KScreenRatio_6))
        tv.font = kFont_text
        tv.textColor = UIColor.white
        tv.placeholderFont = kFont_text
        tv.placeholderText = "输入您的评论"
        tv.placeholderTextColor = kColor_text
        tv.backgroundColor = kColor_background
        tv.returnKeyType = .send
    
        return tv
    }()
    
    required convenience init(frame: CGRect, delegate: YYTextViewDelegate) {
        self.init(frame: frame)
        backgroundColor = kColor_background
        inputTV.delegate = delegate
        addSubview(inputTV)
//        inputTV.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
//            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
//            make.top.equalToSuperview().offset(5)
//            make.bottom.equalToSuperview().offset(-5)
//        }
    }
    
    
    
}
