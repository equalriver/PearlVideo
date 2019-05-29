//
//  PVHomePlayMaskViewPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/23.
//  Copyright © 2019 equalriver. All rights reserved.
//

extension PVHomePlayMaskView {
    
    public func changeUIToPauseStatusWithCurrentPlayView(playView: UIView) {
        playImageContainView.removeFromSuperview()
        playView.addSubview(playImageContainView)
        playImageContainView.center = CGPoint.init(x: kScreenWidth / 2, y: kScreenHeight / 2)
        playImageContainView.isHidden = false
    }
    
    public func changeUIToPlayStatus() {
        playImageContainView.isHidden = true
    }
    
    //点击头像
    @objc func avatarAction(sender: UIButton) {
        if playContainer?.data != nil { delegate?.didSelectedAvatar(data: playContainer!.data) }
    }
    
    //关注
    @objc func attentionAction(sender: UIButton) {
        if playContainer?.data != nil { delegate?.didSelectedAttention(sender: sender, data: playContainer!.data) }
    }
    
    //喜欢
    @objc func likeAction(sender: UIButton) {
        if playContainer?.data != nil { delegate?.didSelectedLike(sender: sender, data: playContainer!.data) }
    }
    
    //评论
    @objc func commentAction(sender: UIButton) {
        if playContainer?.data != nil { delegate?.didSelectedComment(data: playContainer!.data) }
    }
    
    //分享
    @objc func shareAction(sender: UIButton) {
        if playContainer?.data != nil { delegate?.didSelectedShare(data: playContainer!.data) }
    }
    
    //举报
    @objc func reportAction(sender: UIButton) {
        if playContainer?.data != nil { delegate?.didSelectedReport(data: playContainer!.data) }
    }
    
}
