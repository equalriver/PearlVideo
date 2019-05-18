//
//  PVHomePlayVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/20.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVideoSDKPro

class PVPlayVC: PVBaseViewController {
    
    let recordMaxTime: CGFloat = 10 //视频最大时长
    let recordMinTime: CGFloat = 2 //视频最小时长
    
    ///输出大小
    let outputSize = CGSize.init(width: 720, height: 1280)
    
    ///最新的摄像头位置（前置还是后置）
    var currentCameraPosition: AliyunIRecorderCameraPosition = .front
    
    ///开始录制时间
    var downTime: Double = 0
   
    ///结束录制时间
    var upTime: Double = 0
    
    ///开始录制视频段数
    var downVideoCount = 0
    
    ///结束录制视频段数
    var upVideoCount = 0

    ///录制时间
    var recordingDuration: CGFloat = 0
    
    ///APP是否处于悬挂状态
    var isSuspend = false
    
    var isNeedStopPreview = false
    
    var isPreviewing = false
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    lazy var outputPath: String = {
        var s = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? "\(NSHomeDirectory())/Library/Caches"
        s += "/record"
        return s
    }()
    //视频片段管理器
    lazy var clipManager: AliyunClipManager = {
        let c = recorder.clipManager ?? AliyunClipManager.init()
        c.maxDuration = recordMaxTime
        c.minDuration = recordMinTime
        return c
    }()
    lazy var recorder: AliyunIRecorder = {
        let r = AliyunIRecorder.init(delegate: self, videoSize: outputSize) ?? AliyunIRecorder()
        r.frontCaptureSessionPreset = "AVCaptureSessionPreset960x540" //前置摄像头采集分辨率
        r.encodeMode = 1 //编码方式 0软编  1硬编 iOS强制硬编
        r.videoQuality = .hight //视频质量
        let d = Date().timeIntervalSince1970.description
        r.outputPath = outputPath + "/\(d)" + ".mp4"//视频的输出路径
        r.taskPath = outputPath + "/\(d.ypj.MD5)" + ".mp4"
        r.beautifyStatus = true
        r.preview = cameraView.previewView

        return r
    }()
    lazy var cameraView: PVPlayCameraView = {
        let v = PVPlayCameraView.init(frame: .zero)
        v.backgroundColor = UIColor.white
        v.minDuration = recordMinTime
        v.maxDuration = recordMaxTime
        v.delegate = self
        return v
    }()
    lazy var reachability: YYReachability = {
        let r = YYReachability.init()
        return r
    }()
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        view.addSubview(cameraView)
        cameraView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive(sender:)), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive(sender:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        updateUIWithVideoSize(videoSize: outputSize)
        clearLocalRecordCache()
        addGesture()
        reachability.notifyBlock = {[weak self] (reach) in
            switch reach.status {
            case .none:
                self?.view.makeToast("请检查网络连接")
                
            case .WWAN:
                self?.view.makeToast("当前使用手机网络,请注意流量消耗")
                
            default:
                break
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startPreview()
        isNeedStopPreview = true
        cameraView.finishButton.isEnabled = recordingDuration >= recordMinTime
        cameraView.flashButton.isSelected = false
        //录制模块禁止自动熄屏
        UIApplication.shared.isIdleTimerDisabled = true
        
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isNeedStopPreview { stopPreview() }
        UIApplication.shared.isIdleTimerDisabled = false
        
    }

    deinit {
        recorder.destroy()
        NotificationCenter.default.removeObserver(self)
        stopPreview()
    }

    
    
    
}
