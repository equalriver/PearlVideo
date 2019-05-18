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
//        cell.data = dataArr[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplay: ", indexPath.item)
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
            cell.coverImageView.isHidden = !cell.isPaused
        }
    }
    
}

//MARK: - user interface delegate
extension PVHomePlayVC: PVHomePlayDelegate {
    //点击头像
    func didSelectedAvatar(cell: UICollectionViewCell) {
        
    }
    
    //关注
    func didSelectedAttention(cell: UICollectionViewCell) {
        
    }
    
    //点赞
    func didSelectedLike(cell: UICollectionViewCell) {
        
    }
    
    //评论
    func didSelectedComment(cell: UICollectionViewCell) {
        
    }
    
    //分享
    func didSelectedShare(cell: UICollectionViewCell) {
        
    }
    
    //举报
    func didSelectedReport(cell: UICollectionViewCell) {
        
    }
    
}

//MARK: - 播放事件 delegate
extension PVHomePlayVC: AliyunVodPlayerDelegate {
    //播放事件回调
    func vodPlayer(_ vodPlayer: AliyunVodPlayer!, onEventCallback event: AliyunVodPlayerEvent) {
        
    }
    
    //播放出错
    func vodPlayer(_ vodPlayer: AliyunVodPlayer!, playBack errorModel: AliyunPlayerVideoErrorModel!) {
        print(errorModel)
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
