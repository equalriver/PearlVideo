//
//  PVPlayVideoUploadVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/19.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AVKit

class PVPlayVideoUploadVC: PVBaseNavigationVC {
    
    lazy var avPlayerVC: AVPlayerViewController = {
        let vc = AVPlayerViewController.init()
        return vc
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        l.textAlignment = .right
        l.text = "0/30"
        return l
    }()
    lazy var contentTV: YYTextView = {
        let v = YYTextView()
        v.textContainerInset = UIEdgeInsets.init(top: 13, left: 8, bottom: 13, right: 8)
        v.font = kFont_text
        v.textColor = kColor_text
        v.placeholderTextColor = kColor_subText
        v.placeholderText = "写下此刻的想法"
        v.backgroundColor = kColor_background
        v.layer.cornerRadius = 5
        v.delegate = self
        return v
    }()
    lazy var uplaodBtn: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.titleLabel?.font = kFont_text
        b.setTitle("上传", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(upload(sender:)), for: .touchUpInside)
        return b
    }()
    
    //上传
    lazy var uploadManager: VODUploadSVideoClient = {
        let c = VODUploadSVideoClient.init()
        c.delegate = self
        return c
    }()
    
    public required convenience init(url: URL) {
        self.init()
        let avPlayer = AVPlayer.init(url: url)
        avPlayerVC.player = avPlayer
        addChild(avPlayerVC)
        view.addSubview(avPlayerVC.view)
        view.addSubview(countLabel)
        view.addSubview(contentTV)
        view.addSubview(uplaodBtn)
        avPlayerVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(220 * KScreenRatio_6)
        }
        countLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.left.equalToSuperview()
            make.top.equalTo(avPlayerVC.view.snp.bottom).offset(15 * KScreenRatio_6)
        }
        contentTV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 345 * KScreenRatio_6, height: 150 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(countLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        uplaodBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(contentTV.snp.bottom).offset(30 * KScreenRatio_6)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "视频上传"
        
    }
    
    @objc func upload(sender: UIButton) {
        
    }
    
}

extension PVPlayVideoUploadVC: YYTextViewDelegate {
    func textViewDidChange(_ textView: YYTextView) {
        guard textView.hasText else {
            countLabel.text = "0/\(30)"
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            
            guard textView.markedTextRange == nil else { return }
            
            if textView.hasText {
                if textView.text.count > 30 {
                    self.view.makeToast("超出字数限制")
                    textView.text = String(textView.text.prefix(30))
                    return
                }
            }
            let current = "\(textView.text.count)"
            let total = "/\(30)"
            self.countLabel.text = current + total
        }
    }
}

extension PVPlayVideoUploadVC: VODUploadSVideoClientDelegate {
    //上传成功
    func uploadSuccess(with result: VodSVideoUploadResult!) {
        
    }
    
    //上传失败
    func uploadFailed(withCode code: String!, message: String!) {
        
    }
    
    //上传进度
    func uploadProgress(withUploadedSize uploadedSize: Int64, totalSize: Int64) {
        
    }
    
    //token过期
    func uploadTokenExpired() {
        
    }
    
    //上传开始重试
    func uploadRetry() {
        
    }
    
    //上传结束重试，继续上传
    func uploadRetryResume() {
        
    }
    
    
}
