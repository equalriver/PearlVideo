//
//  PVPlayPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/20.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVideoSDKPro
import SVProgressHUD

//MARK: - action
extension PVPlayVC {
    
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
        if recorder.isRecording {
            recorder.stopRecording()
            stopPreview()
            isSuspend = true
            cameraView.resetRecordButtonUI()
            cameraView.recordAction(sender: cameraView.recordBtn)
        }
        if recorder.cameraPosition == .back {
            recorder.switchTorch(with: .off)
            cameraView.flashButton.isSelected = false
        }
    }
    
    //进入前台
    @objc func appDidBecomeActive(sender: Notification) {
        if recorder.isRecording {
            recorder.stopRecording()
            stopPreview()
            isSuspend = true
            cameraView.resetRecordButtonUI()
            cameraView.recordAction(sender: cameraView.recordBtn)
        }
        if isSuspend {
            isSuspend = false
            startPreview()
        }
        cameraView.hide = false
        cameraView.resetRecordButtonUI()
        cameraView.isRecording = false
        cameraView.realVideoCount = clipManager.partCount
        
    }
    
    func stopPreview() {
        if isPreviewing {
            recorder.stopPreview()
            isPreviewing = false
        }
    }
    
    func startPreview() {
        if isPreviewing == false {
            SVProgressHUD.show(withStatus: "正在准备中...")
            DispatchQueue.global().async {
                self.recorder.startPreview(withPositon: self.currentCameraPosition)
                DispatchQueue.main.async {
                    if self.recorder.cameraPosition == .front {
                        self.cameraView.flashButton.isSelected = false
                    }
                    self.isPreviewing = true
                    self.cameraView.resetRecordButtonUI()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                    SVProgressHUD.dismiss()
                })
            }
            
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
            if cameraView.isRecording {
                cameraView.recordAction(sender: cameraView.recordBtn)
            }
            cameraView.hide = false
        }
    }
    
    //当录至最大时长时回调
    func recorderDidStopWithMaxDuration() {
        cameraView.finishButton.isEnabled = recorder.cameraPosition == .back
        cameraView.progressView.videoCount += 1
        cameraView.progressView.isShowBlink = false
        recorder.finishRecording()
        
    }
    
    //录制异常
    func recoderError(_ error: Error!) {
        cameraView.hide = false
        cameraView.resetRecordButtonUI()
        cameraView.isRecording = false
        cameraView.realVideoCount = clipManager.partCount
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
            cameraView.resetRecordButtonUI()
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
        startPreview()
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
        if let output_Path = recorder.outputPath {
            let url = URL.init(fileURLWithPath: output_Path)
            let vc = PVPlayVideoUploadVC.init(url: url)
            navigationController?.pushViewController(vc, animated: true)
        }
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
    
    //本地视频
    func didSelectedLocalVideo() {
        stopPreview()
        YPJOtherTool.ypj.getCameraAuth(target: self, {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.mediaTypes = ["public.movie"]
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        })
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

//MARK: - Image Picker Controller Delegate
extension PVPlayVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[.mediaURL] as? URL {
            picker.dismiss(animated: true) {
                DispatchQueue.main.async {
                    let vc = PVPlayVideoUploadVC.init(url: url)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
}
