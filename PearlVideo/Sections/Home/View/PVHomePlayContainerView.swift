//
//  PVHomePlayContainerView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/18.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVodPlayerSDK

class PVHomePlayContainerView: UIView {
    
    ///user info view delegate
    weak public var userInfoDelegate: PVHomeVideoInfoDelegate?
    
    ///在本容器内的播放器的实例对象
    public private(set) var vodPlayer: AliyunVodPlayer!
    
    ///在本容器内的播放器的资源
    public private(set) var videoModel: AlivcQuVideoModel?
    
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
    private lazy var userInfoView: PVHomeVideoInfoView = {
        let v = PVHomeVideoInfoView.init(frame: .zero)
        v.backgroundColor = UIColor.clear
        v.delegate = userInfoDelegate
        return v
    }()
    
    
    //MARK: - public action
    public required convenience init(vodPlayer: AliyunVodPlayer) {
        self.init()
        self.vodPlayer = vodPlayer
        addSubview(userInfoView)
        addSubview(coverImageView)
        coverImageView.snp.makeConstraints { (make) in
            make.centerX.centerY.size.equalToSuperview()
        }
        userInfoView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(120 * KScreenRatio_6)
            make.width.equalTo(kScreenWidth * 0.6)
        }
    }
    
    ///切换视频资源播放的时候，清空之前的封面图的图片
    public func clearImage() {
        coverImageView.image = nil
    }
    
    ///清空一切信息
    public func clearData() {
        clearImage()
        setVideoModel(model: nil)
        userInfoView.clearData()
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
    
    ///设置播放的数据源
    public func setVideoModel(model: AlivcQuVideoModel?) {
        videoModel = model
        if model == nil {
            clearImage()
            vodPlayer.reset()
            return
        }
        if model?.firstFrameImage != nil {
            setCoverImage(coverImage: model?.firstFrameImage)
        }
        else if model?.firstFrameUrl != nil {
            guard let url = URL.init(string: model!.firstFrameUrl!) else { return }
            DispatchQueue.global().async {
                guard let data = try? Data.init(contentsOf: url) else { return }
                let img = UIImage.init(data: data)
                DispatchQueue.main.async {
                    //异步加载的时候，判断下载的图片是否是当前的模型类，防止弱网环境下的图片错乱
                    if model == self.videoModel { self.setCoverImage(coverImage: img) }
                }
            }
        }
        fixUserSize()
    }
    
    
    //MARK: - private action
    //根据实际的数据来调整用户信息的一些控件的位置,显示隐藏一些信息
    private func fixUserSize() {
        guard videoModel != nil else {
            userInfoView.isHidden = true
            return
        }
        if videoModel?.belongUserAvatarImage != nil {
            userInfoView.isHidden = false
            userInfoView.headerBtn.setImage(videoModel?.belongUserAvatarImage, for: .normal)
        }
        else if videoModel?.user.belongUserAvatarUrl != nil {
            userInfoView.isHidden = false
            userInfoView.headerBtn.kf.setImage(with: URL.init(string: videoModel!.user.belongUserAvatarUrl!), for: .normal)
        }
        else {
            userInfoView.isHidden = true
        }
        userInfoView.nameLabel.text = videoModel?.user.belongUserName
        userInfoView.detailLabel.text = videoModel?.videoDescription
        
    }
}






