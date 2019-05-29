//
//  PVMePlayMaskView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/24.
//  Copyright © 2019 equalriver. All rights reserved.
//

protocol PVMePlayDelegate: NSObjectProtocol {
    ///评论
    func didSelectedComment(data: PVVideoPlayModel)
    ///更多
    func didSelectedMore(data: PVVideoPlayModel)
    ///删除
    func didSelectedDelete(data: PVVideoPlayModel)
}

class PVMePlayMaskView: UIView {
    
    weak public var delegate: PVMePlayDelegate?
    
    weak public var playContainer: PVHomePlayContainerView? {
        didSet{
            if playContainer?.data == nil {
                return
            }
            avatarBtn.kf.setImage(with: URL.init(string: playContainer!.data.avatarUrl), for: .normal)
            nameLabel.text = playContainer!.data.nickname
            detailLabel.text = playContainer!.data.title
            likeBtn.isSelected = playContainer!.data.IsFollowed
            likeBtn.setTitle("\(playContainer!.data.thumbCount)", for: .normal)
            commentBtn.setTitle("\(playContainer!.data.commentCount)", for: .normal)
        }
    }
    
    ///手势视图
    lazy var gestureView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }()
    ///播放图标的容器视图
    lazy var playImageContainView: UIImageView = {
        let v = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6))
        v.image = UIImage.init(named: "home_play")
        return v
    }()
    //左下角用户信息视图
    lazy var avatarBtn: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 22.5 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.contentMode = .scaleAspectFill
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
    lazy var likeBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "video_点赞"), for: .normal)
        b.setImage(UIImage.init(named: "video_点赞后"), for: .selected)
        b.titleLabel?.font = kFont_text_2
        b.setTitleColor(UIColor.white, for: .normal)
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
    lazy var moreBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "video_more"), for: .normal)
        b.titleLabel?.font = kFont_text_2
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(moreAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var deleteBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "video_delete"), for: .normal)
        b.titleLabel?.font = kFont_text_2
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(deleteAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(gestureView)
        addSubview(avatarBtn)
        addSubview(nameLabel)
        addSubview(detailLabel)
        addSubview(likeBtn)
        addSubview(commentBtn)
        addSubview(moreBtn)
        addSubview(deleteBtn)
        gestureView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
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
        moreBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(likeBtn)
            make.top.equalTo(commentBtn.snp.bottom).offset(30 * KScreenRatio_6)
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(likeBtn)
            make.top.equalTo(moreBtn.snp.bottom).offset(20 * KScreenRatio_6)
        }
        
    }
    
}

extension PVMePlayMaskView {
    
    public func changeUIToPauseStatusWithCurrentPlayView(playView: UIView) {
        playImageContainView.removeFromSuperview()
        playView.addSubview(playImageContainView)
        playImageContainView.center = CGPoint.init(x: kScreenWidth / 2, y: kScreenHeight / 2)
        playImageContainView.isHidden = false
    }
    
    public func changeUIToPlayStatus() {
        playImageContainView.isHidden = true
    }
    
    //评论
    @objc func commentAction(sender: UIButton) {
        if playContainer?.data != nil { delegate?.didSelectedComment(data: playContainer!.data) }
    }
    
    //更多
    @objc func moreAction(sender: UIButton) {
        if playContainer?.data != nil { delegate?.didSelectedMore(data: playContainer!.data) }
    }
    
    //删除
    @objc func deleteAction(sender: UIButton) {
        if playContainer?.data != nil { delegate?.didSelectedDelete(data: playContainer!.data) }
    }
    
}




