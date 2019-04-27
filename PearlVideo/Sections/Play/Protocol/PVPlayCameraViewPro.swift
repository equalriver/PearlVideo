//
//  PVPlayCameraViewPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/23.
//  Copyright © 2019 equalriver. All rights reserved.
//

extension PVPlayCameraView {
    
    //刷新进度条的进度
    public func recordingPercent(percent: CGFloat) {
        progressView.updateProgress(progress: percent)
        if percent == 0 {
            progressView.reset()
            hide = true
        }
    }
    
    //重制录制按钮
    public func resetRecordButtonUI() {
        recordBtn.isSelected = false
        recordBtn.transform = .identity
    }
    
    //闪光灯
    @objc func flashAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.didSelectedFlash(sender: sender)
    }
    
    @objc func finishAction(sender: UIButton) {
        delegate?.didSelectedFinish()
    }
    
    //录制
    @objc func recordAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        topView.isHidden = sender.isSelected
        deleteBtn.isHidden = sender.isSelected
        finishButton.isHidden = sender.isSelected
        isRecording = sender.isSelected
        if isRecording == false {
            endRecord()
            sender.transform = .identity
        }
        else {
            sender.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            delegate?.didStartRecord()
        }
       
    }
    
    @objc func dismissAction() {
        delegate?.didSelectedDismiss()
    }
    
    //摄像头切换
    @objc func switchAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.didSelectedSwitch()
    }
    
    //回删
    @objc func deleteAction() {
        delegate?.didSelectedDelete()
    }
    
    func endRecord() {
        startTime = 0
        delegate?.didPauseRecord()
        progressView.isShowBlink = false
        deleteBtn.isEnabled = true
        if progressView.videoCount > 0 {
            deleteBtn.isHidden = false
        }
    }
    
}
