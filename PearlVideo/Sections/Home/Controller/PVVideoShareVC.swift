//
//  PVVideoShareVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/28.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

class PVVideoShareVC: PVBaseNavigationVC {
    
    var data = PVVideoShareModel() {
        didSet{
            avatarIV.kf.setImage(with: URL.init(string: data.avatarImageUrl))
            nameLabel.text = """
                             我是\(data.nickname)
                             我为福音代言
                             """
            
        }
    }
    
    var inviteCode = "" {
        didSet{
            inviteLabel.text = "邀请码：\(inviteCode)"
        }
    }
    
    lazy var contentIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "video_share_bg"))
        v.isUserInteractionEnabled = true
        return v
    }()
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 25 * KScreenRatio_6
        v.layer.masksToBounds = true
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.numberOfLines = 2
        return l
    }()
    lazy var inviteLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white
        l.font = kFont_btn_weight
        return l
    }()
    lazy var qrcodeIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var copyBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.clear
        b.titleLabel?.font = kFont_text_weight
        b.setTitle("复制链接", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(copyAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var shareBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.white
        b.titleLabel?.font = kFont_text_weight
        b.setTitle("分享", for: .normal)
        b.setTitleColor(kColor_pink, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(shareAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "分享"
        initUI()
        loadData()
    }
    
    func initUI() {
        view.addSubview(contentIV)
        contentIV.addSubview(avatarIV)
        contentIV.addSubview(nameLabel)
        contentIV.addSubview(inviteLabel)
        contentIV.addSubview(qrcodeIV)
        contentIV.addSubview(copyBtn)
        contentIV.addSubview(shareBtn)
        contentIV.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.left.equalToSuperview().offset(30 * KScreenRatio_6)
            make.top.equalToSuperview().offset(335 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV.snp.right).offset(10 * KScreenRatio_6)
            make.centerY.equalTo(avatarIV)
            make.right.equalTo(qrcodeIV.snp.left).offset(-20)
        }
        inviteLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV)
            make.top.equalTo(avatarIV.snp.bottom).offset(20 * KScreenRatio_6)
        }
        qrcodeIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100 * KScreenRatio_6, height: 100 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-30 * KScreenRatio_6)
            make.top.equalToSuperview().offset(330 * KScreenRatio_6)
        }
        copyBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 320 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(qrcodeIV.snp.bottom).offset(30 * KScreenRatio_6)
        }
        shareBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(copyBtn)
            make.top.equalTo(copyBtn.snp.bottom).offset(10)
        }
    }
    
    @objc func copyAction(sender: UIButton) {
        guard inviteCode.count > 0 else { return }
        let p = UIPasteboard.init()
        p.string = inviteCode
        view.makeToast("已复制")
    }
    
    @objc func shareAction(sender: UIButton) {
        let v = PVVideoShareAlert.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        v.delegate = self
        view.addSubview(v)
    }
    
    func loadData() {
        PVNetworkTool.Request(router: .getInviteCode(), success: { (resp) in
            if let d = Mapper<PVVideoShareModel>().map(JSONObject: resp["result"]["userInviteResult"].object) {
                self.data = d
            }
            if let code = resp["result"]["inviteCode"].string {
                self.inviteCode = code
            }
            
        }) { (e) in
            
        }
    }
    
}

extension PVVideoShareVC: PVVideoShareAlertDelegate {
    
    func alertDidShow() {
        copyBtn.isHidden = true
        shareBtn.isHidden = true
    }
    
    func alertDidDismiss() {
        copyBtn.isHidden = false
        shareBtn.isHidden = false
    }
    
    func didSelectedSharePlatform(type: PVVideoSharePlatformType) {
        func wechatShareImage(type: PVVideoSharePlatformType) {
            guard let img = contentIV.ypj.screenshot() else { return }
            guard let data = img.ypj.compressImage(maxLength: 9 * 1024 * 1024) else { return }
            let imgObj = WXImageObject.init()
            imgObj.imageData = data
            let msg = WXMediaMessage.init()
            msg.mediaObject = imgObj
            let req = SendMessageToWXReq.init()
            req.bText = false
            req.message = msg
            if type == .moments { req.scene = Int32(WXSceneTimeline.rawValue) }
            if type == .weixin { req.scene = Int32(WXSceneSession.rawValue) }
            WXApi.send(req)
        }
        
        switch type {
        case .moments, .weixin:
            wechatShareImage(type: type)
            break
            
        default:
            view.makeToast("暂未开放")
            break
        }
        
        
        
    }
    
}
