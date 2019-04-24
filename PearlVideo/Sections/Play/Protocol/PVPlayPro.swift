//
//  PVPlayPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/20.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVideoSDKPro

//MARK: - action
extension PVPlayVC {
    
    func loadData() {
        
    }
    
    //清除之前生成的录制路径
    func clearLocalRecordCache() {
        try? FileManager.default.removeItem(atPath: outputPath)
        try? FileManager.default.createDirectory(atPath: outputPath, withIntermediateDirectories: true, attributes: nil)
    }
    
    //根据要求设置录制view的大小
    func updateUIWithVideoSize(videoSize: CGSize) {
        let r = videoSize.width / videoSize.height
        //是否是9：16的比例
        //        let top = (r - 9 / 16.0) < 0.01
        
        let y = r == 1 ? kNavigationBarAndStatusHeight - 20 : kNavigationBarAndStatusHeight - 44 - 20
        
        let preFrame = CGRect.init(x: 0, y: y, width: kScreenWidth, height: kScreenWidth / r)
        
        UIView.animate(withDuration: 0.2) {
            self.cameraView.previewView.frame = preFrame
        }
        //        y = cameraView.previewView.frame.origin.y
    }
    
    //添加手势
    func addGesture() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapToFocusPoint(sender:)))
        recorder.preview.addGestureRecognizer(tap)
        
        let pinch = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchGesture(sender:)))
        recorder.preview.addGestureRecognizer(pinch)
        
    }
    
    //点按手势的触发方法
    @objc func tapToFocusPoint(sender: UITapGestureRecognizer) {
        guard let v = sender.view else { return }
        let p = sender.location(in: v)
        recorder.focusPoint = p
    }
    
    //捏合手势的触发方法
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        if sender.velocity.isNaN || sender.numberOfTouches != 2 {
            return
        }
        recorder.videoZoomFactor = sender.velocity
        sender.scale = 1
    }
    
    //进入后台
    @objc func appWillResignActive(sender: Notification) {
        
    }
    
    //进入前台
    @objc func appDidBecomeActive(sender: Notification) {
        
    }
    
    func stopPreview() {
        if isPreviewing {
            recorder.stopPreview()
            isPreviewing = false
        }
    }
    
    func startPreview() {
        if isPreviewing == false {
            recorder.startPreview(withPositon: currentCameraPosition)
            if recorder.cameraPosition == .front {
                cameraView.flashButton.isSelected = false
            }
            isPreviewing = true
        }
    }
    
    
}



//MARK: - AliyunIRecorderDelegate
extension PVPlayVC: AliyunIRecorderDelegate {
    //设备权限
    func recorderDeviceAuthorization(_ status: AliyunIRecorderDeviceAuthor) {
        if status == .audioDenied {
            YPJOtherTool.ypj.gotoAuthorizationView(type: "麦克风", vc: self)
        }
        else if status == .videoDenied {
            YPJOtherTool.ypj.gotoAuthorizationView(type: "摄像头", vc: self)
        }
        
    }
    
    //录制实时时长
    func recorderVideoDuration(_ duration: CGFloat) {
        DispatchQueue.main.async {
            self.cameraView.recordingPercent(percent: duration)
            self.recordingDuration = duration
        }
    }
    
    //停止录制回调
    func recorderDidStopRecording() {
        upVideoCount = clipManager.partCount
        cameraView.finishButton.isEnabled = recordingDuration >= recordMinTime
    }
    
    //结束录制回调
    func recorderDidFinishRecording() {
        stopPreview()
        if isSuspend == false {
            
        }
    }
    
}

//MARK: - camera view delegate
extension PVPlayVC: PVPlayCameraDelegate {
    //开始录制
    func didStartRecord() {
        downTime = CFAbsoluteTimeGetCurrent()
        downVideoCount = clipManager.partCount
        let code = recorder.startRecording()
        if code == 0 {
            cameraView.hide = true
        }
        else {
            cameraView.hide = false
            cameraView.progressView.videoCount -= 1
            cameraView.recordBtn.transform = .identity
            cameraView.recordBtn.isSelected = false
            cameraView.isRecording = false
            cameraView.realVideoCount = clipManager.partCount
        }
        
    }
    
    //暂停录制
    func didPauseRecord() {
        recorder.stopRecording()
        upTime = CFAbsoluteTimeGetCurrent()
        cameraView.hide = false
    }
    
    //回删
    func didSelectedDelete() {
        clipManager.deletePart()
        cameraView.progressView.videoCount -= 1
        cameraView.recordingPercent(percent: clipManager.duration)
        recordingDuration = clipManager.duration
        cameraView.finishButton.isEnabled = clipManager.partCount != 0
        cameraView.finishButton.isEnabled = recordingDuration >= recordMinTime
    }
    
    //完成
    func didSelectedFinish() {
        stopPreview()
        guard clipManager.partCount > 0 else { return }
        recorder.finishRecording()
        cameraView.hide = false
    }
    
    //切换摄像头
    func didSelectedSwitch() {
        recorder.switchCameraPosition()
        currentCameraPosition = recorder.cameraPosition
        cameraView.flashButton.isEnabled = recorder.cameraPosition != .front
        let mode = recorder.torchMode
        cameraView.flashButton.isSelected = mode != .off
     
    }
    
    //闪光灯
    func didSelectedFlash(sender: UIButton) {
        if recorder.cameraPosition == .front { return }
        
        if recorder.torchMode == .off {
            recorder.switchTorch(with: .on)
            sender.isSelected = true
        }
        else {
            recorder.switchTorch(with: .off)
            sender.isSelected = false
        }
        
    }
    
    func didSelectedDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UIGestureRecognizerDelegate
extension PVPlayVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
