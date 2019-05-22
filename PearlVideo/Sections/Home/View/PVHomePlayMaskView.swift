//
//  PVHomePlayMaskView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/17.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVHomePlayMaskView: UIView {
    
    ///手势视图
    lazy var gestureView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }()
    ///播放图标的容器视图
    lazy var playImageContainView: UIImageView = {
        let v = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6))
        v.layer.cornerRadius = 35 * KScreenRatio_6
        v.clipsToBounds = true
        v.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        v.image = UIImage.init(named: "play_暂停")
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(gestureView)
        gestureView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func changeUIToPauseStatusWithCurrentPlayView(playView: UIView) {
        playImageContainView.removeFromSuperview()
        playImageContainView.sizeToFit()
        playView.addSubview(playImageContainView)
        playImageContainView.center = CGPoint.init(x: kScreenWidth / 2, y: kScreenHeight / 2)
        playImageContainView.isHidden = false
    }
    
    public func changeUIToPlayStatus() {
        playImageContainView.isHidden = true
    }
    
}
