//
//  YPJViewTools.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/17.
//  Copyright © 2019 equalriver. All rights reserved.
//


public struct YPJViewTools<T>: YPJToolable {
    
    public let ypj: T
    
    public init(target: T) {
        self.ypj = target
    }
}

extension UIView: YPJToolable {
    public var ypj: YPJViewTools<UIView> {
        return YPJViewTools.init(target: self)
    }
}

extension YPJViewTools where YPJToolType == UIView {
    
    //MARK: - 添加渐变色层
    ///添加渐变色层
    func addGradientLayer(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber]?) {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        gradientLayer.frame = ypj.frame
        gradientLayer.mask = ypj.layer
        ypj.layer.frame = gradientLayer.bounds
        if let subLayers = ypj.superview?.layer.sublayers {
            for v in subLayers {
                if v.frame == gradientLayer.frame {
                    v.removeFromSuperlayer()
                }
            }
        }
        ypj.superview?.layer.addSublayer(gradientLayer)
    }
    
    
    //MARK: - 设置圆角mask
    ///设置圆角mask
    func makeViewRoundingMask(roundedRect: CGRect, corners: UIRectCorner, cornerRadii: CGSize) {
        let p = UIBezierPath.init(roundedRect: roundedRect, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let l = CAShapeLayer()
        l.frame = roundedRect
        l.path = p.cgPath
        ypj.layer.mask = l
    }
    
    
    //MARK: - 添加圆角sublayer层
    ///添加圆角sublayer层
    func addCornerShape(rect: CGRect, cornerRadius: CGFloat, fillColor: UIColor = UIColor.white) {
        let p = UIBezierPath()
        
        let sl = CAShapeLayer()
        sl.fillRule = .evenOdd
        sl.fillColor = fillColor.cgColor
        sl.frame = rect
        
        p.append(UIBezierPath.init(rect: rect))
        p.append(UIBezierPath.init(roundedRect: rect, cornerRadius: cornerRadius))
        sl.path = p.cgPath
        if let subLayers = ypj.layer.sublayers {
            for v in subLayers {
                if v.frame == sl.frame {
                    v.removeFromSuperlayer()
                }
            }
        }
        ypj.layer.addSublayer(sl)
    }
    
    //MARK: - 从底部弹出
    ///从底部弹出
    func viewAnimateComeFromBottom(duration: TimeInterval, completion: ((_ isFinished: Bool) -> Void)?) {
        UIView.animate(withDuration: duration, animations: {
            
            var center = self.ypj.center
            center.y -= self.ypj.height
            self.ypj.center = center
            
        }) { (isFinished) in
            completion?(isFinished)
        }
    }
    
    //MARK: - 从底部消失
    ///从底部消失
    func viewAnimateDismissFromBottom(duration: TimeInterval, completion: ((_ isFinished: Bool) -> Void)?) {
        UIView.animate(withDuration: duration, animations: {
            
            var center = self.ypj.center
            center.y += self.ypj.height
            self.ypj.center = center
            
        }) { (isFinished) in
            completion?(isFinished)
        }
    }
    
    //MARK: - 获取指定view的截图
    ///获取指定view的截图
    public func screenImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.ypj.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            self.ypj.layer.render(in: context)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            if img != nil {
                UIGraphicsEndImageContext()
                return img!
            }
        }
        return UIImage()
    }
    
}
