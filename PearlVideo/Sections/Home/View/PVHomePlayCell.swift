//
//  PVHomePlayCell.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/18.
//  Copyright © 2019 equalriver. All rights reserved.
//

/********************************************/
//collection view方案

import AliyunVodPlayerSDK

protocol PVHomePlayDelegate: NSObjectProtocol {
    ///点击头像
    func didSelectedAvatar(cell: UICollectionViewCell)
    ///关注
    func didSelectedAttention(cell: UICollectionViewCell)
    ///喜欢
    func didSelectedLike(cell: UICollectionViewCell)
    ///评论
    func didSelectedComment(cell: UICollectionViewCell)
    ///分享
    func didSelectedShare(cell: UICollectionViewCell)
    ///举报
    func didSelectedReport(cell: UICollectionViewCell)
}

class PVHomePlayCell: UICollectionViewCell {
    
    weak public var delegate: PVHomePlayDelegate?
    
    public var data: PVVideoPlayModel! {
        didSet{
            if data == nil {
                coverImageView.image = nil
                attentionBtn.isHidden = true
                vodPlayer.reset()
                return
            }
            attentionBtn.isHidden = false
            coverImageView.kf.setImage(with: URL.init(string: data.coverUrl))
            avatarBtn.kf.setImage(with: URL.init(string: data.avatarUrl), for: .normal)
            nameLabel.text = data.nickname
            detailLabel.text = data.title
            likeBtn.isSelected = data.IsFollowed
            likeBtn.setTitle("\(data.thumbCount)", for: .normal)
            commentBtn.setTitle("\(data.commentCount)", for: .normal)
        }
    }
    
    ///在本容器内的播放器的实例对象
    public lazy var vodPlayer: AliyunVodPlayer = {
        let v = AliyunVodPlayer()
        v.isAutoPlay = true   //是否自动播放
        v.circlePlay = true    //循环播放控制
        v.displayMode = .fit   //浏览方式
        v.quality = .videoFD   //流畅度
        v.playerView.frame = bounds
        let pathArray = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        //maxsize:单位 mb    maxDuration:单位秒 ,在prepare之前调用。 - 设置本地缓存
        v.setPlayingCache(true, saveDir: pathArray.first, maxSize: 1024, maxDuration: 10000)
        return v
    }()
    
    ///所属播放器当前的状态 - 直接获取vodplayer的属性状态是不准的，这个属性是负责记录准确的值
    public var playerState = AliyunVodPlayerState.idle
    
    ///是否已经准备过
    public var isHavePrepared = false
    
    ///是否暂停
    public var isPaused = false
    
    ///容器的封面图片
    public lazy var coverImageView: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var playIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "play_暂停"))
        v.isHidden = true
        return v
    }()
    
    //左下角用户信息视图
    lazy var avatarBtn: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 22.5 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.contentMode = .scaleAspectFill
        b.addTarget(self, action: #selector(avatarAction(sender:)), for: .touchUpInside)
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
        b.setImage(UIImage.init(named: "video_关注"), for: .normal)
        b.setImage(UIImage.init(named: "video_已关注"), for: .selected)
        b.addTarget(self, action: #selector(attentionAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.numberOfLines = 2
        return l
    }()
    lazy var likeBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "video_点赞"), for: .normal)
        b.setImage(UIImage.init(named: "video_点赞后"), for: .selected)
        b.titleLabel?.font = kFont_text_2
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(likeAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var commentBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "video_聊天"), for: .normal)
        b.titleLabel?.font = kFont_text_2
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(commentAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var shareBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "video_share"), for: .normal)
        b.titleLabel?.font = kFont_text_2
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(shareAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var reportBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "video_举报"), for: .normal)
        b.titleLabel?.font = kFont_text_2
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(reportAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
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
    
    func initUI() {
        contentView.addSubview(vodPlayer.playerView)
        contentView.addSubview(avatarBtn)
        contentView.addSubview(nameLabel)
        contentView.addSubview(attentionBtn)
        contentView.addSubview(detailLabel)
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentBtn)
        contentView.addSubview(shareBtn)
        contentView.addSubview(reportBtn)
        contentView.addSubview(coverImageView)
        avatarBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(500 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 45 * KScreenRatio_6, height: 45 * KScreenRatio_6))
            make.left.equalToSuperview().offset(10)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(avatarBtn)
            make.left.equalTo(avatarBtn.snp.right).offset(10)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarBtn)
            make.right.equalToSuperview().offset(-120 * KScreenRatio_6)
            make.top.equalTo(avatarBtn.snp.bottom).offset(15 * KScreenRatio_6)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(330 * KScreenRatio_6)
        }
        commentBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(likeBtn)
            make.top.equalTo(likeBtn.snp.bottom).offset(20 * KScreenRatio_6)
        }
        shareBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(likeBtn)
            make.top.equalTo(commentBtn.snp.bottom).offset(20 * KScreenRatio_6)
        }
        reportBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(likeBtn)
            make.top.equalTo(shareBtn.snp.bottom).offset(20 * KScreenRatio_6)
        }
        coverImageView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.isHidden = true
        avatarBtn.setImage(nil, for: .normal)
        nameLabel.text = nil
        detailLabel.text = nil
        attentionBtn.isSelected = false
        likeBtn.setTitle(nil, for: .normal)
        likeBtn.isSelected = false
        commentBtn.setTitle(nil, for: .normal)
        vodPlayer.reset()
    }
    
    
    
    deinit {
        vodPlayer.release()
    }
    
    
}

extension PVHomePlayCell {
    //点击头像
    @objc func avatarAction(sender: UIButton) {
        delegate?.didSelectedAvatar(cell: self)
    }
    
    //关注
    @objc func attentionAction(sender: UIButton) {
        delegate?.didSelectedAttention(cell: self)
    }
    
    //喜欢
    @objc func likeAction(sender: UIButton) {
        delegate?.didSelectedLike(cell: self)
    }
    
    //评论
    @objc func commentAction(sender: UIButton) {
        delegate?.didSelectedComment(cell: self)
    }
    
    //分享
    @objc func shareAction(sender: UIButton) {
        delegate?.didSelectedShare(cell: self)
    }
    
    //举报
    @objc func reportAction(sender: UIButton) {
        delegate?.didSelectedReport(cell: self)
    }
    
    
}
