//
//  PVHomeDelegates.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/19.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVodPlayerSDK

//MARK: - user interface delegate
extension PVHomePlayVC: PVHomePlayDelegate {
    //点击头像
    func didSelectedAvatar(data: PVVideoPlayModel) {
        
    }
    
    //关注
    func didSelectedAttention(sender: UIButton, data: PVVideoPlayModel) {
        sender.isSelected = !sender.isSelected
        data.IsFollowed = sender.isSelected
        let args: [String: Any] = ["data": data, "sender": sender]
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(videoAttention(args:)), object: args)
        self.perform(#selector(videoAttention(args:)), with: args, afterDelay: 2)
        
    }
    
    @objc func videoAttention(args: [String: Any]) {
        guard let data = args["data"] as? PVVideoPlayModel else { return }
        guard let sender = args["sender"] as? UIButton else { return }
        PVNetworkTool.Request(router: .videoAttention(id: data.userId, action: sender.isSelected ? 1 : 2), success: { (resp) in
            print("关注：", data.userId)
        }) { (e) in
            
        }
    }
    
    //点赞
    func didSelectedLike(sender: UIButton, data: PVVideoPlayModel) {
        sender.isSelected = !sender.isSelected
        data.IsThumbuped = sender.isSelected
        let args: [String: Any] = ["data": data, "sender": sender]
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(videoAttention(args:)), object: args)
        self.perform(#selector(videoLike(args:)), with: args, afterDelay: 2)
        
    }
    
    @objc func videoLike(args: [String: Any]) {
        guard let data = args["data"] as? PVVideoPlayModel else { return }
        guard let sender = args["sender"] as? UIButton else { return }
        PVNetworkTool.Request(router: .videoAttention(id: data.videoId, action: sender.isSelected ? 1 : 2), success: { (resp) in
            print("点赞：", data.userId)
        }) { (e) in
            
        }
    }
    
    //评论
    func didSelectedComment(data: PVVideoPlayModel) {
        let v = PVVideoCommentView.init(videoId: data.videoId, delegate: self)
        view.addSubview(v)
    }
    
    //分享
    func didSelectedShare(data: PVVideoPlayModel) {
        
    }
    
    //举报
    func didSelectedReport(data: PVVideoPlayModel) {
        let vc = PVHomeReportVC()
        vc.videoId = data.videoId
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - comment delegate
extension PVHomePlayVC: PVVideoCommentDelegate {
    
    //点击用户头像
    func didSelectedUser(id: String) {
        
    }
    //评论点赞
    func didSelectedLike(videoId: String, commentId: Int, action: Int) {
        PVNetworkTool.Request(router: .videoCommentLike(videoId: videoId, commentId: commentId, action: action), success: { (resp) in
            
            
        }) { (e) in
            
        }
    }
    
}

//MARK: - 播放事件 delegate
extension PVHomePlayVC: AliyunVodPlayerDelegate {
    //播放事件回调
    func vodPlayer(_ vodPlayer: AliyunVodPlayer!, onEventCallback event: AliyunVodPlayerEvent) {
        switch event {
        case .prepareDone:
            let thisView = containerViewWithVodPlayer(vodPlayer: vodPlayer)
            if currentPlayContainer != nil {
                if thisView == currentPlayContainer && isActive {
                    currentPlayContainer?.vodPlayer.start()
                }
            }
            /*
            //如果是第一个视频，尝试加载第一次请求的资源的图片
            if let index = playContainerList.firstIndex(of: currentPlayContainer!) {
                if index == 0 { doQuerryImageWhenFirstEnter() }
            }
            */
            //设置播放模式
            if vodPlayer!.videoHeight != 0 {
                let videoRatio = CGFloat(vodPlayer!.videoWidth) * 1.0 / CGFloat(vodPlayer!.videoHeight) * 1.0
                let screenRatio = vodPlayer.playerView.frame.size.width / vodPlayer.playerView.frame.size.height
                if videoRatio > screenRatio {
                    vodPlayer.displayMode = .fit
                    thisView?.coverImageView.contentMode = .scaleAspectFit
                }
                else {
                    vodPlayer.displayMode = .fitWithCropping
                    thisView?.coverImageView.contentMode = .scaleAspectFill
                }
            }
            
            break
            
        case .firstFrame:
            hideCoverImageWithVodPlayer(vodPlayer: vodPlayer)
            break
            
            
        default:
            break
        }
    }
    
    //播放出错
    func vodPlayer(_ vodPlayer: AliyunVodPlayer!, playBack errorModel: AliyunPlayerVideoErrorModel!) {
        if errorModel.errorCode == ALIVC_ERR_AUTH_EXPIRED {
            getSTS()
        }
        print(errorModel!.errorMsg!)
    }
    
    //鉴权数据过期
    func onTimeExpiredError(with vodPlayer: AliyunVodPlayer!) {
        getSTS()
    }
    
    //播放地址将要过期
    func vodPlayerPlaybackAddressExpired(withVideoId videoId: String!, quality: AliyunVodPlayerVideoQuality, videoDefinition: String!) {
        getSTS()
    }
    
    //播放器状态改变回调
    func vodPlayer(_ vodPlayer: AliyunVodPlayer!, newPlayerState newState: AliyunVodPlayerState) {
        guard currentPlayContainer != nil else { return }
        if vodPlayer == currentPlayContainer?.vodPlayer {
            //暂停按钮的管理
            if newState == .pause {
                allContainView.changeUIToPauseStatusWithCurrentPlayView(playView: currentPlayContainer!)
            }
            else {
                allContainView.changeUIToPlayStatus()
            }
            if isActive { savedPlayStatus = newState }
        }
        if let containerView = containerViewWithVodPlayer(vodPlayer: vodPlayer) {
            containerView.playerState = newState
        }
        
    }
}


//MARK: - AliyunVodDownLoadDelegate
extension PVHomePlayVC: AliyunVodDownLoadDelegate {
    
    func onPrepare(_ mediaInfos: [AliyunDownloadMediaInfo]!) {
        
    }
    
    func onStart(_ mediaInfo: AliyunDownloadMediaInfo!) {
        
    }
    
    func onStop(_ mediaInfo: AliyunDownloadMediaInfo!) {
        
    }
    
    func onCompletion(_ mediaInfo: AliyunDownloadMediaInfo!) {
        
    }
    
    func onProgress(_ mediaInfo: AliyunDownloadMediaInfo!) {
        
    }
    
    func onError(_ mediaInfo: AliyunDownloadMediaInfo!, code: Int32, msg: String!) {
        print(msg)
    }
    
}
