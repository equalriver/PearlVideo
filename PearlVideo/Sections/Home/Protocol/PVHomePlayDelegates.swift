//
//  PVHomeDelegates.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/19.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVodPlayerSDK



//MARK: - navigation bar delegate
extension PVHomePlayVC: PVHomeNaviBarDelegate {
    
    func didSelectedComment() {
        
    }
    
    func didSelectedLike(sender: UIButton) {
        
    }
    
    func didSelectedShare() {
        
    }
    
    func didSelectedReport() {
        
    }
    
}


//MARK: - info delegate
extension PVHomePlayVC: PVHomeVideoInfoDelegate {
    
    func didSelectedAttention(sender: UIButton) {
        
    }
    
    func didClickHead() {
        //        PVUserInfoVC
    }
    
}

//MARK: - AliyunVodPlayerDelegate
extension PVHomePlayVC: AliyunVodPlayerDelegate {
    
    func vodPlayer(_ vodPlayer: AliyunVodPlayer!, onEventCallback event: AliyunVodPlayerEvent) {
        
    }
    
    func vodPlayer(_ vodPlayer: AliyunVodPlayer!, playBack errorModel: AliyunPlayerVideoErrorModel!) {
        
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
        
    }
    
}
