//
//  PVPlayCameraView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/20.
//  Copyright © 2019 equalriver. All rights reserved.
//


protocol PVPlayCameraDelegate: NSObjectProtocol {
    //开始录制
    func didStartRecord()
    //暂停录制
    func didPauseRecord()
    //删除
    func didSelectedDelete()
    //下一步
    func didSelectedFinish()
    //摄像头切换
    func didSelectedSwitch()
    //闪光灯
    func didSelectedFlash(sender: UIButton)
    //本地视频
    func didSelectedLocalVideo()
    
    func didSelectedDismiss()
}

class PVPlayCameraView: UIView {
    
    weak public var delegate: PVPlayCameraDelegate?
    
    public var hide = false {
        willSet{
            topView.isHidden = newValue
            deleteBtn.isHidden = newValue
            finishButton.isHidden = newValue
            localVideoBtn.isHidden = true
        }
    }
    
    //最大时间
    var maxDuration: CGFloat = 0 {
        didSet{
            progressView.maxDuration = maxDuration
        }
    }
    
    //最小时间
    var minDuration: CGFloat = 0 {
        didSet{
            progressView.minDuration = minDuration
        }
    }
    
    //准确的视频个数
    var realVideoCount = 0
    
    //手指按下录制按钮的时间
    var startTime = 0
    
    //是否正在录制
    var isRecording = false
    
    
    
    //预览view
    lazy var previewView: UIView = {
        let v = UIView()
        return v
    }()
    //闪光灯按钮
    lazy var flashButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "shortVideo_noLight"), for: .normal)
        b.setImage(UIImage.init(named: "shortVideo_onLight"), for: .selected)
        b.addTarget(self, action: #selector(flashAction(sender:)), for: .touchUpInside)
        return b
    }()
    //进度条
    lazy var progressView: PVPlayProgressView = {
        let v = PVPlayProgressView.init(frame: .zero)
        v.isShowBlink = false
        v.isShowNoticePoint = true
        v.backgroundColor = UIColor.init(white: 0, alpha: 0.01)
        return v
    }()
    lazy var finishButton: ImageTopButton = {
        let b = ImageTopButton()
        b.isHidden = true
        b.isExclusiveTouch = true
        b.setImage(UIImage.init(named: "play_下一步"), for: .normal)
        b.titleLabel?.font = kFont_text_2
        b.setTitle("下一步", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(finishAction(sender:)), for: .touchUpInside)
        return b
    }()
    //录制按钮
    lazy var recordBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.clear
        b.setImage(UIImage.init(named: "play_record"), for: .normal)
        b.setImage(UIImage.init(named: "play_暂停"), for: .selected)
        b.addTarget(self, action: #selector(recordAction(sender:)), for: .touchUpInside)
        return b
    }()
    //本地视频
    lazy var localVideoBtn: UIButton = {
        let b = UIButton()
        b.isExclusiveTouch = true
        b.backgroundColor = UIColor.clear
        b.setImage(UIImage.init(named: "video_相册"), for: .normal)
        b.addTarget(self, action: #selector(localVideo(sender:)), for: .touchUpInside)
        return b
    }()
    //顶部view
    lazy var topView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }()
    private lazy var backButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "play_dismiss"), for: .normal)
        b.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return b
    }()
    private lazy var switchBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "play_转换"), for: .normal)
        b.addTarget(self, action: #selector(switchAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var deleteBtn: UIButton = {
        let b = UIButton()
        b.isHidden = true
        b.isExclusiveTouch = true
        b.setImage(UIImage.init(named: "play_删除"), for: .normal)
        b.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return b
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(previewView)
        addSubview(topView)
        topView.addSubview(backButton)
        topView.addSubview(flashButton)
        topView.addSubview(switchBtn)
        addSubview(deleteBtn)
        addSubview(progressView)
        addSubview(recordBtn)
        addSubview(finishButton)
        addSubview(localVideoBtn)
        previewView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        topView.snp.makeConstraints { (make) in
            make.top.width.centerX.equalToSuperview()
            make.height.equalTo(kNavigationBarAndStatusHeight)
        }
        backButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.bottom.equalToSuperview().offset(-5)
        }
        switchBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.size.bottom.equalTo(backButton)
        }
        flashButton.snp.makeConstraints { (make) in
            make.right.equalTo(switchBtn.snp.left).offset(-30 * KScreenRatio_6)
            make.size.bottom.equalTo(backButton)
        }
        progressView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 5))
            make.centerX.top.equalToSuperview()
        }
        recordBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 90 * KScreenRatio_6, height: 90 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kTabBarHeight)
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.right.equalTo(recordBtn.snp.left).offset(-50 * KScreenRatio_6)
            make.centerY.equalTo(recordBtn)
        }
        finishButton.snp.makeConstraints { (make) in
            make.left.equalTo(recordBtn.snp.right).offset(50 * KScreenRatio_6)
            make.centerY.equalTo(recordBtn)
        }
        localVideoBtn.snp.makeConstraints { (make) in
            make.right.equalTo(recordBtn.snp.left).offset(-50 * KScreenRatio_6)
            make.centerY.equalTo(recordBtn)
        }
    }
    
    
}

