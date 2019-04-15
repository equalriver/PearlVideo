//
//  YPJExTools.swift


import Foundation
import UIKit
import ObjectMapper
import CommonCrypto

public protocol YPJToolable {
    
    associatedtype YPJToolType
    var ypj: YPJToolType { get }
}

//MARK: - view tools
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
    func addCornerShape(rect: CGRect, cornerRadius: CGFloat, fillColor: UIColor) {
        let p = UIBezierPath()
        
        let sl = CAShapeLayer()
        sl.fillRule = .evenOdd
        sl.fillColor = fillColor.cgColor
        sl.frame = rect
        
        p.append(UIBezierPath.init(rect: rect))
        p.append(UIBezierPath.init(roundedRect: rect, cornerRadius: cornerRadius))
        sl.path = p.cgPath
        self.ypj.layer.addSublayer(sl)
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

//MARK: - string tools
public struct YPJStringTools<T>: YPJToolable {
    
    public let ypj: T
    
    public init(target: T) {
        self.ypj = target
    }
}

extension String: YPJToolable {
    
    public var ypj: YPJStringTools<String> {
        return YPJStringTools.init(target: self)
    }
}

extension YPJStringTools where YPJToolType == String {
    
    ///获取string高度
    func getStringHeight(font: UIFont, width: CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = ypj as NSString
        let size = CGSize.init(width: width, height: 900)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : AnyObject], context: nil).size
        return strSize.height
    }
    
    ///获取string宽度
    func getStringWidth(font: UIFont, height: CGFloat) -> CGFloat {
        let statusLabelText: NSString = ypj as NSString
        let size = CGSize.init(width: 900, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : AnyObject], context: nil).size
        return strSize.width
    }
    
    ///获取string  size
    func getStringSize(font: UIFont, height: CGFloat) -> CGSize {
        let statusLabelText: NSString = ypj as NSString
        let size = CGSize.init(width: 900, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : AnyObject], context: nil).size
        return strSize
    }
    
    ///汉字转拼音(耗性能，谨慎使用)
    func transformToPinYin() -> String {
        let mutableString = NSMutableString(string: ypj)
        //先转换为带声调的拼音
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        //再转换为不带声调的拼音
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        //返回小写拼音
        let string = String(mutableString).lowercased()
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    ///json转字典
    func getDictionaryFromJSONString() -> Dictionary<String, Any> {
        
        let jsonData: Data = ypj.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! Dictionary
        }
        return Dictionary()
        
    }
    
    ///url to utf-8
    var URL_UTF8_string: String! {
        return ypj.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    /// 判断字符串中是否有中文
    var isIncludeChinese: Bool {
        for ch in ypj.unicodeScalars {
            if (0x4e00 < ch.value  && ch.value < 0x9fff) { return true } // 中文字符范围：0x4e00 ~ 0x9fff
        }
        return false
    }
    
    ///是否全中文
    var isAllChinese: Bool {
        let pattern = "(^[\\u4e00-\\u9fa5]+$)"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///判断字符串中是否为全数字
    var isAllNumber: Bool {
        let pattern = "[0-9]*"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///判断字符中是否包含表情
    var isIncludeEmoji: Bool {
        
        for scalar in ypj.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF:  // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    ///匹配邮箱
    var isEmail: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配手机号
    var isPhoneNumber: Bool {
        let pattern = "^1+[0-9]+\\d{9}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配用户密码6-18位数字和字母组合
    var isPassword: Bool {
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配用户姓名,20位的中文或英文
    var isUserName: Bool {
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配用户身份证号15或18位
    var isUserIdCard: Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配URL
    var isURLString: Bool {
        let pattern = "^[0-9A-Za-z]{1,50}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///sha-256
    var sha256: String {
        func digest(input : NSData) -> NSData {
            let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
            var hash = [UInt8](repeating: 0, count: digestLength)
            CC_SHA256(input.bytes, UInt32(input.length), &hash)
            return NSData(bytes: hash, length: digestLength)
        }
        
        func hexStringFromData(input: NSData) -> String {
            var bytes = [UInt8](repeating: 0, count: input.length)
            input.getBytes(&bytes, length: input.length)
            
            var hexString = ""
            for byte in bytes {
                hexString += String(format:"%02x", UInt8(byte))
            }
            
            return hexString
        }
        
        if let stringData = ypj.data(using: .utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    
}

//MARK: - image tools
public struct YPJImageTools<T>: YPJToolable {
    
    public let ypj: T
    
    public init(target: T) {
        self.ypj = target
    }
}

extension UIImage: YPJToolable {
    
    public var ypj: YPJImageTools<UIImage> {
        return YPJImageTools.init(target: self)
    }
}

extension YPJImageTools where YPJToolType == UIImage {
    
    //MARK: - 图片转成Base64
    ///图片转成Base64字符串
    public var base64String: String {
        let data = ypj.jpegData(compressionQuality: 1.0)
        let str = data?.base64EncodedString() ?? ""
//        let str = data?.base64EncodedString(options: .lineLength64Characters)
        return "data:image/jpeg;base64," + str
    }
    
    //MARK: - 异步绘制圆角
    ///异步绘制圆角
    public func asyncDrawCornerRadius(roundedRect: CGRect, cornerRadius: CGFloat, fillColor: UIColor, callback: @escaping (_ img: UIImage) -> Void) {
        
        DispatchQueue.global().async {
            // 1.利用绘图，建立上下文 - 内存中开辟一个地址，跟屏幕无关!
            /**
             参数：
             1> size: 绘图的尺寸
             2> 不透明：false / true
             3> scale：屏幕分辨率，生成的图片默认使用 1.0 的分辨率，图像质量不好;可以指定 0 ，会选择当前设备的屏幕分辨率
             */
            UIGraphicsBeginImageContextWithOptions(roundedRect.size, true, 0)
            
            // 2.设置被裁切的部分的填充颜色
            fillColor.setFill()
            UIRectFill(roundedRect)
            
            
            // 3.利用 贝塞尔路径 实现 裁切 效果
            // 1>实例化一个圆形的路径
            let path = UIBezierPath.init(roundedRect: roundedRect, cornerRadius: cornerRadius)
            // 2>进行路径裁切 - 后续的绘图，都会出现在圆形路径内部，外部的全部干掉
            path.addClip()
            
            // 4.绘图 drawInRect 就是在指定区域内拉伸屏幕
            self.ypj.draw(in: roundedRect)
            /*
             // 5.绘制内切的圆形
             let ovalPath = UIBezierPath.init(ovalIn: rect)
             ovalPath.lineWidth = 2
             lineColor.setStroke()
             ovalPath.stroke()
             //        UIColor.darkGray.setStroke()
             //        path.lineWidth = 2
             //        path.stroke()
             */
            // 6.取得结果
            let result = UIGraphicsGetImageFromCurrentImageContext()
            
            // 7.关闭上下文
            UIGraphicsEndImageContext()
            
            if result != nil {
                DispatchQueue.main.async {
                    callback(result!)
                }
            }
        }
    }
    
    //MARK: - 绘制图片圆角
    ///绘制图片圆角
    func drawCorner(rect: CGRect, cornerRadius: CGFloat) -> UIImage {
        
        let bezierPath = UIBezierPath.init(roundedRect: rect, cornerRadius: cornerRadius)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            context.addPath(bezierPath.cgPath)
            context.clip()
            self.ypj.draw(in: rect)
            context.drawPath(using: CGPathDrawingMode.fillStroke)
            if let img = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                return img
            }
        }
        return UIImage()
        
    }
    
    //MARK: - 裁剪图片
    ///裁剪图片
    func clipImage(newRect: CGRect) -> UIImage? {
        //将UIImage转换成CGImage
        let sourceImg = self.ypj.cgImage
        
        //按照给定的矩形区域进行剪裁  //cropping以图片px为单位
        guard let newCgImg = sourceImg?.cropping(to: newRect) else { return nil }
        
        //将CGImageRef转换成UIImage
        let newImg = UIImage.init(cgImage: newCgImg)
        
        return newImg
    }
    
    //MARK: - 自适应裁剪
    ///自适应裁剪
    func clipImageToRect(newSize: CGSize) -> UIImage? {
        
        //被切图片宽比例比高比例小 或者相等，以图片宽进行放大
        if self.ypj.size.width * newSize.height <= self.ypj.size.height * newSize.width {
            //以被剪裁图片的宽度为基准，得到剪切范围的大小
            let w = self.ypj.size.width
            let h = self.ypj.size.width * newSize.height / newSize.width
            // 调用剪切方法
            // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
            return self.clipImage(newRect: CGRect.init(x: 0, y: (self.ypj.size.height - h) / 2, width: w, height: h))
        }
        else {//被切图片宽比例比高比例大，以图片高进行剪裁
            // 以被剪切图片的高度为基准，得到剪切范围的大小
            let w = self.ypj.size.height * newSize.width / newSize.height
            let h = self.ypj.size.height
            // 调用剪切方法
            // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
            return self.clipImage(newRect: CGRect.init(x: (self.ypj.size.width - w) / 2, y: 0, width: w, height: h))
        }
        
    }
    
    //MARK: - 压缩图片
    ///压缩图片
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func compressImage(maxLength: Int) -> Data? {
        
        var compress: CGFloat = 0.5
        
        var data = self.ypj.jpegData(compressionQuality: compress)
        
        guard data != nil else { return nil }
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = self.ypj.jpegData(compressionQuality: compress)
        }
        
        return data
    }
    
    //MARK: - 等比例的图片
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func  scaleImage(imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = self.ypj.size.width
        let height = self.ypj.size.height
        
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width){
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    //MARK: - 指定size的图片
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    func resizeImage(newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, true, UIScreen.main.scale)
        self.ypj.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
}





