//
//  PVHomePlayVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/20.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVideoSDKPro

class PVPlayVC: PVBaseNavigationVC {
    
    let recordMaxTime: CGFloat = 10 //视频最大时长
    let recordMinTime: CGFloat = 2 //视频最小时长

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
        let r = AliyunIRecorder.init(delegate: self, videoSize: CGSize.init(width: 720, height: 1280)) ?? AliyunIRecorder()
        r.frontCaptureSessionPreset = "AVCaptureSessionPreset960x540" //前置摄像头采集分辨率
        r.encodeMode = 1 //编码方式 0软编  1硬编 iOS强制硬编
        r.videoQuality = .hight //视频质量
        let d = Date().timeIntervalSince1970.description
        r.outputPath = outputPath + "/\(d)" + ".mp4"//视频的输出路径
        r.taskPath = outputPath + "/\(d.ypj.MD5)" + ".mp4"
        r.beautifyStatus = true
//        r?.preview =
        
        return r
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //清除之前生成的录制路径
    func clearLocalRecordCache() {
        try? FileManager.default.removeItem(atPath: outputPath)
        try? FileManager.default.createDirectory(atPath: outputPath, withIntermediateDirectories: true, attributes: nil)
    }
    
}
