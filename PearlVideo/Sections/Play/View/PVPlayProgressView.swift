//
//  PVPlayProgressView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/22.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVPlayProgressView: UIView {
    
    public var videoCount = 0 {
        didSet{
            if oldValue < videoCount {
                pointArray.append(progress)
            }
            else {
                if pointArray.count > 0 { pointArray.removeLast() }
            }
            videoCount = videoCount < 0 ? 0 : videoCount
            selectedIndex = -1
        }
    }
    
    public var selectedIndex = -1
    
    public var isShowBlink = false {
        didSet{
            timer?.invalidate()
            timer = nil
            if isShowBlink { startTimer() }
        }
    }
    
    public var isShowNoticePoint = false
    
    public var minDuration: CGFloat = 0
    
    public var maxDuration: CGFloat = 0
    
    public var pointArray = [CGFloat]()
    
    public var progressColor = kColor_pink!
    
    public var selectedColor = UIColor.red
    
    public var noticeColor = UIColor.white
    
    public var separatorColor = UIColor.white
    
    
    
    private var progress: CGFloat = 0
    
    private var times = 0
    
    private var timer: Timer?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    
    override func draw(_ rect: CGRect) {
        guard superview != nil else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(height * UIScreen.main.scale)
        
        for i in 0..<videoCount {
            if i == selectedIndex {
                context.setStrokeColor(selectedColor.cgColor)
            }
            else {
                context.setStrokeColor(progressColor.cgColor)
            }
            let sp = pointArray[i]
            var x = sp / maxDuration * superview!.width
            context.move(to: CGPoint.init(x: x, y: 0))
            x = progress / maxDuration * superview!.width
            context.addLine(to: CGPoint.init(x: x, y: 0))
            context.strokePath()
        
        }
        for i in 0..<pointArray.count {
            let p = pointArray[i]
            context.setStrokeColor(separatorColor.cgColor)
            let x = p / maxDuration * superview!.width
            context.move(to: CGPoint.init(x: x - 1, y: 0))
            context.addLine(to: CGPoint.init(x: x, y: 0))
            context.strokePath()
        }
        if isShowNoticePoint && isShowNotice() {
            context.setStrokeColor(noticeColor.cgColor)
            context.move(to: CGPoint.init(x: superview!.width * minDuration / maxDuration, y: 0))
            context.addLine(to: CGPoint.init(x: superview!.width * minDuration / maxDuration + 1, y: 0))
            context.strokePath()
        }
        isShowBlink ? times += 1 : (times = 1)
        if isShowBlink && times > 0 && times % 2 == 1 {
            let x = endPointX()
            context.setStrokeColor(UIColor.green.cgColor)
            context.move(to: CGPoint.init(x: x + 0.5, y: 0))
            context.addLine(to: CGPoint.init(x: x + 4, y: 0))
            context.strokePath()
        }
    }
    
    
    public func updateProgress(progress: CGFloat) {
        self.progress = progress
        setNeedsDisplay()
    }
    
    public func reset() {
        videoCount = 0
        pointArray.removeAll()
        updateProgress(progress: 0)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setNeedsDisplay(_:)), userInfo: nil, repeats: true)
        timer?.fire()
    }

    private func isShowNotice() -> Bool {
        return progress < minDuration
    }
    
    private func endAngle() -> CGFloat {
        return progress / maxDuration * CGFloat.pi * 2 + CGFloat.pi * 1.5
    }
    
    private func endPointX() -> CGFloat {
        return progress / maxDuration * width
    }

    
    
}



