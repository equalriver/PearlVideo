//
//  PVHomePlayContainerView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/18.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVodPlayerSDK

protocol PVHomePlayDelegate: NSObjectProtocol {
    ///点击头像
    func didSelectedAvatar(data: PVVideoPlayModel)
    ///关注
    func didSelectedAttention(sender: UIButton, data: PVVideoPlayModel)
    ///喜欢
    func didSelectedLike(sender: UIButton, data: PVVideoPlayModel)
    ///评论
    func didSelectedComment(data: PVVideoPlayModel)
    ///分享
    func didSelectedShare(data: PVVideoPlayModel)
    ///举报
    func didSelectedReport(data: PVVideoPlayModel)
}

class PVHomePlayContainerView: UIView {
    
    weak public var delegate: PVHomePlayDelegate?
    
    ///在本容器内的播放器的实例对象
    public var vodPlayer: AliyunVodPlayer!
    
    public var data: PVVideoPlayModel! {
        didSet{
            if data == nil {
                coverImageView.image = nil
                attentionBtn.isHidden = true
                vodPlayer?.reset()
                return
            }
            attentionBtn.isHidden = false
            attentionBtn.isSelected = data.IsFollowed
            coverImageView.kf.setImage(with: URL.init(string: data.coverUrl))
            avatarBtn.kf.setImage(with: URL.init(string: data.avatarUrl), for: .normal)
            nameLabel.text = data.nickname
            detailLabel.text = data.title
            likeBtn.isSelected = data.IsFollowed
            likeBtn.setTitle("\(data.thumbCount)", for: .normal)
            commentBtn.setTitle("\(data.commentCount)", for: .normal)
        }
    }
    
    ///容器的封面图片
    public private(set) lazy var coverImageView: UIImageView = {
        let v = UIImageView()
        v.isHidden = true
        v.backgroundColor = UIColor.clear
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    ///所属播放器当前的状态 - 直接获取vodplayer的属性状态是不准的，这个属性是负责记录准确的值
    public var playerState = AliyunVodPlayerState.idle
    
    ///是否已经准备过
    public var isHavePrepared = false
    
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
  
    
    //MARK: - public action
    public required convenience init(vodPlayer: AliyunVodPlayer) {
        self.init()
        self.vodPlayer = vodPlayer
        initUI()

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
        vodPlayer.playerView.frame = UIScreen.main.bounds
        addSubview(vodPlayer.playerView)
        addSubview(coverImageView)
        addSubview(avatarBtn)
        addSubview(nameLabel)
        addSubview(attentionBtn)
        addSubview(detailLabel)
        addSubview(likeBtn)
        addSubview(commentBtn)
        addSubview(shareBtn)
        addSubview(reportBtn)
        coverImageView.snp.makeConstraints { (make) in
            make.centerX.centerY.size.equalToSuperview()
        }
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
            make.top.equalTo(likeBtn.snp.bottom).offset(30 * KScreenRatio_6)
        }
        shareBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(likeBtn)
            make.top.equalTo(commentBtn.snp.bottom).offset(30 * KScreenRatio_6)
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
    
    //点击头像
    @objc func avatarAction(sender: UIButton) {
        if data != nil { delegate?.didSelectedAvatar(data: data) }
    }
    
    //关注
    @objc func attentionAction(sender: UIButton) {
        if data != nil { delegate?.didSelectedAttention(sender: sender, data: data) }
    }
    
    //喜欢
    @objc func likeAction(sender: UIButton) {
        if data != nil { delegate?.didSelectedLike(sender: sender, data: data) }
    }
    
    //评论
    @objc func commentAction(sender: UIButton) {
        if data != nil { delegate?.didSelectedComment(data: data) }
    }
    
    //分享
    @objc func shareAction(sender: UIButton) {
        if data != nil { delegate?.didSelectedShare(data: data) }
    }
    
    //举报
    @objc func reportAction(sender: UIButton) {
        if data != nil { delegate?.didSelectedReport(data: data) }
    }
    
    ///切换视频资源播放的时候，清空之前的封面图的图片
    public func clearImage() {
        coverImageView.image = nil
    }
    
    ///清空一切信息
    public func clearData() {
        clearImage()
        
        
    }
    
    ///设置封面图片
    public func setCoverImage(coverImage: UIImage?) {
        //根据图片大小和本身的播放视图的大小来设置图片的显示方式 - 一切为了封面图和首帧一致，首帧会跟vodplay的显示模式有关系，显示模式的逻辑跟这个逻辑类似，在conrtol的vodPlayer的事件回调方法里有对应的处理。这边只是根据图片的大小处理一遍，应对快速滑动，未回调及时导致的一些图片显示问题。
        if coverImage != nil {
            let videoRatio = coverImage!.size.width * 1.0 / coverImage!.size.height * 1.0
            let screenRatio = vodPlayer.playerView.width / vodPlayer.playerView.height
            if videoRatio > screenRatio {
                coverImageView.contentMode = .scaleAspectFit
            }
            else {
                coverImageView.contentMode = .scaleAspectFill
            }
        }
        coverImageView.image = coverImage
        
    }
    
    ///设置之前的封面图片，当此容器中的播放器停止播放的时候
    public func setPreCoverImageWhenStop() {
        setCoverImage(coverImage: coverImageView.image)
        coverImageView.isHidden = false
    }
    
 
}






