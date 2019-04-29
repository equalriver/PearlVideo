//


import Foundation

class PVBottomLineTextField: UITextField {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(kColor_background!.cgColor)
            context.fill(CGRect.init(x: -5, y: self.height - 0.5, width: self.width + 5, height: 0.5))
        }
    }
    
    
}
