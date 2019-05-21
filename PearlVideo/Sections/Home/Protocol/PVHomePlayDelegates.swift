//
//  PVHomeDelegates.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/19.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVodPlayerSDK

//MARK: - uicollection view delegate
extension PVHomePlayVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVHomePlayCell", for: indexPath) as! PVHomePlayCell
        cell.delegate = self
        cell.vodPlayer.delegate = self
        cell.vodPlayer.stop()
        guard dataArr.count > indexPath.item else { return cell }
        cell.vodPlayer.prepare(withVid: dataArr[indexPath.item].videoId, accessKeyId: accessKeyId, accessKeySecret: accessKeySecret, securityToken: securityToken)
        cell.data = dataArr[indexPath.item]
        if currentPlayContainer == nil && indexPath.item == 0 {
            currentPlayContainer = cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplay index: ", indexPath.item)
        if indexPath.item != 0 {
            let c = cell as? PVHomePlayCell
            c?.vodPlayer.pause()
        }
        else {//第二个滑到第一个item时
            if let currentIndexPath = collectionView.indexPathForItem(at: collectionView.contentOffset) {
                if currentIndexPath.item == 0 {
                    let c = cell as? PVHomePlayCell
                    c?.vodPlayer.pause()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let c = cell as? PVHomePlayCell
        c?.vodPlayer.stop()
        print("didEndDisplaying index: ", indexPath.item)
        currentPlayContainer = collectionView.cellForItem(at: indexPath) as? PVHomePlayCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PVHomePlayCell {
            cell.isPaused = !cell.isPaused
            if cell.isPaused {//暂停
                cell.vodPlayer.pause()
            }
            else {
                cell.vodPlayer.resume()
            }
//            cell.coverImageView.isHidden = !cell.isPaused
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let indexPath = collectionView.indexPathForItem(at: scrollView.contentOffset) {
            print("WillBeginDragging index: ", indexPath.item)
            currentPlayContainer = collectionView.cellForItem(at: indexPath) as? PVHomePlayCell
            currentPlayContainer?.vodPlayer.pause()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = collectionView.indexPathForItem(at: scrollView.contentOffset) {
            print("DidEndDecelerating index: ", indexPath.item)
            currentIndex = indexPath.item
            currentPlayContainer = collectionView.cellForItem(at: indexPath) as? PVHomePlayCell
            guard currentPlayContainer != nil else { return }
            let state = currentPlayContainer!.vodPlayer.playerState()
            switch state {
            case .prepared:
                currentPlayContainer?.vodPlayer.start()
                break
                
            case .stop:
                currentPlayContainer?.vodPlayer.replay()
                break
                
            case .pause:
                currentPlayContainer?.vodPlayer.resume()
                break
                
            default: break
            }
            
        }
    }
    
}

//MARK: - user interface delegate
extension PVHomePlayVC: PVHomePlayDelegate {
    //点击头像
    func didSelectedAvatar(cell: PVHomePlayCell) {
        
    }
    
    //关注
    func didSelectedAttention(sender: UIButton, cell: PVHomePlayCell) {
        sender.isSelected = !sender.isSelected
        if let indexPath = collectionView.indexPath(for: cell) {
            guard dataArr.count > indexPath.item else { return }
            dataArr[indexPath.item].IsFollowed = sender.isSelected
            let args: [String: Any] = ["indexPath": indexPath, "sender": sender]
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(videoAttention(args:)), object: args)
            self.perform(#selector(videoAttention(args:)), with: args, afterDelay: 2)
        }
    }
    
    @objc func videoAttention(args: [String: Any]) {
        guard let indexPath = args["indexPath"] as? IndexPath else { return }
        guard let sender = args["sender"] as? UIButton else { return }
        PVNetworkTool.Request(router: .videoAttention(id: dataArr[indexPath.item].userId, action: sender.isSelected ? 1 : 2), success: { (resp) in
            print("关注：", self.dataArr[indexPath.item].userId)
        }) { (e) in
            
        }
    }
    
    //点赞
    func didSelectedLike(sender: UIButton, cell: PVHomePlayCell) {
        sender.isSelected = !sender.isSelected
        if let indexPath = collectionView.indexPath(for: cell) {
            guard dataArr.count > indexPath.item else { return }
            dataArr[indexPath.item].IsThumbuped = sender.isSelected
            let args: [String: Any] = ["indexPath": indexPath, "sender": sender]
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(videoAttention(args:)), object: args)
            self.perform(#selector(videoLike(args:)), with: args, afterDelay: 2)
        }
    }
    
    @objc func videoLike(args: [String: Any]) {
        guard let indexPath = args["indexPath"] as? IndexPath else { return }
        guard let sender = args["sender"] as? UIButton else { return }
        PVNetworkTool.Request(router: .videoAttention(id: dataArr[indexPath.item].videoId, action: sender.isSelected ? 1 : 2), success: { (resp) in
            print("点赞：", self.dataArr[indexPath.item].userId)
        }) { (e) in
            
        }
    }
    
    //评论
    func didSelectedComment(cell: PVHomePlayCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard dataArr.count > indexPath.item else { return }
        let v = PVVideoCommentView.init(videoId: dataArr[indexPath.item].videoId, delegate: self)
        view.addSubview(v)
    }
    
    //分享
    func didSelectedShare(cell: PVHomePlayCell) {
        
    }
    
    //举报
    func didSelectedReport(cell: PVHomePlayCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard dataArr.count > indexPath.item else { return }
        let vc = PVHomeReportVC()
        vc.videoId = dataArr[indexPath.item].videoId
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
            currentPlayContainer?.vodPlayer.start()
            break
            
            
        default:
            break
        }
    }
    
    //播放出错
    func vodPlayer(_ vodPlayer: AliyunVodPlayer!, playBack errorModel: AliyunPlayerVideoErrorModel!) {
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
