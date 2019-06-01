//
//  PVPlayVideoUploadVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/19.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AVKit
import SVProgressHUD

class PVPlayVideoUploadVC: PVBaseNavigationVC {
    
    
    private var url: URL!
    
    private var uploadAuth: String?
    
    private var uploadAddress: String?
    
    
    lazy var avPlayerVC: AVPlayerViewController = {
        let vc = AVPlayerViewController.init()
        vc.videoGravity = .resizeAspectFill
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
        v.textColor = UIColor.white
        v.placeholderTextColor = kColor_subText
        v.placeholderText = "写下此刻的想法"
        v.backgroundColor = kColor_background
        v.delegate = self
        return v
    }()
    lazy var uplaodBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = kColor_pink
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.titleLabel?.font = kFont_text
        b.setTitle("上传", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(upload(sender:)), for: .touchUpInside)
        return b
    }()
    
    //上传
    lazy var uploadManager: VODUploadClient = {
        let c = VODUploadClient.init()
        c.setListener(listener)
        return c
    }()
    lazy var listener: VODUploadListener = {
        let l = VODUploadListener.init()
        return l
    }()
    
    public required convenience init(url: URL) {
        self.init()
        self.url = url
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
        setupUploadListener()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //设置上传回调
    func setupUploadListener() {
        //开始上传回调
        listener.started = {[weak self] (fileInfo) in
            // fileInfo 上传文件信息
            self?.uploadManager.setUploadAuthAndAddress(fileInfo, uploadAuth: self?.uploadAuth, uploadAddress: self?.uploadAddress)
        }
        
        //token过期回调
        listener.expire = {[weak self] in
            self?.uploadManager.resume(withAuth: self?.uploadAuth)
        }
        
        //上传完成回调
        listener.finish = {[weak self] (fileInfo, result) in
            // fileInfo 上传文件信息
            // result 上传结果信息
            if let info: UploadFileInfo = fileInfo {
                if info.state == .success {
                    SVProgressHUD.showSuccess(withStatus: "上传成功")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self?.navigationController?.dismiss(animated: true, completion: nil)
                    })
                }
                if info.state == .failure {
                    SVProgressHUD.dismiss()
                    self?.uploadManager.stop()
                    self?.uplaodBtn.isEnabled = true
                }
            }
            if let result: VodUploadResult = result {
                print(result)
            }
        }
        
        //上传失败回调
        listener.failure = {[weak self] (fileInfo, code, message) in
            // fileInfo 上传文件信息
            // code 错误码
            // message 错误描述
            self?.uplaodBtn.isEnabled = true
            SVProgressHUD.showError(withStatus: message)
        
        }
        
    }
    
    @objc func upload(sender: UIButton) {
        guard contentTV.hasText else {
            view.makeToast("请写一些此刻的想法")
            return
        }
        guard let p = url.path.components(separatedBy: "/").last else { return }
        sender.isEnabled = false
        SVProgressHUD.show(withStatus: "正在上传...")
        PVNetworkTool.Request(router: .getUploadAuthAndAddress(description: contentTV.text, fileName: p), success: { (resp) in
            if let auth = resp["result"]["uploadAuth"].string {
                self.uploadAuth = auth
            }
            if let address = resp["result"]["uploadAddress"].string {
                self.uploadAddress = address
            }
            let vodInfo = VodInfo.init()
            vodInfo.title = self.contentTV.text
            self.uploadManager.addFile(self.url.path, vodInfo: vodInfo)
            self.uploadManager.start()
         
        }) { (e) in
            SVProgressHUD.dismiss()
            sender.isEnabled = true
        }
        
    }
    
    //获取视频第一帧图片
    func getVideoPreviewImage(url: URL) -> UIImage? {
        let asset = AVURLAsset.init(url: url)
        let assetGen = AVAssetImageGenerator.init(asset: asset)
        assetGen.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
        var actualTime = CMTime.init()
        do {
            let image = try assetGen.copyCGImage(at: time, actualTime: &actualTime)
            let videoImg = UIImage.init(cgImage: image)
            
            return videoImg
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getVideoFileSize(url: URL) -> Int? {
        if let fileSize = try? FileManager.default.attributesOfItem(atPath: url.path) {
            let size = fileSize[.size] as? Int
            return size
        }
        return nil
    }
    
    func getVideoTime(url: URL) -> Double {
        let asset = AVURLAsset.init(url: url)
        let time = asset.duration
        let t = Double(time.value / Int64(time.timescale))
        let seconds = ceil(t)
        return seconds
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


